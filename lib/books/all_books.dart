import 'package:freshers/books/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllBooks {
  static Future<List<Book>> getAllBooks() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('books').get();
    return snapshot.docs.map((doc) => Book.fromFirestore(doc)).toList();
  }
}
