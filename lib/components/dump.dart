import 'package:bookabuku/constant.dart';
import 'package:bookabuku/utils/bookApi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DumpPage extends StatefulWidget {
  const DumpPage({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  State<DumpPage> createState() => _DumpPageState();
}

class _DumpPageState extends State<DumpPage> {
  late String userId;
  bool _isLoading = false;
  late List booksCollection = [];

  @override
  void initState() {
    userId = widget._user.uid;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _authorController = TextEditingController();
    final TextEditingController _isbnController = TextEditingController();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _authorController,
            decoration: const InputDecoration(labelText: 'Author'),
          ),
          TextField(
            controller: _isbnController,
            decoration: const InputDecoration(labelText: 'ISBN_13'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Ganti dengan ID pengguna yang diinginkan
                  setState(() {
                    _isLoading = true;
                  });

                  FirebaseConnector myConnector =
                      FirebaseConnector(userId, 'myBooks');
                  myConnector.initializeConnector();

                  final collections = await myConnector.getAllCollection();

                  setState(() {
                    _isLoading = false;
                    booksCollection = collections;
                  });
                },
                child: Text('Get'),
              ),
              const SizedBox(
                width: 10,
              ),
              // ElevatedButton(
              //   onPressed: () async {
              //     // Ganti dengan ID pengguna yang diinginkan

              //     FirebaseConnector myConnector =
              //         FirebaseConnector(userId, 'myBooks');
              //     myConnector.initializeConnector();

              //     await myConnector.addData(
              //       title: _titleController.text,
              //       author: _authorController.text,
              //       isbn13: _isbnController.text,
              //     );
              //     final collections = await myConnector.getAllCollection();

              //     setState(() {
              //       _isLoading = false;
              //       booksCollection = collections;
              //     });
              //   },
              //   child: Text('Add'),
              // ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Expanded(
            child: _isLoading
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
                    itemCount: booksCollection.length,
                    itemBuilder: (context, index) {
                      final bookDetail = booksCollection[index];

                      return Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(bookDetail.data()['Title']),
                            Text(bookDetail.data()['ISBN_13']),
                            Text(bookDetail.id),
                            SizedBox(height: 10),
                            deleteButton(docId: bookDetail.id),
                          ],
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }

  ElevatedButton deleteButton({required String docId}) {
    return ElevatedButton(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
      onPressed: () async {
        FirebaseConnector myConnector = FirebaseConnector(userId, 'myBooks');
        myConnector.initializeConnector();

        myConnector.deleteData(docId);

        final collections = await myConnector.getAllCollection();

        setState(() {
          _isLoading = false;
          booksCollection = collections;
        });
      },
      child: Text('Delete'),
    );
  }
}
