import 'package:flutter/material.dart';
import 'package:freshers/books/book.dart';
import 'package:freshers/books/bookopened.dart';

class InterestBookItem extends StatelessWidget {
  final Book book;
  final Function(Book) onFavorite;
  final Function(Book) onRemoveFavorite;

  InterestBookItem({
    required this.book,
    required this.onFavorite,
    required this.onRemoveFavorite,
  });

  @override
  Widget build(BuildContext context) {
    String coverUrl = getDirectImageUrl(book.coverUrl);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookOpenedInterestBooks(
              book: book,
              onFavorite: onFavorite,
              onRemoveFavorite: onRemoveFavorite,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(        
              tag: 'book_${book.id}',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(coverUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            _truncateText(book.title),
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _truncateText(book.author),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, size: 12, color: Colors.grey[600]),
                  SizedBox(width: 2),
                  Text(
                    book.rating.toString(),
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              
            ],
          ),
        ],  
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
