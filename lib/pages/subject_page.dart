import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Pdf {
  final String name;
  final String url;
  final IconData icon;

  Pdf({required this.name, required this.url, required this.icon});
}

class SubjectPage extends StatelessWidget {
  final String pageName;
  final List<Pdf> pdfs;

  const SubjectPage({Key? key, required this.pageName, required this.pdfs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(pageName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 5.4, // Adjust the aspect ratio to increase size
            mainAxisSpacing: 8,
          ),
          itemCount: pdfs.length,
          itemBuilder: (context, index) {
            return PdfTile(pdf: pdfs[index]);
          },
        ),
      ),
    );
  }
}

class PdfTile extends StatelessWidget {
  final Pdf pdf;

  const PdfTile({Key? key, required this.pdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiary, // Set the background color
      elevation: 1, // Add shadow around the grid
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Set the border radius
      ),
      child: Center(
        child: ListTile(
          leading: Icon(pdf.icon, color: Theme.of(context).colorScheme.primary),
          title: Text(
            pdf.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () async {
            final url = Uri.parse(pdf.url);
            if (!await launchUrl(url)) {
              throw 'Could not launch $url';
            }
          },
        ),
      ),
    );
  }
}
