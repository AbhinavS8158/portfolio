import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:math' as math;

class SkillBadge extends StatefulWidget {
  final String skill;

  const SkillBadge({Key? key, required this.skill}) : super(key: key);

  @override
  _SkillBadgeState createState() => _SkillBadgeState();
}

class _SkillBadgeState extends State<SkillBadge> {
  bool _isHovered = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Generate a reliable, audible tick sound using a short sine wave
  static final String _clickDataUri = 'data:audio/wav;base64,' + base64Encode(_generateClickSound());

  static Uint8List _generateClickSound() {
    const sampleRate = 44100;
    const duration = 0.1; // 100ms (longer)
    final numSamples = (sampleRate * duration).toInt();
    
    final byteData = ByteData(44 + numSamples * 2);
    
    byteData.setUint32(0, 0x52494646, Endian.big); // "RIFF"
    byteData.setUint32(4, 36 + numSamples * 2, Endian.little);
    byteData.setUint32(8, 0x57415645, Endian.big); // "WAVE"
    
    byteData.setUint32(12, 0x666D7420, Endian.big); // "fmt "
    byteData.setUint32(16, 16, Endian.little); 
    byteData.setUint16(20, 1, Endian.little); // PCM
    byteData.setUint16(22, 1, Endian.little); // Mono
    byteData.setUint32(24, sampleRate, Endian.little); 
    byteData.setUint32(28, sampleRate * 2, Endian.little); 
    byteData.setUint16(32, 2, Endian.little); 
    byteData.setUint16(34, 16, Endian.little); 
    
    byteData.setUint32(36, 0x64617461, Endian.big); // "data"
    byteData.setUint32(40, numSamples * 2, Endian.little);
    
    for (int i = 0; i < numSamples; i++) {
      final t = i / sampleRate;
      final env = math.exp(-t * 50); // slower decay for louder sound
      final val = math.sin(2 * math.pi * 1000 * t) * env * 32767; // MAX amplitude
      byteData.setInt16(44 + i * 2, val.toInt(), Endian.little);
    }
    
    return byteData.buffer.asUint8List();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _onEnter(PointerEvent details) {
    setState(() {
      _isHovered = true;
    });
    // Play tick sound using local base64 data URI to bypass browser CORS and bugs
    _audioPlayer.play(UrlSource(_clickDataUri), volume: 1.0).catchError((e) {
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
