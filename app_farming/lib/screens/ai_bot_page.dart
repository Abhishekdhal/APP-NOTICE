import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AIBotPage extends StatefulWidget {
  const AIBotPage({super.key});

  @override
  State<AIBotPage> createState() => _AIBotPageState();
}

class _AIBotPageState extends State<AIBotPage> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> messages = [];
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  final ImagePicker _picker = ImagePicker();

  bool _isListening = false;
  bool _isLoading = false;

  File? _selectedImage;
  final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? "";

  late GenerativeModel _model;

  @override
  void initState() {
    super.initState();
    if (apiKey.isNotEmpty) {
      _model = GenerativeModel(
        model: "gemini-2.5-flash",
        apiKey: apiKey,
      );
    }
  }

  /// 🔹 Function to send text/image to Gemini
  Future<String> _getAIResponse(String userMessage, {String? base64Image}) async {
    if (apiKey.isEmpty) {
      return "⚠️ Gemini API Key not found. Please configure your .env file.";
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final prompt = Content.multi([
        TextPart(
            "You are Krishi Mitra 🌱, a multilingual AI farming assistant. Farmers may upload crop/soil/pest images. Analyze and give advice in Hindi, Punjabi, Odia, or English."),
        TextPart(userMessage),
        if (base64Image != null)
          DataPart("image/jpeg", base64Decode(base64Image)),
      ]);

      final response = await _model.generateContent([prompt]);

      return response.text ?? "⚠️ No response from Gemini.";
    } catch (e) {
      return "❌ Gemini API error: $e";
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 🔹 Send text or image to Gemini
  void _sendMessage({bool isImage = false}) async {
    if (!isImage && _controller.text.trim().isEmpty) return;

    final userText = _controller.text.trim();
    String? base64Image;

    if (isImage && _selectedImage != null) {
      final bytes = await _selectedImage!.readAsBytes();
      base64Image = base64Encode(bytes);
    }

    setState(() {
      messages.add({
        "role": "user",
        "text": userText.isEmpty ? "📷 Sent an image" : userText
      });
    });

    _controller.clear();

    final botReply = await _getAIResponse(
      userText.isEmpty ? "Analyze this crop/soil image." : userText,
      base64Image: base64Image,
    );

    setState(() {
      messages.add({"role": "bot", "text": botReply});
    });

    await _flutterTts.speak(botReply);

    _selectedImage = null;
  }

  /// 🎤 Voice input
  void _listenVoice() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          if (status == "done") setState(() => _isListening = false);
        },
        onError: (error) {
          setState(() => _isListening = false);
        },
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (result) {
          setState(() {
            _controller.text = result.recognizedWords;
          });
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  /// 📸 Pick image
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      _sendMessage(isImage: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        elevation: 3,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("🌱"),
            ),
            const SizedBox(width: 10),
            const Text("Krishi Mitra",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () => setState(() => messages.clear()),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isUser = msg["role"] == "user";

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.green[400] : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isUser ? 16 : 0),
                        bottomRight: Radius.circular(isUser ? 0 : 16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isUser) ...[
                          const Icon(Icons.smart_toy,
                              color: Colors.green, size: 20),
                          const SizedBox(width: 6),
                        ],
                        Flexible(
                          child: Text(
                            msg["text"] ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              color: isUser ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Thinking", style: TextStyle(fontSize: 14)),
                  SizedBox(width: 5),
                  _TypingDots(),
                ],
              ),
            ),
          if (_selectedImage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(_selectedImage!, height: 120),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedImage = null),
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.black54,
                        child: Icon(Icons.close,
                            color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              color: _isListening ? Colors.red : Colors.green,
            ),
            onPressed: _listenVoice,
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.green),
            onPressed: () => _pickImage(ImageSource.camera),
          ),
          IconButton(
            icon: const Icon(Icons.image, color: Colors.green),
            onPressed: () => _pickImage(ImageSource.gallery),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Ask Krishi Mitra...",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.green),
            onPressed: () => _sendMessage(),
          ),
        ],
      ),
    );
  }
}

/// 🔵 Typing dots animation widget
class _TypingDots extends StatefulWidget {
  const _TypingDots();

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        int index = (_controller.value * 3).floor();
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Opacity(
                opacity: i == index ? 1 : 0.3,
                child: const Text(
                  ".",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
