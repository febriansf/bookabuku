import 'package:bookabuku/constant.dart';
import 'package:flutter/material.dart';
import 'package:bookabuku/utils/bookApi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookabuku/components/info_user.dart';

class BookDetailPage extends StatefulWidget {
  final book;

  const BookDetailPage({Key? key, required this.book, required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late List booksCollection = [];
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
                          widget.book.imageLinks.isEmpty
                              ? defaultCover
                              : widget.book.imageLinks['thumbnail'].toString(),
                          fit: BoxFit.contain,
                        ),
                        // color: Color(0xFF3EC6FF),
                      ),
                    ),
                    Text(widget.book.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: kColor1)),
                    Text(
                        widget.book.authors.isEmpty
                            ? "Unknown Author"
                            : widget.book.authors.last,
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
                            widget.book.pageCount.toString(),
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
                            widget.book.language,
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
                            widget.book.averageRating.toString() + "/5.0",
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
                  widget.book.description,
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
        label: Text('Tambah Koleksi'),
        onPressed: () async {
          // Ganti dengan ID pengguna yang diinginkan

          FirebaseConnector myConnector =
              FirebaseConnector(widget._user.uid, 'myBooks');
          myConnector.initializeConnector();

          await myConnector.addData(
            title: widget.book.title,
            author: widget.book.author,
            isbn13: widget.book.title,
          );
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
