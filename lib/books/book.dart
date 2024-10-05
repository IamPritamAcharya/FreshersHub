import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverUrl;
  final String gDriveUrl;
  final double rating;
  final bool isTrending; // New field

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverUrl,
    required this.gDriveUrl,
    required this.rating,
    this.isTrending = false, // Default value
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Book(
      id: doc.id,
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      description: data['description'] ?? '',
      coverUrl: data['coverUrl'] ?? '',
      gDriveUrl: data['gDriveUrl'] ?? '',
      rating: data['rating']?.toDouble() ?? 0.0,
      isTrending: data['isTrending'] ?? false, // Fetch this field from Firestore
    );
  }
}
