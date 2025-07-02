import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:analogy_flutter/util/extensions.dart';
@RoutePage()
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _selectedCategory = 'all';

  List<Map<String, dynamic>> _getCategories(BuildContext context) => [
    {'id': 'all', 'label': context.loc.categoryAll, 'count': 24},
    {'id': 'love', 'label': context.loc.categoryLove, 'count': 8},
    {'id': 'work', 'label': context.loc.categoryWork, 'count': 6},
    {'id': 'technology', 'label': context.loc.categoryTechnology, 'count': 5},
    {'id': 'leisure', 'label': context.loc.categoryLeisure, 'count': 5},
  ];

  final List<Map<String, dynamic>> _curatedAnalogies = [
    {
      'id': 1,
      'modern': 'Online Dating',
      'category': 'love',
      'analogy':
          'Online dating is what carefully written letters and chaperoned courtship once were — a formal dance of revealing just enough of yourself to intrigue, while hoping your true essence shines through the constraints.',
      'tone': 'nostalgic'
    },
    {
      'id': 2,
      'modern': 'Remote Work',
      'category': 'work',
      'analogy':
          'Working from home today echoes the cottage industries of old, where craftsmen shaped their days around family rhythms, and the line between livelihood and life was drawn in gentle pencil, not permanent ink.',
      'tone': 'reflective'
    },
    {
      'id': 3,
      'modern': 'Spotify Playlists',
      'category': 'leisure',
      'analogy':
          'Curating Spotify playlists is what arranging sheet music on a piano bench used to be — a deeply personal archaeology of moods, memories, and the songs that somehow knew exactly what we needed to hear.',
      'tone': 'emotional'
    },
    {
      'id': 4,
      'modern': 'Video Calls',
      'category': 'technology',
      'analogy':
          'Video calls are the modern parlor room visits — we dress up our backgrounds like we once arranged our finest china, hoping technology can bridge the miles that separate our hearts.',
      'tone': 'humble'
    },
    {
      'id': 5,
      'modern': 'Social Media Stories',
      'category': 'technology',
      'analogy':
          'Instagram stories are like the daily gossip over garden fences — fleeting moments of connection where we share our small victories and beautiful mundane, knowing they\'ll fade by tomorrow.',
      'tone': 'funny'
    },
    {
      'id': 6,
      'modern': 'Netflix Binge',
      'category': 'leisure',
      'analogy':
          'Binge-watching Netflix is what staying up all night reading by candlelight used to be — that delicious surrender to story, where time dissolves and we emerge squinting into reality, slightly changed.',
      'tone': 'nostalgic'
    }
  ];

  @override
  Widget build(BuildContext context) {
    final filteredAnalogies = _selectedCategory == 'all'
        ? _curatedAnalogies
        : _curatedAnalogies
            .where((item) => item['category'] == _selectedCategory)
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      context.loc.exploreTitle,
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
                      context.loc.exploreSubtitle,
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
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _getCategories(context).length,
                itemBuilder: (context, index) {
                  final category = _getCategories(context)[index];
                  final bool isActive = _selectedCategory == category['id'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category['id'];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isActive ? const Color(0xFF8B7355) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isActive
                              ? const Color(0xFF8B7355)
                              : const Color(0xFFE8DCC0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            category['label'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isActive
                                  ? const Color(0xFFFAF7F2)
                                  : const Color(0xFF8B7355),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFFFAF7F2)
                                  : const Color(0xFFF0F0F0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              category['count'].toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: isActive
                                    ? const Color(0xFF8B7355)
                                    : const Color(0xFFA0A0A0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: filteredAnalogies.length,
                itemBuilder: (context, index) {
                  final analogy = filteredAnalogies[index];
                  return _buildAnalogyCard(analogy);
                },
              ),
            ),
          ],
        ),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8DCC0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  analogy['category'].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF8B7355),
                    fontWeight: FontWeight.w600,
                  ),
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
                  _buildActionButton(icon: FeatherIcons.heart, onPressed: () {}),
                  const SizedBox(width: 12),
                  _buildActionButton(icon: FeatherIcons.share, onPressed: () {}),
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