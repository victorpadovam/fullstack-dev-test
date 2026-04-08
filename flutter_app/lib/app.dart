import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/suggestion_page.dart';

class GiftCardApp extends StatelessWidget {
  const GiftCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gift Card Message Suggester',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SuggestionPage(),
    );
  }
}
