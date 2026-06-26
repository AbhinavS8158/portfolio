import 'package:flutter/material.dart';
import 'dart:math';

class PhoneMockup extends StatefulWidget {
  const PhoneMockup({Key? key}) : super(key: key);

  @override
  _PhoneMockupState createState() => _PhoneMockupState();
}

class _PhoneMockupState extends State<PhoneMockup> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(-15 * pi / 180)
            ..rotateX(5 * pi / 180)
            ..translate(0.0, _animation.value, 0.0),
          alignment: FractionalOffset.center,
          child: _buildPhone(),
        );
      },
    );
  }

  Widget _buildPhone() {
    return Container(
      width: 260,
      height: 520,
      decoration: BoxDecoration(
        color: const Color(0xFF0a0a0f),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xFF2a2a3e), width: 8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 120,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFF2a2a3e),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topRight,
                    radius: 1.5,
                    colors: [
                      Color(0x227c3aed),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 70,
                      color: const Color(0xF313131c),
                      padding: const EdgeInsets.only(bottom: 12, left: 24),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Bee Player",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFF1e1e2e)),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            _buildMockCard(),
                            const SizedBox(height: 16),
                            _buildMockCard(),
                            const SizedBox(height: 16),
                            _buildMockCard(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 24,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFF00e5ff),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.play_arrow, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMockCard() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
    );
  }
}
