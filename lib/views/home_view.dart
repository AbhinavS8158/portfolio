import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/resume_data.dart';
import '../widgets/project_card.dart';
import '../widgets/phone_mockup.dart';
import '../widgets/grid_painter.dart';
import '../widgets/skill_badge.dart';
import '../widgets/education_timeline.dart';
import '../widgets/contact_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

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
      extendBodyBehindAppBar: true,
      appBar: _buildBlurAppBar(context),
      endDrawer: _buildDrawer(context),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: GridPainter(
                color: const Color(0xFF00e5ff).withOpacity(0.03),
                spacing: 60,
              ),
            ),
          ),
          Positioned(
            top: 100, right: -100,
            width: 600, height: 600,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x1A00e5ff), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100, left: -100,
            width: 600, height: 600,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x1A7c3aed), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned.fill(
             child: Opacity(
               opacity: 0.15,
               child: IgnorePointer(
                 child: Image.network(
                   'https://www.transparenttextures.com/patterns/stardust.png',
                   repeat: ImageRepeat.repeat,
                 ),
               ),
             ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 150),
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
      preferredSize: const Size.fromHeight(80),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: const Color(0xFF0a0a0f).withOpacity(0.85),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ABHINAV S",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                    letterSpacing: -0.5,
                  ),
                ),
                if (!isMobile)
                  Row(
                    children: [
                      _navLink("HOME", context, () => _scrollTo(_homeKey)),
                      const SizedBox(width: 32),
                      _navLink("PROJECTS", context, () => _scrollTo(_projectsKey)),
                      const SizedBox(width: 32),
                      _navLink("EDUCATION", context, () => _scrollTo(_educationKey)),
                      const SizedBox(width: 32),
                      _navLink("CONTACT", context, () => _scrollTo(_contactKey)),
                    ],
                  )
                else
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
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
      backgroundColor: const Color(0xFF0a0a0f).withOpacity(0.95),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 48),
          _drawerLink("HOME", context, () {
            Navigator.pop(context);
            _scrollTo(_homeKey);
          }),
          const SizedBox(height: 24),
          _drawerLink("PROJECTS", context, () {
            Navigator.pop(context);
            _scrollTo(_projectsKey);
          }),
          const SizedBox(height: 24),
          _drawerLink("EDUCATION", context, () {
            Navigator.pop(context);
            _scrollTo(_educationKey);
          }),
          const SizedBox(height: 24),
          _drawerLink("CONTACT", context, () {
            Navigator.pop(context);
            _scrollTo(_contactKey);
          }),
        ],
      ),
    );
  }

  Widget _drawerLink(String title, BuildContext context, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
          fontSize: 24,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _navLink(String title, BuildContext context, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: const Color(0xFF6b6b80),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Stack(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Theme.of(context).primaryColor,
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
                    ..strokeWidth = 1.5
                    ..color = Theme.of(context).primaryColor,
                ),
              ),
              Text(
                "FLUTTER\nDEVELOPER",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "I build exceptional and accessible digital experiences for the web and mobile.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () => _scrollTo(_projectsKey),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: Text("VIEW PROJECTS", style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black)),
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
    return Text(
      ResumeData.summary,
      style: Theme.of(context).textTheme.bodyLarge,
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
