import 'package:flutter/material.dart';

class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

  final List<Map<String, String>> nutritionTips = const [
    {
      "title": "Kahvaltı Önerisi",
      "description": "Yulaf ezmesi, süt ve taze meyve ile dengeli bir kahvaltı yapın.",
      "image": "assets/images/diet.jpg"
    },
    {
      "title": "Ara Öğün",
      "description": "Badem veya ceviz gibi sağlıklı kuruyemişleri tercih edin.",
      "image": "assets/images/diet.jpg"
    },
    {
      "title": "Öğle Yemeği",
      "description": "Izgara tavuk, bol yeşillik ve tam buğday ekmeği ile öğle yemeği.",
      "image": "assets/images/diet.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beslenme Önerileri")),
      body: Column()
    );
  }
}
