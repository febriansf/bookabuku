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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          const Row(),
          SizedBox(
            child: AnimatedSearchBar(
              label: "Search By Author, Title, or ISBN",
              labelStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
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

              return SizedBox(
                height: 200,
                child: Text(bookDetails.title),
              );
            },
          ))
        ],
      ),
    );
  }
}
//note
