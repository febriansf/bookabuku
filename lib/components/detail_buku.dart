import 'package:bookabuku/constant.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatefulWidget {
  final book;
  const BookDetailPage({Key? key, required this.book}) : super(key: key);
  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
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
    );
  }
}
