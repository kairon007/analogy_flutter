import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class AnalogyWidget extends StatelessWidget {
  final String analogy;
  final bool isFavorited;

  const AnalogyWidget({super.key, required this.analogy, required this.isFavorited});

  @override
  Widget build(BuildContext context) {
    bool _isFavorited = false;
    return Container(
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
      child: Column(
        children: [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionButton(
                icon: isFavorited ? Icons.favorite : Icons.favorite_border,

                color: isFavorited
                    ? const Color(0xFFD2691E)
                    : const Color(0xFF8B7355),
                onPressed: () {
             /*     setState(() {
                    _isFavorited = !_isFavorited;
                  });*/
                },
              ),
              const SizedBox(width: 20),
              _buildActionButton(
                icon: FeatherIcons.share,
                color: const Color(0xFF8B7355),
                onPressed: () {},
              ),
              const SizedBox(width: 20),
              _buildActionButton(
                icon: FeatherIcons.rotateCcw,
                color: const Color(0xFF8B7355),
                onPressed: () {},// _generateAnalogy,
              ),
            ],
          ),
        ],
      ),
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
