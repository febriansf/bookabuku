import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:bookabuku/constant.dart';
import 'package:bookabuku/utils/bookApi.dart';
import 'package:books_finder/books_finder.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<BookInfo> customBookList = [];
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: const Text(
              'Cari Buku',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: kColor2,
              ),
            ),
          ),
          SizedBox(
            child: AnimatedSearchBar(
              label: "Search By Author, Title, or ISBN",
              labelStyle:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
              textInputAction: TextInputAction.done,
              searchDecoration: const InputDecoration(
                label: Text("Seach Book"),
                alignLabelWithHint: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                border: UnderlineInputBorder(),
              ),
              onFieldSubmitted: (value) async {
                BookSearcher searcher = BookSearcher();
                _isSearching = true;
                final result = await searcher.searchBooks(value);

                setState(() {
                  customBookList = result;
                });
              },
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: customBookList.length,
            itemBuilder: (context, index) {
              final bookDetails = customBookList[index];

              return Container(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      padding: EdgeInsets.all(5.0),
                      child: Image.network(
                        bookDetails.imageLinks.isEmpty
                            ? defaultCover
                            : bookDetails.imageLinks['thumbnail'].toString(),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(bookDetails.title,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: kColor5)),
                                Text(bookDetails.authors.first,
                                    style: TextStyle(
                                        fontSize: 15.0, color: kColor5)),
                                Text(
                                    bookDetails.publisher.isEmpty
                                        ? "Unknown Publisher"
                                        : bookDetails.publisher,
                                    style: TextStyle(
                                        fontSize: 15.0, color: kColor5)),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: kColor5,
                                      size: 18,
                                    ),
                                    Text("4.5 / 5",
                                        style: TextStyle(
                                            fontSize: 15.0, color: kColor5)),
                                  ],
                                )
                              ],
                            ),
                          ),
                          // Text(bookDetails.title),
                          // Text(bookDetails.authors.first),
                          Text(bookDetails.publisher.isEmpty
                              ? "Unknown Publisher"
                              : bookDetails.publisher),
                          Text(bookDetails.pageCount.toString()),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
//note
