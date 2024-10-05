import 'package:flutter/material.dart';
import 'package:freshers/books/book.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class BookOpenedInterestBooks extends StatefulWidget {
  final Book book;
  final Function(Book) onFavorite;
  final Function(Book) onRemoveFavorite;

  const BookOpenedInterestBooks({
    Key? key,
    required this.book,
    required this.onFavorite,
    required this.onRemoveFavorite,
  }) : super(key: key);

  @override
  _BookOpenedInterestBooksState createState() => _BookOpenedInterestBooksState();
}

class _BookOpenedInterestBooksState extends State<BookOpenedInterestBooks> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  void _checkIfFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteIds = prefs.getStringList('favoriteBooks');
    setState(() {
      isFavorite = favoriteIds != null && favoriteIds.contains(widget.book.id);
    });
  }

  void _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteIds = prefs.getStringList('favoriteBooks') ?? [];

    if (isFavorite) {
      favoriteIds.remove(widget.book.id);
      widget.onRemoveFavorite(widget.book);
    } else {
      favoriteIds.add(widget.book.id);
      widget.onFavorite(widget.book);
    }

    await prefs.setStringList('favoriteBooks', favoriteIds);
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = getDirectImageUrl(widget.book.coverUrl);

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.dark ? Color.fromARGB(255, 25, 25, 25) : theme.colorScheme.primary,
      appBar: AppBar(
        backgroundColor: theme.brightness == Brightness.dark ? Color.fromARGB(255, 25, 25, 25) : theme.colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Hero(
                tag: 'book_${widget.book.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return const Center(
                        child: Text(
                          'Failed to load image',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 10,),
                Text(
                  widget.book.title,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Author: ${widget.book.author}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark ? Colors.grey.shade900 : theme.colorScheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'About',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.book.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 16),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final url = Uri.parse(widget.book.gDriveUrl);
                              if (!await launchUrl(url)) {
                                throw 'Could not launch $url';
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.secondary,
                            ),
                            child: Text(
                              'OPEN',
                              style: TextStyle(color: theme.brightness == Brightness.dark ? theme.colorScheme.primary : theme.colorScheme.surface),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                      ],
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

  String getDirectImageUrl(String coverUrl) {
    final RegExp pattern = RegExp(r"drive\.google\.com\/file\/d\/(.+?)\/view");
    final match = pattern.firstMatch(coverUrl);
    if (match != null) {
      final fileId = match.group(1);
      return 'https://drive.google.com/uc?export=view&id=$fileId';
    }
    return coverUrl;
  }
}
