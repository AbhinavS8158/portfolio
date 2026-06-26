import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:typed_data';

class SkillBadge extends StatefulWidget {
  final String skill;

  const SkillBadge({Key? key, required this.skill}) : super(key: key);

  @override
  _SkillBadgeState createState() => _SkillBadgeState();
}

class _SkillBadgeState extends State<SkillBadge> {
  bool _isHovered = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Very short PCM wav file data for a subtle 'tick'
  static final Uint8List _clickBytes = Uint8List.fromList([
    82, 73, 70, 70, 44, 0, 0, 0, 87, 65, 86, 69, 102, 109, 116, 32, 
    16, 0, 0, 0, 1, 0, 1, 0, 68, 172, 0, 0, 68, 172, 0, 0, 
    1, 0, 8, 0, 100, 97, 116, 97, 8, 0, 0, 0, 255, 128, 64, 32, 16, 8, 4, 2
  ]);

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _onEnter(PointerEvent details) {
    setState(() {
      _isHovered = true;
    });
    // Play tick sound using local bytes to bypass browser CORS
    _audioPlayer.play(
      BytesSource(_clickBytes),
      volume: 0.5,
    ).catchError((e) {
      debugPrint('Audio play error: $e');
    });
  }

  void _onExit(PointerEvent details) {
    setState(() {
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        transform: Matrix4.identity()..scale(_isHovered ? 1.1 : 1.0),
        decoration: BoxDecoration(
          color: _isHovered 
              ? Theme.of(context).primaryColor.withOpacity(0.2) 
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isHovered 
                ? Theme.of(context).primaryColor 
                : const Color(0xFF1e1e2e),
          ),
          boxShadow: _isHovered 
              ? [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.3), blurRadius: 12)]
              : [],
        ),
        child: Text(
          widget.skill, 
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: _isHovered ? Colors.white : const Color(0xFFe8e8f0),
            fontWeight: _isHovered ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
