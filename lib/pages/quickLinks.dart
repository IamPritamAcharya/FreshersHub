import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickLinksPage extends StatelessWidget {
  final List<Map<String, String>> quickLinks = [
    {'title': 'ERP', 'url': 'https://igit.icrp.in/academic/'},
    {'title': 'Syllabus', 'url': 'https://drive.google.com/file/d/12qkihVz6YnSFjdvYaojhuzqVYMhzzSdq/view?usp=drive_link'},
    {'title': 'Anti ragging cell', 'url': 'https://igitsarang.ac.in/instprofile/infotopublic/antiraggingcell'},
    {'title': 'Holidays', 'url': 'https://drive.google.com/file/d/1Yi3b34Wz5JM-s1WHgozneDiHA6Ot4o80/view?usp=drive_link'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: quickLinks.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  quickLinks[index]['title']!,
                  style: GoogleFonts.ptSans(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.primary),
                onTap: () {
                  _launchURL(quickLinks[index]['url']!);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

}
