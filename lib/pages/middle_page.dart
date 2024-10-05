import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MiddlePage extends StatefulWidget {
  @override
  _MiddlePageState createState() => _MiddlePageState();
}

class _MiddlePageState extends State<MiddlePage> {
  List<Notice> notices = [];
  bool isLoading = true;
  int currentPage = 1;
  final int noticesPerPage = 10;
  Timer? _timer;
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    fetchNotices();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(Duration(minutes: 15), (timer) {
      fetchNotices();
    });
  }

  Future<void> fetchNotices() async {
    try {
      // Fetch the URL from Firestore
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('Noticelink').doc('YeInNuZs6TzHacQzAoTf').get();
      String url = doc['link'];

      // Fetch notices from the URL
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final document = html_parser.parse(response.body);
        final noticeElements = document.querySelectorAll('tr[id^="noticerow_"]');

        final List<Notice> fetchedNotices = noticeElements.map((element) {
          final titleElement = element.children[0];
          final dateElement = element.children[1];
          final downloadElement = element.children[2].querySelector('a');

          return Notice(
            title: titleElement?.text.trim() ?? 'No Title',
            date: dateElement?.text.trim() ?? 'No Date',
            downloadLink: downloadElement?.attributes['href'] ?? '#',
          );
        }).toList();

        setState(() {
          notices = fetchedNotices;
          isLoading = false;
          isFirstLoad = false;
        });
      } else {
        setState(() {
          isLoading = false;
          isFirstLoad = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        isFirstLoad = false;
      });
      print('Error fetching notices: $e');
    }
  }

  Future<void> _refreshNotices() async {
    setState(() {
      isLoading = true;
    });
    await fetchNotices();
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (notices.length / noticesPerPage).ceil();
    final startIndex = (currentPage - 1) * noticesPerPage;
    final endIndex = (startIndex + noticesPerPage) > notices.length ? notices.length : (startIndex + noticesPerPage);
    final displayedNotices = notices.sublist(startIndex, endIndex);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: LiquidPullToRefresh(
        backgroundColor: Theme.of(context).colorScheme.primary,
        color: Theme.of(context).colorScheme.surface,
        onRefresh: _refreshNotices,
        showChildOpacityTransition: false,
        height: 100,
        animSpeedFactor: 2,
        springAnimationDurationInMilliseconds: 700,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Notices',
                  style: GoogleFonts.ptSans(
                    textStyle: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Divider(
                  color: Theme.of(context).colorScheme.primary,
                  thickness: 1,
                ),
              ),
              if (isLoading)
                _buildShimmerEffect()
              else
                ListView.builder(
                  padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: displayedNotices.length,
                  itemBuilder: (context, index) {
                    final notice = displayedNotices[index];
                    return Card(
                      color: Theme.of(context).colorScheme.tertiary,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          notice.title,
                          style: GoogleFonts.ptSans(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          notice.date,
                          style: GoogleFonts.ptSans(
                            textStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.download, color: Colors.green),
                          onPressed: () {
                            _launchURL(notice.downloadLink);
                          },
                        ),
                      ),
                    );
                  },
                ),
              if (totalPages > 1) _buildPagination(totalPages),
              SizedBox(height: 15,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPagination(int totalPages) {
    const maxPagesToShow = 6;
    final startPage = (currentPage - 2).clamp(1, totalPages - maxPagesToShow + 1);
    final endPage = (startPage + maxPagesToShow - 1).clamp(1, totalPages);

    List<Widget> pageButtons = [];

    for (int i = startPage; i <= endPage; i++) {
      pageButtons.add(
        GestureDetector(
          onTap: () {
            setState(() {
              currentPage = i;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: currentPage == i ? Colors.blueAccent : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Text(
              i.toString(),
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: currentPage == i ? Colors.white : Colors.black,
                  fontWeight: currentPage == i ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    if (startPage > 1) {
      pageButtons.insert(
        0,
        GestureDetector(
          onTap: () {
            setState(() {
              currentPage = startPage - 1;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Text(
              '...',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      );
    }

    if (endPage < totalPages) {
      pageButtons.add(
        GestureDetector(
          onTap: () {
            setState(() {
              currentPage = endPage + 1;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Text(
              '...',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: pageButtons,
      ),
    );
  }

  Widget _buildShimmerEffect() {
    final brightness = Theme.of(context).brightness;
    final baseColor = brightness == Brightness.dark ? Colors.grey[900]! : Colors.grey[300]!;
    final highlightColor = brightness == Brightness.dark ? Colors.grey[800]! : Colors.grey[100]!;

    return ListView.builder(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: noticesPerPage,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: ListTile(
              title: Container(
                width: double.infinity,
                height: 16.0,
                color: Colors.white,
              ),
              subtitle: Container(
                width: double.infinity,
                height: 14.0,
                color: Colors.white,
              ),
              trailing: Icon(Icons.download, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}

class Notice {
  final String title;
  final String date;
  final String downloadLink;

  Notice({
    required this.title,
    required this.date,
    required this.downloadLink,
  });
}
