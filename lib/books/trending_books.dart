import 'package:cloud_firestore/cloud_firestore.dart';
import 'book.dart';

class TrendingBooks {
  static Future<List<Book>> getTrendingBooks() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('DevsChoice').get();
    return snapshot.docs.map((doc) => Book.fromFirestore(doc)).toList();
  }
}
