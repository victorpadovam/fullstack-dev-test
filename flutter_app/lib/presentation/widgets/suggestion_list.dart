import 'package:flutter/material.dart';

class SuggestionList extends StatelessWidget {
  final List<String> suggestions;
  final String source;

  const SuggestionList({
    super.key,
    required this.suggestions,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFD8DDE3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sugestões:',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(suggestions.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFF2E86DE),
                    width: 1.2,
                  ),
                ),
                child: Text(
                  '${index + 1}. ${suggestions[index]}',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            );
          }),
          const SizedBox(height: 4),
          Text(
            'Fonte: $source',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
