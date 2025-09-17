import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupplementsPage extends StatelessWidget {
  const SupplementsPage({super.key});

  final List<Map<String, String>> products = const [
    {
      "name": "Organic Fertilizer",
      "image": "assets/images/fertilizer.jpg", // local asset image
      "url": "https://www.amazon.in/Ugaoo-Organic-Vermicompost-Fertilizer-Plants/dp/B0BDVN579S/ref=sr_1_2_sspa?crid=2KP7WKW1IO9MP&dib=eyJ2IjoiMSJ9.QV-0XUcfS9ZGzOzKpmUrYswgL34rCzTOyBHTi1HuiTLb22VRnNRS5e5_dLb9KaWS5p6t9sCPTe6a4QUm-x30NQTKD0iu67lvwy9BbcjV8xb6tgFoE2R2iP_TBGTnt4e1G9l2kYTLVTZjkVI_FNQCSjpA1OaxT5voq8VOweDDX8eHKnEG6acvgeJmTl81_8Wv4YBTNOJAL8LKFyz8EGXiEGk7bVa3K2NWP4KuQlVto9ICrzQG8pw7xFneR4eou2gYAH_9bM2uv53LN1x0OQBtOrQrzfmzjksM6fiol6fQVy4.88gJoowfAwWO5Q943lH4V3Q07YbZF2Nxjd2UzEawDOw&dib_tag=se&keywords=ORGANIC%2BFERTILIZER&qid=1757942906&sprefix=organic%2Bfertilizer%2Caps%2C300&sr=8-2-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&th=1"
    },
    {
      "name": "Pesticide Spray",
      "image": "assets/images/spray.jpg",
      "url": "https://www.amazon.in/Chipku-Pressed-Soluble-Plants-Garden/dp/B08VRJLGL9/ref=sr_1_1_sspa?crid=23LYX3O34VU4H&dib=eyJ2IjoiMSJ9.kqOUmuQc5IYB0C1w14PHN3qqctHnehwdqK70aOugIAZ09QxyLWDVou-_7bewhiZWRGQI3uKWNbmoXa3XHZ_G090YIiTVVatYfYD2Sv9vohO5N2P7UIyBl6EWiHSeVnRuPYk8ofA3nShIIQ5yCm_eRLQY_w2I-qKujfDpJAyk8y0TfEQRcxDDer36pQEV-Px9nnt9jmIAHX3QAO5UqLVBfFCCx-zxJU5jCacDQFPT0oAA6rX0DvK755OCxcnQa54l9TWcotTHBXclyVwwRpJ7a2oiJolHx89HHXNwGx4JesE.C0bSW95bOlDGMhpnQMj2C6ih4n5JIjV_0Oj7C2Vhn28&dib_tag=se&keywords=Pesticide%2BSpray&qid=1757943212&sprefix=pesticide%2Bspray%2Caps%2C300&sr=8-1-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&th=1"
    },
    {
      "name": "Soil Nutrients",
      "image": "assets/images/nutrients.jpg",
      "url": "https://www.amazon.in/IFFCO-Urban-Gardens-Purpose-Organic/dp/B085M784T3/ref=sr_1_1_sspa?crid=1JLVS9OSKSHE5&dib=eyJ2IjoiMSJ9.QV-0XUcfS9ZGzOzKpmUrYi7M6h4Iaa1W8UMhxtefRpSXPFZFOkhe5BPl81zBAvNiK65NGALH3I5taWuCt4QgEjfKXygqCIZJPvflf9EYiwH6cu6MSOvvK-l5-HnUSPWQdacQnGEw-eX7pwWUoi70Xf8lhFShN2P_UwK0hPXW8pbnhtXlRdlpA1NUWjguxKrWu_btJcGp-2q0TKyNPsZJUwRccOuOckwDuXGn8nKHiQn9L4M6LTdfy2tYL7RBJ0HlwDrI1nH2AEP9lUFJAQSUQEHVQ2Rx0l4InrCR0HzgtnM.syRWP50bWfbenGKEvGTwgcv8T_vkcC6lR1QecXFRTf8&dib_tag=se&keywords=Soil%2BNutrients&qid=1757943594&sprefix=soil%2Bnutrients%2Caps%2C346&sr=8-1-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&th=1"
    },
  ];

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Supplements at Low Costs")),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.65,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      product["image"]!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product["name"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => _launchURL(product["url"]!),
                  icon: const Icon(Icons.shopping_cart, size: 18),
                  label: const Text("Buy"),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
