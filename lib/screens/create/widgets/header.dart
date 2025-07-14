import 'package:analogy_flutter/util/extensions.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            context.loc.appTitle,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3E50),
              fontFamily: 'serif',
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            context.loc.appSubtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF8B7355),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
