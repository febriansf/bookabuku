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
          Container(
            margin: const EdgeInsets.only(bottom: 10),
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
                // _isSearching = true;
                setState(() {
                  _isSearching = true;
                });

                final result = await searcher.searchBooks(value);
                setState(() {
                  _isSearching = false;
                  customBookList = result;
                });
              },
            ),
          ),
          Expanded(
            child: _isSearching
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                        kColor6,
                      )),
                    ],
                  )
                : ListView.builder(
                    itemCount: customBookList.length,
                    itemBuilder: (context, index) {
                      final bookDetails = customBookList[index];

                      return Container(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 140,
                              padding: const EdgeInsets.all(5.0),
                              child: Image.network(
                                bookDetails.imageLinks.isEmpty
                                    ? defaultCover
                                    : bookDetails.imageLinks['thumbnail']
                                        .toString(),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10.0, left: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(bookDetails.title,
                                            style: const TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold,
                                                color: kColor2)),
                                        const Divider(
                                          color: kColor2,
                                        ),
                                        Text(
                                          bookDetails.authors.isEmpty
                                              ? "Unknown Author"
                                              : bookDetails.authors.last,
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              color: kColor2,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                            bookDetails.publisher.isEmpty
                                                ? "Unknown Publisher"
                                                : bookDetails.publisher,
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: kColor2,
                                                fontWeight: FontWeight.w400)),
                                        Text("${bookDetails.pageCount} halaman",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: kColor2,
                                                fontWeight: FontWeight.w400)),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: kColor2,
                                              size: 18,
                                            ),
                                            Text(
                                                "${bookDetails.averageRating} / 5.0",
                                                style: const TextStyle(
                                                    fontSize: 14.0,
                                                    color: kColor2)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
//note
