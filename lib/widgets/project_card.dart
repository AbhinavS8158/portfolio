import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/resume_data.dart';
import 'dart:math';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  _ProjectCardState createState() => _ProjectCardState();
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
          y = (event.localPosition.dy / 280) - 0.5;
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
          ..rotateX(y * pi * 0.15)
          ..rotateY(-x * pi * 0.15),
        child: Container(
          width: 350,
          constraints: const BoxConstraints(minHeight: 320),
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF1e1e2e)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.project.title,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 24,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.project.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.project.techStack.map((tech) => Chip(
                  label: Text(tech, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 10, color: Theme.of(context).primaryColor)),
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  side: BorderSide.none,
                )).toList(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: widget.project.links.entries.map((entry) {
                  return IconButton(
                    icon: Icon(
                      entry.key.toLowerCase().contains('github') ? Icons.code : Icons.open_in_new,
                      color: Colors.white70,
                      size: 20,
                    ),
                    onPressed: () async {
                      final uri = Uri.parse(entry.value);
                      try {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      } catch (e) {
                        debugPrint("Could not launch url: $e");
                      }
                    },
                    tooltip: entry.key,
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
