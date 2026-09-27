import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/resume_data.dart';
import 'glass_container.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  double x = 0.0;
  double y = 0.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          x = (event.localPosition.dx / 350) - 0.5;
          y = (event.localPosition.dy / 300) - 0.5;
        });
      },
      onExit: (event) {
        setState(() {
          x = 0.0;
          y = 0.0;
        });
      },
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(y * pi * 0.12)
          ..rotateY(-x * pi * 0.12),
        child: Container(
          width: 350,
          constraints: const BoxConstraints(minHeight: 320),
          margin: const EdgeInsets.all(16),
          child: LiquidGlassContainer(
            borderRadius: 24,
            blur: 20,
            padding: const EdgeInsets.all(28),
            enableHoverEffect: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.project.title,
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontSize: 24,
                                  letterSpacing: -0.5,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF00E5FF),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF00E5FF),
                                blurRadius: 8,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      widget.project.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFFCBD5E1),
                            height: 1.5,
                          ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.project.techStack.map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00E5FF).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF00E5FF).withValues(alpha: 0.3),
                              width: 0.8,
                            ),
                          ),
                          child: Text(
                            tech,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  fontSize: 11,
                                  color: const Color(0xFF00E5FF),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: widget.project.links.entries.map((entry) {
                        return Material(
                          color: Colors.transparent,
                          child: IconButton(
                            icon: Icon(
                              entry.key.toLowerCase().contains('github')
                                  ? Icons.code_rounded
                                  : Icons.launch_rounded,
                              color: Colors.white70,
                              size: 20,
                            ),
                            hoverColor: const Color(0xFF00E5FF).withValues(alpha: 0.2),
                            splashRadius: 20,
                            onPressed: () async {
                              final uri = Uri.parse(entry.value);
                              try {
                                await launchUrl(uri, mode: LaunchMode.externalApplication);
                              } catch (e) {
                                debugPrint("Could not launch url: $e");
                              }
                            },
                            tooltip: entry.key,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
