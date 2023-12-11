// ignore: file_names
import 'package:books_finder/books_finder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookSearcher {
  Future<List<BookInfo>> searchBooks(String query) async {
    final books = await queryBooks(
      query,
      maxResults: 10,
      printType: PrintType.books,
      orderBy: OrderBy.relevance,
      reschemeImageLinks: true,
    );

    final bookInfoList = books.map((book) => book.info).toList();
    return bookInfoList;
  }

  Future getDetailInfo(String isbn) async {
    final List<Book> books = await queryBooks(
      isbn,
      queryType: QueryType.isbn,
      maxResults: 1,
      printType: PrintType.books,
      orderBy: OrderBy.relevance,
      reschemeImageLinks: true,
    );

    final bookInfo = books.last.info;
    return bookInfo;
  }
}

class FirebaseConnector {
  String userid;
  String collectionName;

  FirebaseConnector(this.userid, this.collectionName);
  late DocumentReference userDocRef;
  late CollectionReference userCollectionRef;

  Future initializeConnector() async {
    userDocRef = FirebaseFirestore.instance.collection('users').doc(userid);
    return userDocRef;
  }

  Future getAllCollection() async {
    try {
      CollectionReference userCollectionRef =
          userDocRef.collection(collectionName);
      QuerySnapshot querySnapshot = await userCollectionRef.get();

      // Memeriksa apakah data ditemukan
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs;

        // Looping melalui setiap dokumen di koleksi pengguna
        // for (var doc in querySnapshot.docs) {
        //   var data = doc.data();
        //   print('Document ID: ${doc.id}');
        //   print('Data: $data');
        // }
      } else {
        debugPrint('No documents found in the user collection.');
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
  }

  Future addData(
      {required String title,
      required String author,
      required String isbn13}) async {
    try {
      CollectionReference userCollectionRef =
          userDocRef.collection(collectionName);

      Map<String, dynamic> newData = {
        'Title': title,
        'Author': author,
        'ISBN_13': isbn13,
      };

      final newDoc = await userCollectionRef.add(newData);

      // print(newDoc.id);
      debugPrint("Data Added");

      return newDoc;
    } catch (error) {
      debugPrint('Error: $error');
    }
  }

  Future deleteData(String docId) async {
    try {
      CollectionReference userCollectionRef =
          userDocRef.collection(collectionName);

      DocumentReference docToDeleteRef = userCollectionRef.doc(docId);

      await docToDeleteRef.delete();

      debugPrint('Data deleted');
    } catch (error) {
      debugPrint('Error $error');
    }
  }
}

// void main() async {
//   BookSearcher searcher = BookSearcher();

//   final List<BookInfo> result = await searcher.searchBooks('new');

//   for (final book in result) {
//     print('$book\n');
//   }
// }

// void main() async {
//   String uid = '8PHziq0YNgU5LkZSR2QhprbL1xr2';
//   FirebaseConnector myConncector = FirebaseConnector(uid);

//   print(myConncector.getAllCollection());
// }
