import 'package:flutter/material.dart';
import 'gemini_service.dart';
import 'chat_bubble.dart';
import '../memory/database_service.dart';
import '../wake_word/vosk_service.dart';
import '../wake_word/speech_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  final GeminiService _geminiService = GeminiService();
  late final WakeWordService _wakeWordService;
  final SpeechService _speechService = SpeechService();
  
  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;
  bool _isInitializing = true;
  bool _isListeningToSpeech = false;

  @override
  void initState() {
    super.initState();
    _wakeWordService = WakeWordService(onWakeWordDetected: _onWakeWordDetected);
    _initializeSystems();
  }

  Future<void> _initializeSystems() async {
    
    final history = await DatabaseService.instance.loadHistory();
    setState(() {
      _messages = history;
      _isInitializing = false;
    });
    _geminiService.initChat(history);
    _scrollToBottom();

    
    await _speechService.initialize();
    await _wakeWordService.initialize();
  }

  void _onWakeWordDetected() async {
    
    await _wakeWordService.stopListening();
    
    setState(() {
      _isListeningToSpeech = true;
    });

    
    _speechService.startListening(
      onResult: (transcribedText) {
        _controller.text = transcribedText;
        _sendMessage();
      },
      onDone: () async {
        setState(() {
          _isListeningToSpeech = false;
        });
        
        await _wakeWordService.startListening();
      },
    );
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"text": text, "isUser": true});
      _isLoading = true;
    });
    
    await DatabaseService.instance.saveMessage(text: text, isUser: true);
    _controller.clear();
    _scrollToBottom();

    final response = await _geminiService.sendMessage(text);
    final replyText = response ?? "Silence.";

    setState(() {
      _messages.add({"text": replyText, "isUser": false});
      _isLoading = false;
    });
    
    await DatabaseService.instance.saveMessage(text: replyText, isUser: false);
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _wakeWordService.dispose();
    _speechService.stopListening();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KAI'),
        actions: [
          Icon(
            _isListeningToSpeech ? Icons.mic : Icons.graphic_eq,
            color: _isListeningToSpeech 
                ? Theme.of(context).colorScheme.secondary 
                : Theme.of(context).colorScheme.primary, 
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () async {
              await DatabaseService.instance.wipeMemory();
              setState(() => _messages.clear());
              _geminiService.initChat([]);
            },
          )
        ],
      ),
      body: _isInitializing 
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    return ChatBubble(
                      text: msg["text"],
                      isUser: msg["isUser"],
                    );
                  },
                ),
              ),
              if (_isLoading)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.transparent,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: _isListeningToSpeech ? 'Listening...' : 'Speak to KAI...',
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: _isListeningToSpeech 
                            ? Theme.of(context).colorScheme.secondary 
                            : Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.black),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}