import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ExerciseListPage extends StatefulWidget {
  const ExerciseListPage({super.key});

  @override
  State<ExerciseListPage> createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  final List<String> videoIds = [
    '8Y_EWm9qWJQ', // Video 1
    'Tr8IYmECEbA', // Video 2
    'Kp1bZEUgqVI', // Video 3
  ];

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

  late final List<YoutubePlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = videoIds
        .map(
          (id) => YoutubePlayerController.fromVideoId(
            videoId: id,
            autoPlay: false,
            params: const YoutubePlayerParams(
              showFullscreenButton: true,
              enableCaption: true,
            ),
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beslenme & Egzersiz")),
      body: ListView(
        children: [
                    const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Bugünün Beslenme Önerileri",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Beslenme Önerileri
          ...nutritionTips.map((tip) => Card(
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.restaurant_menu, size: 30),
                          const SizedBox(width: 8),
                          Text(
                            tip["title"]!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                      child: Text(
                        tip["description"]!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Egzersiz Videoları",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // Egzersiz Videoları
          ..._controllers.asMap().entries.map((entry) {
            int index = entry.key;
            YoutubePlayerController controller = entry.value;
            return Card(
              margin: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  YoutubePlayer(controller: controller),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Egzersiz ${index + 1}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
