import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ActionButtons extends StatelessWidget {
  final bool isFavorited;
  final VoidCallback onFavorite;
  final VoidCallback onShare;
  final VoidCallback onRegenerate;

  const ActionButtons({
    super.key,
    required this.isFavorited,
    required this.onFavorite,
    required this.onShare,
    required this.onRegenerate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton(
          icon: isFavorited ? Icons.favorite : Icons.favorite_border,
          color: isFavorited ? const Color(0xFFD2691E) : const Color(0xFF8B7355),
          onPressed: onFavorite,
        ),
        const SizedBox(width: 20),
        _buildActionButton(
          icon: FeatherIcons.share,
          color: const Color(0xFF8B7355),
          onPressed: onShare,
        ),
        const SizedBox(width: 20),
        _buildActionButton(
          icon: FeatherIcons.rotateCcw,
          color: const Color(0xFF8B7355),
          onPressed: onRegenerate,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF7F2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE8DCC0)),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}
