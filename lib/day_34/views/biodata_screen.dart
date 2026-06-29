import 'package:flutter/material.dart';
import 'package:lanscare_app/day_34/models/harry_potter_models.dart';

class BiodataScreen extends StatelessWidget {
  final HarryPotterModels character;

  const BiodataScreen({super.key, required this.character});

  // Helper method to get theme colors based on Hogwarts House
  Map<String, dynamic> _getHouseTheme() {
    switch (character.house) {
      case House.GRYFFINDOR:
        return {
          'primary': const Color(0xFF740001), // Scarlet
          'secondary': const Color(0xFFD3A625), // Gold
          'accent': const Color(0xFFEEBA30),
          'background': const Color(0xFF1A0B0C),
          'banner':
              'https://images.unsplash.com/photo-1547891654-e66ed7edd96c?auto=format&fit=crop&q=80&w=800',
        };
      case House.SLYTHERIN:
        return {
          'primary': const Color(0xFF1A472A), // Emerald Green
          'secondary': const Color(0xFFAAAAAA), // Silver
          'accent': const Color(0xFF2A623D),
          'background': const Color(0xFF07140B),
          'banner':
              'https://images.unsplash.com/photo-1502082553048-f009c37129b9?auto=format&fit=crop&q=80&w=800',
        };
      case House.RAVENCLAW:
        return {
          'primary': const Color(0xFF0E1A40), // Blue
          'secondary': const Color(0xFF946B2D), // Bronze/Gold
          'accent': const Color(0xFF5D5D90),
          'background': const Color(0xFF040714),
          'banner':
              'https://images.unsplash.com/photo-1464802686167-b939a6910659?auto=format&fit=crop&q=80&w=800',
        };
      case House.HUFFLEPUFF:
        return {
          'primary': const Color(0xFFECB939), // Yellow
          'secondary': const Color(0xFF372E29), // Black
          'accent': const Color(0xFFF0C75E),
          'background': const Color(0xFF1A1613),
          'banner':
              'https://images.unsplash.com/photo-1447752875215-b2761acb3c5d?auto=format&fit=crop&q=80&w=800',
        };
      default:
        return {
          'primary': const Color(0xFF3C2F2F), // Dark purple/grey
          'secondary': const Color(0xFFD4AF37), // Antique gold
          'accent': const Color(0xFF8B5E3C),
          'background': const Color(0xFF120E0E),
          'banner':
              'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?auto=format&fit=crop&q=80&w=800',
        };
    }
  }

  String _cleanEnumValue(String enumString) {
    return enumString.split('.').last.replaceAll('_', ' ').toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = _getHouseTheme();
    final primaryColor = theme['primary'] as Color;
    final secondaryColor = theme['secondary'] as Color;
    final accentColor = theme['accent'] as Color;
    final backgroundColor = theme['background'] as Color;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          // Elegant Header with dynamic background and Hero image
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            stretch: true,
            backgroundColor: primaryColor,
            leading: CircleAvatar(
              backgroundColor: Colors.black38,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Decorative pattern / overlay
                  Image.network(
                    theme['banner'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: primaryColor.withOpacity(0.8)),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          backgroundColor.withOpacity(0.9),
                          backgroundColor,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Profile Image with Hero animation and elegant border
                        if (character.image.isNotEmpty) ...[
                          Hero(
                            tag: 'avatar-${character.id}',
                            child: Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: secondaryColor,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: NetworkImage(character.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                        // Character Name & House Title
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                character.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(1, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.shield,
                                    size: 16,
                                    color: secondaryColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    character.house == House.EMPTY
                                        ? 'No Hogwarts House'
                                        : _cleanEnumValue(
                                            character.house.toString(),
                                          ).toUpperCase(),
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Biodata content list
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildStatusTag(
                          character.alive ? "ALIVE" : "DECEASED",
                          character.alive ? Colors.green : Colors.red,
                        ),
                        if (character.wizard)
                          _buildStatusTag("WIZARD", Colors.purple),
                        if (character.hogwartsStudent)
                          _buildStatusTag("STUDENT", Colors.teal),
                        if (character.hogwartsStaff)
                          _buildStatusTag("STAFF", Colors.blueGrey),
                        _buildStatusTag(
                          _cleanEnumValue(
                            character.gender.toString(),
                          ).toUpperCase(),
                          Colors.indigo,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Section: Profile Details
                    _buildSectionHeader("Personal Biodata", secondaryColor),
                    _buildDetailCard(backgroundColor, accentColor, [
                      _buildDetailRow("Species", character.species),
                      _buildDetailRow(
                        "Date of Birth",
                        character.dateOfBirth?.isNotEmpty == true
                            ? character.dateOfBirth!
                            : (character.yearOfBirth != null
                                  ? character.yearOfBirth.toString()
                                  : '-'),
                      ),
                      _buildDetailRow(
                        "Ancestry",
                        character.ancestry == Ancestry.EMPTY
                            ? '-'
                            : _cleanEnumValue(character.ancestry.toString()),
                      ),
                      _buildDetailRow(
                        "Eye Color",
                        character.eyeColour == EyeColour.EMPTY
                            ? '-'
                            : _cleanEnumValue(character.eyeColour.toString()),
                      ),
                      _buildDetailRow(
                        "Hair Color",
                        character.hairColour == HairColour.EMPTY
                            ? '-'
                            : _cleanEnumValue(character.hairColour.toString()),
                      ),
                    ]),
                    const SizedBox(height: 24),

                    // Section: Magic & Hogwarts Details
                    _buildSectionHeader("Magical Profile", secondaryColor),
                    _buildDetailCard(backgroundColor, accentColor, [
                      _buildDetailRow(
                        "Patronus",
                        character.patronus == Patronus.EMPTY
                            ? '-'
                            : _cleanEnumValue(character.patronus.toString()),
                      ),
                      _buildDetailRow(
                        "Wand Wood",
                        character.wand.wood.isNotEmpty
                            ? character.wand.wood
                            : '-',
                      ),
                      _buildDetailRow(
                        "Wand Core",
                        character.wand.core == Core.EMPTY
                            ? '-'
                            : _cleanEnumValue(character.wand.core.toString()),
                      ),
                      _buildDetailRow(
                        "Wand Length",
                        character.wand.length != null
                            ? "${character.wand.length} inches"
                            : '-',
                      ),
                    ]),
                    const SizedBox(height: 24),

                    // Section: Real World Info (Actor)
                    _buildSectionHeader("Actor Portrayal", secondaryColor),
                    _buildDetailCard(backgroundColor, accentColor, [
                      _buildDetailRow(
                        "Actor Name",
                        character.actor.isNotEmpty ? character.actor : '-',
                      ),
                      if (character.alternateActors.isNotEmpty)
                        _buildDetailRow(
                          "Alternate Actors",
                          character.alternateActors.join(', '),
                        ),
                      if (character.alternateNames.isNotEmpty)
                        _buildDetailRow(
                          "Alternate Names",
                          character.alternateNames.join(', '),
                        ),
                    ]),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        border: Border.all(color: color.withOpacity(0.5), width: 1.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color accentColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(Color bg, Color accentColor, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(children: children),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
