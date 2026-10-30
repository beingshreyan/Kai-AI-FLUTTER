import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool isAvailable = false;

  Future<void> initialize() async {
    isAvailable = await _speech.initialize(
      onStatus: (status) => debugPrint('STT Status: $status'),
      onError: (error) => debugPrint('STT Error: $error'),
    );
  }

  void startListening({required Function(String) onResult, required Function() onDone}) {
    if (isAvailable) {
      _speech.listen(
        onResult: (result) {
          if (result.finalResult) {
            onResult(result.recognizedWords);
            onDone();
          }
        },
        listenOptions: stt.SpeechListenOptions(
          listenFor: const Duration(seconds: 15),
          pauseFor: const Duration(seconds: 3),
        ),
      );
    }
  }

  void stopListening() {
    _speech.stop();
  }
}