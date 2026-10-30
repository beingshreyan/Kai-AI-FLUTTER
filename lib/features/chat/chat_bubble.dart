import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(16.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        decoration: BoxDecoration(
          color: isUser ? theme.colorScheme.primary.withValues(alpha: 0.05) : theme.colorScheme.surface,
          border: Border.all(
            color: isUser ? theme.colorScheme.primary.withValues(alpha: 0.5) : Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 20),
          ),
        ),
        child: isUser
            ? Text(
                text,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              )
            : MarkdownBody(
                data: text,
                styleSheet: MarkdownStyleSheet(
                  p: theme.textTheme.bodyMedium,
                  code: theme.textTheme.bodyMedium?.copyWith(
                    backgroundColor: Colors.black38,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
      ),
    );
  }
}