import 'package:flutter/material.dart';

class NoticeBoardPage extends StatelessWidget {
  const NoticeBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notices = [
      {"text": "कैबिनेट ने प्रधानमंत्री धन-धान्य कृषि योजना को मंजूरी दी", "isNew": "true"},
      {"text": "2025-26 में चयनित फसलों के लिए प्रौद्योगिकी का उपयोग करके ग्राम पंचायत स्तर पर फसल उपज अनुमान हेतु रुचि की अभिव्यक्ति", "isNew": "true"},
      {"text": "राष्ट्रीय किसान कल्याण कार्यक्रम कार्यान्वयन सोसाइटी (NFWPIS) में नियुक्ति हेतु तेरह पदों को भरना", "isNew": "true"},
      {"text": "खरीफ विपणन मौसम (KMS) 2025-26 के लिए खरीफ फसल हेतु न्यूनतम समर्थन मूल्य", "isNew": "true"},
      {"text": "कैबिनेट ने मौजूदा 1.5% ब्याज अनुदान (ISS) के साथ वित्त वर्ष 2025-26 के लिए संशोधित ब्याज दर को मंजूरी दी", "isNew": "false"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notice Board"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: notices.length,
        itemBuilder: (context, index) {
          final notice = notices[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(Icons.arrow_right, color: Colors.green, size: 28),
              title: Text(
                notice["text"]!,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              trailing: notice["isNew"] == "true"
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "NEW",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}




// import 'package:flutter/material.dart';

// class NoticeBoardPage extends StatelessWidget {
//   const NoticeBoardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Notice Board")),
//       body: const Center(
//         child: Text("Govt initiatives, schemes, and app updates."),
//       ),
//     );
//   }
// }
