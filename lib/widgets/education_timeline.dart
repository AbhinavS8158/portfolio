import 'package:flutter/material.dart';
import '../models/resume_data.dart';

class EducationTimeline extends StatelessWidget {
  const EducationTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ResumeData.education.map((edu) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(0.5),
                          blurRadius: 10,
                        )
                      ]
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 80,
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edu.degree,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 22,
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      edu.institution,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      edu.duration,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
