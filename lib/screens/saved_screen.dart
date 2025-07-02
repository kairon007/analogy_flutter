import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
@RoutePage()
class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final List<Map<String, dynamic>> _savedAnalogies = [
    {
      'id': 1,
      'modern': 'Instagram Likes',
      'analogy':
          'Instagram likes are what heartfelt letters and village gossip used to be — ways of saying \'I see you, I acknowledge your moment\' but compressed into a single, fleeting gesture.',
      'tone': 'reflective',
      'savedDate': '2024-01-15'
    },
    {
      'id': 2,
      'modern': 'Food Delivery',
      'analogy':
          'Food delivery today is what handwritten recipe cards and a bicycle trip to the local grocer were for our grandparents — a dance between memory, effort, and the anticipation that made every meal feel earned.',
      'tone': 'nostalgic',
      'savedDate': '2024-01-14'
    },
    {
      'id': 3,
      'modern': 'Netflix Binge',
      'analogy':
          'Binge-watching Netflix is what staying up all night reading by candlelight used to be — that delicious surrender to story, where time dissolves and we emerge squinting into reality, slightly changed.',
      'tone': 'emotional',
      'savedDate': '2024-01-12'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Your Collection',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3E50),
                        fontFamily: 'serif',
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Center(
                    child: Text(
                      '3 saved analogies for reflection',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8B7355),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _savedAnalogies.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: _savedAnalogies.length,
                      itemBuilder: (context, index) {
                        final analogy = _savedAnalogies[index];
                        return _buildAnalogyCard(analogy);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FeatherIcons.heart,
            size: 48,
            color: Color(0xFFE8DCC0),
          ),
          SizedBox(height: 20),
          Text(
            'No saved analogies yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3E50),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Tap the heart icon on any analogy to save it here for later reflection.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF8B7355),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalogyCard(Map<String, dynamic> analogy) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8DCC0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B7355).withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  analogy['modern'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),
              Text(
                'Saved ${analogy['savedDate']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFA0A0A0),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            analogy['analogy'],
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Color(0xFF2C3E50),
              fontFamily: 'serif',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF7F2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE8DCC0)),
                ),
                child: Text(
                  analogy['tone'],
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF8B7355),
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Row(
                children: [
                  _buildActionButton(icon: FeatherIcons.share, onPressed: () {}),
                  const SizedBox(width: 12),
                  _buildActionButton(icon: FeatherIcons.trash2, onPressed: () {}),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF7F2),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFE8DCC0)),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF8B7355),
          size: 18,
        ),
      ),
    );
  }
}