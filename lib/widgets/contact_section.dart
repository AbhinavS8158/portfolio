import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  _ContactSectionState createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  String _selectedCountry = 'India';
  bool _isSubmitting = false;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);

    const String formspreeEndpoint = "https://formspree.io/f/mdargzjn";

    try {
      final response = await http.post(
        Uri.parse(formspreeEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _nameCtrl.text,
          'email': _emailCtrl.text,
          'country': _selectedCountry,
          'subject': _subjectCtrl.text,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Message sent successfully!')));
        _nameCtrl.clear();
        _emailCtrl.clear();
        _subjectCtrl.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Formspree endpoint not configured. Check source code.'),
          backgroundColor: Colors.orange,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1000;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1e1e2e)),
      ),
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: isDesktop ? 1 : 0,
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: isDesktop ? const Color(0xFF1e1e2e) : Colors.transparent,
                  ),
                  bottom: BorderSide(
                    color: !isDesktop ? const Color(0xFF1e1e2e) : Colors.transparent,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                children: [
                  _infoItem(Icons.location_on_outlined, "Location", "Sreebhavan,Tirur,Kerala", isDesktop),
                  const SizedBox(height: 32),
                  _infoItem(Icons.email_outlined, "Email", "abhinav.8158s@gmail.com", isDesktop),
                  const SizedBox(height: 32),
                  _infoItem(Icons.phone_android_outlined, "Call", "+91 9567112236", isDesktop),
                  const SizedBox(height: 48),
                  const Divider(color: Color(0xFF1e1e2e)),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
                    children: [
                      _socialIcon(Icons.link, "LinkedIn", "https://www.linkedin.com/in/abhinav-s-b8b0b8265"),
                      const SizedBox(width: 16),
                      _socialIcon(Icons.code, "GitHub", "https://github.com/AbhinavS8158"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: isDesktop ? 2 : 0,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField("First Name", "Your name..", _nameCtrl),
                    const SizedBox(height: 24),
                    _buildTextField("Email", "Your email..", _emailCtrl, isEmail: true),
                    const SizedBox(height: 24),
                    Text("Country", style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedCountry,
                      dropdownColor: Theme.of(context).cardColor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.02),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      items: ['India', 'USA', 'UK', 'Other'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                      onChanged: (val) => setState(() => _selectedCountry = val!),
                    ),
                    const SizedBox(height: 24),
                    _buildTextField("Subject", "Write something..", _subjectCtrl, maxLines: 4),
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4caf50),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        ),
                        child: _isSubmitting 
                            ? const CircularProgressIndicator(color: Colors.white) 
                            : Text("Submit", style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String title, String subtitle, bool isDesktop) {
    return Row(
      mainAxisAlignment: isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Theme.of(context).primaryColor),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Text(title, style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20, letterSpacing: 0)),
            const SizedBox(height: 4),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).primaryColor)),
          ],
        )
      ],
    );
  }

  Widget _socialIcon(IconData icon, String label, String url) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        try {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } catch (e) {
          debugPrint("Could not launch url: $e");
        }
      },
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 20),
            const SizedBox(width: 8),
            Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, {bool isEmail = false, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.02),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFF1e1e2e)), borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor), borderRadius: BorderRadius.circular(8)),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) return 'Please enter some text';
            if (isEmail && !val.contains('@')) return 'Enter a valid email';
            return null;
          },
        ),
      ],
    );
  }
}
