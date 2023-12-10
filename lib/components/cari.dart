import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(21),
            child: SearchBar(
              elevation: MaterialStateProperty.all(0.0),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.blue)),
              hintText: 'Cari buku',
              hintStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.grey)),
              trailing: [
                const Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
              ],
              onSubmitted: (String value) {
                print('value: $value');
              },
            ),
          ),
          Center(
            child: Text(
              (() {
                if (true) {
                  return "Maaf buku yang kamu cari tidak tersedia";
                } else {
                  return "Buku tidak ada";
                }
              })(),
              style: TextStyle(
                  fontSize: 16.0,
                  // fontWeight: FontWeight.bold,
                  color: Color(0xFF3EC6FF)),
            ),
          )
        ],
      ),
    );
  }
}
