import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';
import 'action_buttons.dart';

class AnalogyCard extends StatelessWidget {
  final String analogy;
  final String beforeImage;
  final String afterImage;
  final double sliderValue;
  final ValueChanged<double> onSliderChanged;
  final bool isFavorited;
  final VoidCallback onFavorite;
  final VoidCallback onShare;
  final VoidCallback onRegenerate;
  final VoidCallback onExpand;

  const AnalogyCard({
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
    required this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8DCC0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8B7355).withOpacity(0.15),
              spreadRadius: 4,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            const spacing = 20.0;
            const estimatedButtonHeight = 48.0;
            const estimatedExpandButtonHeight = 32.0;
            final textLineHeight = 17 * 1.5;
            final textHeight = textLineHeight * 2;

            return Column(
              children: [
                SizedBox(
                  height: availableHeight -
                      textHeight -
                      (spacing * 3) -
                      estimatedButtonHeight -
                      estimatedExpandButtonHeight,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: onExpand,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: BeforeAfter(
                              before: Image.asset(beforeImage, fit: BoxFit.cover),
                              after: Image.asset(afterImage, fit: BoxFit.cover),
                              value: sliderValue,
                              onValueChanged: onSliderChanged,
                              thumbColor: const Color(0xFF8B7355),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: spacing),
                GestureDetector(
                  onTap: onExpand,
                  child: Text(
                    analogy,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      height: 1.5,
                      color: Color(0xFF2C3E50),
                      fontFamily: 'serif',
                    ),
                  ),
                ),
                const SizedBox(height: spacing),
                ActionButtons(
                  isFavorited: isFavorited,
                  onFavorite: onFavorite,
                  onShare: onShare,
                  onRegenerate: onRegenerate,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
