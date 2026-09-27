import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/resume_data.dart';
import '../widgets/contact_section.dart';
import '../widgets/education_timeline.dart';
import '../widgets/experience_timeline.dart';
import '../widgets/glass_container.dart';
import '../widgets/grid_painter.dart';
import '../widgets/phone_mockup.dart';
import '../widgets/project_card.dart';
import '../widgets/skill_badge.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  late AnimationController _blobController;

  @override
  void initState() {
    super.initState();
    _blobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _blobController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060814),
      extendBodyBehindAppBar: true,
      appBar: _buildBlurAppBar(context),
      endDrawer: _buildDrawer(context),
      body: Stack(
        children: [
          // Grid background pattern
          Positioned.fill(
            child: CustomPaint(
              painter: GridPainter(
                color: const Color(0xFF00E5FF).withValues(alpha: 0.04),
                spacing: 60,
              ),
            ),
          ),

          // Animated Liquid Blob 1 (Top-Right Cyan Glow)
          AnimatedBuilder(
            animation: _blobController,
            builder: (context, child) {
              final offset = math.sin(_blobController.value * math.pi * 2) * 50;
              return Positioned(
                top: 50 + offset,
                right: -150 + offset,
                width: 700,
                height: 700,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF00E5FF).withValues(alpha: 0.22),
                        const Color(0xFF00E5FF).withValues(alpha: 0.05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Animated Liquid Blob 2 (Bottom-Left Purple/Magenta Glow)
          AnimatedBuilder(
            animation: _blobController,
            builder: (context, child) {
              final offset = math.cos(_blobController.value * math.pi * 2) * 60;
              return Positioned(
                bottom: -150 + offset,
                left: -150 - offset,
                width: 750,
                height: 750,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF8B5CF6).withValues(alpha: 0.25),
                        const Color(0xFFEC4899).withValues(alpha: 0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Animated Liquid Blob 3 (Center Ambient Glow)
          AnimatedBuilder(
            animation: _blobController,
            builder: (context, child) {
              final scale = 1.0 + math.sin(_blobController.value * math.pi) * 0.15;
              return Positioned(
                top: MediaQuery.of(context).size.height * 0.45,
                left: MediaQuery.of(context).size.width * 0.3,
                width: 500 * scale,
                height: 500 * scale,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF3B82F6).withValues(alpha: 0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Subtle Noise Overlay
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: IgnorePointer(
                child: Image.network(
                  'https://www.transparenttextures.com/patterns/stardust.png',
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
          ),

          // Main Scrollable Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 160),
                      Container(key: _homeKey, child: _buildHeroSection(context)),
                      const SizedBox(height: 150),
                      _buildSectionTitle(context, "ABOUT ME"),
                      _buildAboutSection(context),
                      const SizedBox(height: 150),
                      _buildSectionTitle(context, "SKILLS"),
                      _buildSkillsSection(context),
                      const SizedBox(height: 150),
                      Container(
                        key: _projectsKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle(context, "PROJECTS"),
                            _buildProjectsSection(context),
                          ],
                        ),
                      ),
                      const SizedBox(height: 150),
                      Container(
                        key: _experienceKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle(context, "EXPERIENCE"),
                            const ExperienceTimeline(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 150),
                      Container(
                        key: _educationKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle(context, "EDUCATION"),
                            const EducationTimeline(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 150),
                      Container(
                        key: _contactKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle(context, "CONTACT"),
                            const ContactSection(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildBlurAppBar(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: LiquidGlassContainer(
            borderRadius: 50,
            blur: 24,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            enableHoverEffect: false,
            borderColor: Colors.white.withValues(alpha: 0.25),
            glassGradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.12),
                Colors.white.withValues(alpha: 0.04),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00E5FF),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF00E5FF),
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "ABHINAV S",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 20,
                            color: const Color(0xFF00E5FF),
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                if (!isMobile)
                  Row(
                    children: [
                      _navLink("HOME", () => _scrollTo(_homeKey)),
                      const SizedBox(width: 24),
                      _navLink("PROJECTS", () => _scrollTo(_projectsKey)),
                      const SizedBox(width: 24),
                      _navLink("EXPERIENCE", () => _scrollTo(_experienceKey)),
                      const SizedBox(width: 24),
                      _navLink("EDUCATION", () => _scrollTo(_educationKey)),
                      const SizedBox(width: 24),
                      _navLink("CONTACT", () => _scrollTo(_contactKey)),
                    ],
                  )
                else
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu_rounded, color: Colors.white),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            color: const Color(0xFF07091A).withValues(alpha: 0.88),
            child: ListView(
              padding: const EdgeInsets.all(28),
              children: [
                const SizedBox(height: 60),
                Text(
                  "NAVIGATION",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: const Color(0xFF00E5FF),
                        letterSpacing: 2,
                      ),
                ),
                const SizedBox(height: 32),
                _drawerLink("HOME", () {
                  Navigator.pop(context);
                  _scrollTo(_homeKey);
                }),
                const SizedBox(height: 24),
                _drawerLink("PROJECTS", () {
                  Navigator.pop(context);
                  _scrollTo(_projectsKey);
                }),
                const SizedBox(height: 24),
                _drawerLink("EXPERIENCE", () {
                  Navigator.pop(context);
                  _scrollTo(_experienceKey);
                }),
                const SizedBox(height: 24),
                _drawerLink("EDUCATION", () {
                  Navigator.pop(context);
                  _scrollTo(_educationKey);
                }),
                const SizedBox(height: 24),
                _drawerLink("CONTACT", () {
                  Navigator.pop(context);
                  _scrollTo(_contactKey);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawerLink(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: 22,
              color: Colors.white,
            ),
      ),
      hoverColor: const Color(0xFF00E5FF).withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
    );
  }

  Widget _navLink(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      hoverColor: const Color(0xFF00E5FF).withValues(alpha: 0.15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: const Color(0xFFCBD5E1),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF00E5FF),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00E5FF).withValues(alpha: 0.6),
                  blurRadius: 12,
                  spreadRadius: 1,
                )
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 36,
                  letterSpacing: -0.5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1000;
    final heroContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Stack(
            children: [
              Text(
                "FLUTTER\nDEVELOPER",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = const Color(0xFF00E5FF),
                    ),
              ),
              Text(
                "FLUTTER\nDEVELOPER",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "I build exceptional and accessible digital experiences for the web and mobile.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                color: const Color(0xFF94A3B8),
              ),
        ),
        const SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00E5FF).withValues(alpha: 0.4),
                blurRadius: 24,
                spreadRadius: 1,
              )
            ],
          ),
          child: ElevatedButton(
            onPressed: () => _scrollTo(_projectsKey),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00E5FF),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 22),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(
              "VIEW PROJECTS",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );

    if (isDesktop) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: heroContent),
            const PhoneMockup(),
          ],
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heroContent,
          const SizedBox(height: 80),
          const Center(child: PhoneMockup()),
        ],
      );
    }
  }

  Widget _buildAboutSection(BuildContext context) {
    return LiquidGlassContainer(
      borderRadius: 24,
      blur: 20,
      padding: const EdgeInsets.all(32),
      enableHoverEffect: false,
      child: Text(
        ResumeData.summary,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.8,
              color: const Color(0xFFE2E8F0),
            ),
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: ResumeData.skills.map((skill) => SkillBadge(skill: skill)).toList(),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: ResumeData.projects.map((p) => ProjectCard(project: p)).toList(),
    );
  }
}
