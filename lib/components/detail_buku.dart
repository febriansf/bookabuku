import 'package:bookabuku/constant.dart';
import 'package:books_finder/books_finder.dart';
import 'package:flutter/material.dart';
import 'package:bookabuku/utils/bookApi.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({Key? key, required BookInfo book, required User user})
      : _user = user,
        _book = book,
        super(key: key);
  final User _user;
  final BookInfo _book;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late List booksCollection = [];
  late User user;
  late BookInfo book;

  void initState() {
    user = widget._user;
    book = widget._book;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColor2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: kColor0),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Detail Buku"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                      width: MediaQuery.of(context).size.width * 0.5,
                      // height: MediaQuery.of(context).size.height * 0.4,
                      child: Card(
                        elevation: 0,
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.network(
                          book.imageLinks.isEmpty
                              ? defaultCover
                              : book.imageLinks['thumbnail'].toString(),
                          fit: BoxFit.contain,
                        ),
                        // color: Color(0xFF3EC6FF),
                      ),
                    ),
                    Text(book.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: kColor1)),
                    Text(
                        book.authors.isEmpty
                            ? "Unknown Author"
                            : book.authors.last,
                        style: TextStyle(
                            fontSize: 15.0,
                            // fontWeight: FontWeight.bold,
                            color: kColor2)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
                width: MediaQuery.of(context).size.width,
                height: 70,
                // color: Colors.blue,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Halaman"),
                          Text(
                            book.pageCount.toString(),
                            style: TextStyle(
                                color: Color(0xFF3EC6FF),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Bahasa"),
                          Text(
                            book.language,
                            style: TextStyle(
                                color: Color(0xFF3EC6FF),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Rating"),
                          Text(
                            book.averageRating.toString() + "/5.0",
                            style: TextStyle(
                                color: Color(0xFF3EC6FF),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(24),
                child: Text(
                  book.description,
                  style: TextStyle(
                    fontSize: 15.0,
                    // fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kColor2,
        label: Text('Tambahkan Koleksi'),
        onPressed: () async {
          // Ganti dengan ID pengguna yang diinginkan

          FirebaseConnector myConnector =
              FirebaseConnector(user.uid, 'myBooks');
          myConnector.initializeConnector();

          await myConnector.addData(
              title: book.title,
              author:
                  book.authors.isEmpty ? "Unknown Author" : book.authors.last,
              isbn13: book.industryIdentifiers[0].type == 'ISBN_13'
                  ? book.industryIdentifiers[0].identifier
                  : book.industryIdentifiers[1].identifier);
          final collections = await myConnector.getAllCollection();

          setState(() {
            booksCollection = collections;
            print('success');
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
