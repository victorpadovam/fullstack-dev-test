import 'package:flutter/material.dart';

import '../../data/services/suggestion_service.dart';
import '../controllers/suggestion_controller.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/suggestion_button.dart';
import '../widgets/suggestion_list.dart';

class SuggestionPage extends StatefulWidget {
  final SuggestionController? controller;

  const SuggestionPage({super.key, this.controller});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  late final SuggestionController controller;
  late final bool _isExternalController;

  @override
  void initState() {
    super.initState();
    _isExternalController = widget.controller != null;
    controller =
        widget.controller ?? SuggestionController(service: SuggestionService());
    controller.addListener(_listener);
  }

  void _listener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.removeListener(_listener);

    if (!_isExternalController) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 360,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFCFE2F3),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: const Color(0xFF7DA2C7),
                width: 3,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFD9E7F3),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F0F8),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Center(
                      child: Text(
                        'Gift Card Message Suggester',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Ocasião',
                    hintText: 'Aniversário',
                    controller: controller.occasionController,
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    label: 'Relação',
                    hintText: 'Mãe',
                    controller: controller.relationshipController,
                  ),
                  const SizedBox(height: 18),
                  SuggestionButton(
                    isLoading: controller.isLoading,
                    onPressed: controller.getSuggestions,
                  ),
                  if (controller.errorMessage != null) ...[
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade300),
                      ),
                      child: Text(
                        controller.errorMessage!,
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                  if (controller.suggestions.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    SuggestionList(
                      suggestions: controller.suggestions,
                      source: controller.source,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
