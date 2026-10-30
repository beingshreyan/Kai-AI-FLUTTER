import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:vosk_flutter/vosk_flutter.dart';

class WakeWordService {
  final Function() onWakeWordDetected;
  
  bool isListening = false;
  VoskFlutterPlugin? _vosk;
  Model? _model;
  Recognizer? _recognizer;
  SpeechService? _voskSpeechService;

  WakeWordService({required this.onWakeWordDetected});

  Future<void> initialize() async {
    try {
      _vosk = VoskFlutterPlugin.instance();
      
      
      final modelPath = await ModelLoader().loadFromAssets('assets/models/vosk_model');
      _model = await _vosk!.createModel(modelPath);
      
      
      _recognizer = await _vosk!.createRecognizer(model: _model!, sampleRate: 16000);
      
      
      _voskSpeechService = await _vosk!.initSpeechService(_recognizer!);
      
      
      _voskSpeechService!.onPartial().listen((event) {
        try {
          final json = jsonDecode(event);
          final partialText = (json['partial'] ?? '').toString().toLowerCase();
          if (partialText.contains("kai") || partialText.contains("hi")) {
            _triggerWakeWord();
          }
        } catch (_) {}
      });

      _voskSpeechService!.onResult().listen((event) {
        try {
          final json = jsonDecode(event);
          final text = (json['text'] ?? '').toString().toLowerCase();
          if (text.contains("kai") || text.contains("hi")) {
            _triggerWakeWord();
          }
        } catch (_) {}
      });

      await startListening();
    } catch (e) {
      debugPrint("Vosk Offline Engine Error: $e");
    }
  }

  void _triggerWakeWord() {
    if (isListening) {
      onWakeWordDetected();
    }
  }

  Future<void> startListening() async {
    if (_voskSpeechService != null && !isListening) {
      await _voskSpeechService!.start();
      isListening = true;
    }
  }

  Future<void> stopListening() async {
    if (_voskSpeechService != null && isListening) {
      await _voskSpeechService!.stop();
      isListening = false;
    }
  }

  Future<void> dispose() async {
    await stopListening();
    _voskSpeechService?.dispose();
    _recognizer?.dispose();
    
  }
}