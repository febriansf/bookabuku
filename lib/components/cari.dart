import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:bookabuku/constant.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          const Row(),
          const SizedBox(
            child: AnimatedSearchBar(
              label: "Search By Author, Title, or ISBN",
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              textInputAction: TextInputAction.done,
              searchDecoration: InputDecoration(
                label: Text("Seach Book"),
                alignLabelWithHint: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [],
            ),
          )
        ],
      ),
    );
  }
}
//note
