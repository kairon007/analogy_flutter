import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';
import 'action_buttons.dart';

class ExpandedAnalogyView extends StatelessWidget {
  final String analogy;
  final String beforeImage;
  final String afterImage;
  final double sliderValue;
  final ValueChanged<double> onSliderChanged;
  final bool isFavorited;
  final VoidCallback onFavorite;
  final VoidCallback onShare;
  final VoidCallback onRegenerate;

  const ExpandedAnalogyView({
    super.key,
    required this.analogy,
    required this.beforeImage,
    required this.afterImage,
    required this.sliderValue,
    required this.onSliderChanged,
    required this.isFavorited,
    required this.onFavorite,
    required this.onShare,
    required this.onRegenerate,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) => Container(
        color: Colors.white,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BeforeAfter(
                      before: Image.asset(beforeImage, fit: BoxFit.cover),
                      after: Image.asset(afterImage, fit: BoxFit.cover),
                      value: sliderValue,
                      onValueChanged: onSliderChanged,
                      thumbColor: const Color(0xFF8B7355),
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  analogy,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    height: 1.5,
                    color: Color(0xFF2C3E50),
                    fontFamily: 'serif',
                  ),
                ),
                const SizedBox(height: 20),
                ActionButtons(
                  isFavorited: isFavorited,
                  onFavorite: onFavorite,
                  onShare: onShare,
                  onRegenerate: onRegenerate,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
