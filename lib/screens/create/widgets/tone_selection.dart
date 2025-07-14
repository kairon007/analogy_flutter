import 'package:analogy_flutter/util/extensions.dart';
import 'package:flutter/material.dart';

class ToneSelection extends StatelessWidget {
  final String selectedTone;
  final ValueChanged<String> onToneSelected;

  const ToneSelection({
    super.key,
    required this.selectedTone,
    required this.onToneSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.loc.toneSelectionTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildToneButton(
                context,
                'reflective',
                context.loc.toneReflective,
                '🧘',
              ),
              _buildToneButton(
                context,
                'humble',
                context.loc.toneHumble,
                '🙏',
              ),
              _buildToneButton(
                context,
                'funny',
                context.loc.toneFunny,
                '😂',
              ),
              _buildToneButton(
                context,
                'nostalgic',
                context.loc.toneNostalgic,
                '🕰️',
              ),
              _buildToneButton(
                context,
                'emotional',
                context.loc.toneEmotional,
                '❤️',
              ),
            ],
          ),
        ),
      ],
    );
  }

  double _calculateMaxButtonWidth(BuildContext context) {
    final labels = [
      context.loc.toneReflective,
      context.loc.toneHumble,
      context.loc.toneFunny,
      context.loc.toneNostalgic,
      context.loc.toneEmotional,
    ];

    double maxWidth = 0;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (final label in labels) {
      textPainter.text = TextSpan(
        text: label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      );
      textPainter.layout();
      maxWidth = textPainter.width > maxWidth ? textPainter.width : maxWidth;
    }
    return maxWidth + 48;
  }

  Widget _buildToneButton(
      BuildContext context, String tone, String label, String emoji) {
    final bool isActive = selectedTone == tone;
    final double buttonWidth = _calculateMaxButtonWidth(context);

    return GestureDetector(
      onTap: () => onToneSelected(tone),
      child: Container(
        width: buttonWidth,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF8B7355) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? const Color(0xFF8B7355) : const Color(0xFFE8DCC0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive
                    ? const Color(0xFFFAF7F2)
                    : const Color(0xFF8B7355),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
