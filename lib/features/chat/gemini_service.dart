import 'package:google_generative_ai/google_generative_ai.dart';
import '../../core/constants.dart';

class GeminiService {
  late final GenerativeModel _model;
  ChatSession? _chat;

  GeminiService() {
    _model = GenerativeModel(
      model: 'gemini-3.5-flash',
      apiKey: ApiConstants.geminiApiKey,
      systemInstruction: Content.system(AppConstants.systemInstruction),
    );
  }

  
  void initChat(List<Map<String, dynamic>> pastMessages) {
    List<Content> history = pastMessages.map((msg) {
      final text = msg['text'] as String;
      final isUser = msg['isUser'] as bool;
      
      return Content(isUser ? 'user' : 'model', [TextPart(text)]);
    }).toList();

    _chat = _model.startChat(history: history);
  }

  Future<String?> sendMessage(String message) async {
    if (_chat == null) return "System Error: Memory link not initialized.";
    
    try {
      final response = await _chat!.sendMessage(Content.text(message));
      return response.text;
    } catch (e) {
      return "System Error: Neural link interrupted. $e";
    }
  }
}