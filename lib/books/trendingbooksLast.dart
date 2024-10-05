import 'package:flutter/material.dart';
import 'package:freshers/books/book.dart';
import 'package:freshers/books/bookopenedTrending.dart';

class TrendingBookItem extends StatelessWidget {
  final Book book;

  TrendingBookItem({required this.book});

  @override
  Widget build(BuildContext context) {
    String coverUrl = getDirectImageUrl(book.coverUrl);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookOpenedTrendingBooks(
              book: book, // No operation here
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(coverUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Hero(
            tag: 'book_${book.id}',
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.1), Colors.black.withOpacity(0.6)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _truncateText(book.title),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 8),
                  Text(
                    _truncateText(book.author),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _truncateText(String text) {
    if (text.length > 15) {
      return text.substring(0, 12) + '...';
    }
    return text;
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
