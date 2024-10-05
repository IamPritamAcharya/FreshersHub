import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:freshers/roadmaps/linkRoadmap.dart';
import 'package:freshers/roadmaps/subjectRoadmaps.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class RoadmapPage extends StatefulWidget {
  @override
  _RoadmapPageState createState() => _RoadmapPageState();
}

class _RoadmapPageState extends State<RoadmapPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -0.3, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getGoogleDriveDownloadLink(String url) {
    final fileId = url.split('/d/')[1].split('/')[0];
    return "https://drive.google.com/uc?export=download&id=$fileId";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 25, 12, 40),
              Color.fromARGB(255, 25, 12, 40),
              Color.fromARGB(255, 13, 7, 22),
            ],
            stops: [0, 0.7, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              colors: [Colors.purple, Color.fromARGB(255, 244, 172, 243), Color.fromARGB(255, 198, 108, 214)],
                              stops: [_animation.value, _animation.value + 0.3, _animation.value + 0.4],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                            ).createShader(bounds);
                          },
                          child: Text(
                            'Developer Roadmaps',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // This color will be replaced by the gradient
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 17),
                  Divider(color: Colors.white.withAlpha(20)),
                  SizedBox(height: 30),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: roadmaps_subject.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );

                          final url = getGoogleDriveDownloadLink(roadmaps_subject[index]['url']!);
                          File? file = await loadPdfFromNetwork(url);

                          Navigator.pop(context); // Close the loading dialog

                          if (file != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFViewerPage(file: file),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to load PDF')),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 108, 39, 154).withAlpha(10),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color.fromARGB(255, 60, 40, 62), // Specify the border color here
                              width: 2.0, // Specify the border width here
                            ),
                          ),
                          child: Center(
                            child: Text(
                              roadmaps_subject[index]['title']!,
                              style: GoogleFonts.ptSans(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),

                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 40),
                  Divider(color: Colors.white.withAlpha(20)),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: roadmaps.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );

                          final url = getGoogleDriveDownloadLink(roadmaps[index]['url']!);
                          File? file = await loadPdfFromNetwork(url);

                          Navigator.pop(context); // Close the loading dialog

                          if (file != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFViewerPage(file: file),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to load PDF')),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 108, 39, 154).withAlpha(10),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color.fromARGB(255, 60, 40, 62), // Specify the border color here
                              width: 2.0, // Specify the border width here
                            ),
                          ),
                          child: Center(
                            child: Text(
                              roadmaps[index]['title']!,
                              style: TextStyle(color: Colors.white, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Divider(color: Colors.white.withAlpha(20)),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<File?> loadPdfFromNetwork(String url) async {
    try {
      print('Downloading PDF from $url');
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getApplicationDocumentsDirectory();
        final filePath = '${dir.path}/${Uri.parse(url).pathSegments.last}';
        print('Saving PDF to $filePath');
        final file = File(filePath);

        await file.writeAsBytes(bytes, flush: true);
        return file;
      } else {
        print('Error downloading PDF: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error loading PDF from network: $e');
      return null;
    }
  }
}

class PDFViewerPage extends StatelessWidget {
  final File file;

  PDFViewerPage({required this.file});

  @override
  Widget build(BuildContext context) {
    print('Opening PDF at ${file.path}');
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: PDFView(
          filePath: file.path,
          onRender: (pages) {
            print('PDF rendered with $pages pages');
          },
          onError: (error) {
            print('Error while rendering PDF: $error');
          },
          onPageError: (page, error) {
            print('Error on page $page: $error');
          },
        ),
      ),
    );
  }
}
