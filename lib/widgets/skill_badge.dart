import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'glass_container.dart';

class SkillBadge extends StatefulWidget {
  final String skill;

  const SkillBadge({super.key, required this.skill});

  @override
  State<SkillBadge> createState() => _SkillBadgeState();
}

class _SkillBadgeState extends State<SkillBadge> {
  bool _isHovered = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  static final String _clickDataUri =
      'data:audio/wav;base64,${base64Encode(_generateClickSound())}';

  static Uint8List _generateClickSound() {
    const sampleRate = 44100;
    const duration = 0.1;
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
      final env = math.exp(-t * 50);
      final val = math.sin(2 * math.pi * 1000 * t) * env * 32767;
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
    setState(() => _isHovered = true);
    _audioPlayer.play(UrlSource(_clickDataUri), volume: 1.0).catchError((e) {
      debugPrint('Audio play error: $e');
    });
  }

  void _onExit(PointerEvent details) {
    setState(() => _isHovered = false);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _isHovered ? 1.08 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: LiquidGlassContainer(
          borderRadius: 30,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          enableHoverEffect: false,
          borderColor: _isHovered
              ? const Color(0xFF00E5FF)
              : Colors.white.withValues(alpha: 0.15),
          glassGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _isHovered
                  ? const Color(0xFF00E5FF).withValues(alpha: 0.25)
                  : Colors.white.withValues(alpha: 0.08),
              _isHovered
                  ? const Color(0xFF8B5CF6).withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.02),
            ],
          ),
          child: Text(
            widget.skill,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: _isHovered ? Colors.white : const Color(0xFFE2E8F0),
                  fontWeight: _isHovered ? FontWeight.bold : FontWeight.w500,
                  fontSize: 15,
                ),
          ),
        ),
      ),
    );
  }
}
