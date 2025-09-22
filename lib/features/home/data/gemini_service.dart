import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gebelik_aapp/features/home/domain/repositories/message_ai_repo.dart';
import 'package:http/http.dart' as http;

class GeminiAIService implements MessageAIRepository {
  final String apiKey =
      dotenv.env['GENERATIVE_AI_API_KEY']!; // .env dosyasına taşınabilir
  final String model = 'gemini-2.0-flash'; // veya gemini-pro vs

  @override
  Future<String> getGeminiResponse(String prompt) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey',
    );

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {
              "text":
                  """Sen bir gebelik danışmanı asistanısın. Kullanıcı sana hamileliği ile ilgili sorular soracak. 
            Cevaplarını şu kurallara göre ver:

            1. Her zaman güvenli, anlaşılır ve empatik bir dil kullan.  
            2. Verdiğin bilgiler yalnızca bilgilendirme amaçlıdır. Tıbbi teşhis veya kesin tedavi sunma. 
              Gerektiğinde "Bunun için doktorunuza danışmanız çok önemli" diye uyar.  
            3. Kullanıcı kaçıncı haftada olduğunu  belirttiğinde, o haftaya özel bebeğin gelişimi, 
              annenin yaşayabileceği değişimler, beslenme ve egzersiz önerileri hakkında bilgi ver.  
              (Örn: "14. haftada bebeğin akciğerleri gelişmeye devam ediyor.")  
            4. Kullanıcı bulgu/symptom yazarsa (örneğin: baş dönmesi, görme bulanıklığı), 
              olası riskleri genel olarak açıkla, ancak kesin teşhis koyma. 
              Her zaman doktora yönlendir. (Örn: "Bu belirtiler preeklampsiye işaret edebilir, 
              acilen doktorunuza danışmalısınız.")  
            5. Sağlıklı yaşam önerileri (beslenme, egzersiz, uyku, stres yönetimi) ver.  
            6. Gerektiğinde madde madde listele, sade örnekler kullan.  
            7. Kullanıcıya güven verici, destekleyici ve moral yükseltici bir üslup kullan.  

            Senin rolün: Bir gebelik danışmanı gibi rehberlik etmek, anneleri bilinçlendirmek ve destek olmaktır.
            """,
            },
            {"text": prompt},
          ],
        },
      ],
    });

    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates'][0]['content']['parts'][0]['text'];
        String responseMessage = text.trim();
        return responseMessage;
      } else {
        print("Hata: ${response.statusCode} => ${response.body}");
        return "Üzgünüm, şu anda yanıt veremiyorum. Lütfen daha sonra tekrar deneyin.";
      }
    } catch (e) {
      print("Exception: $e");
      return "Üzgünüm, şu anda yanıt veremiyorum. Lütfen daha sonra tekrar deneyin.";
    }
  }
}
