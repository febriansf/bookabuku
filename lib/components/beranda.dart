import 'package:bookabuku/pages/login_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookabuku/constant.dart';
import 'package:bookabuku/components/components.dart';
import 'package:bookabuku/utils/bookApi.dart';
import 'package:books_finder/books_finder.dart';
import 'package:bookabuku/components/detail_buku.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  Route _routeToLogInPage() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Future<List<BookInfo>> getData() async {
    // BookSearcher searcher = BookSearcher();

    // final result = await searcher.searchBooks('value');
    // customBookList = result;

    // return customBookList;
    FirebaseConnector myConnector =
        FirebaseConnector(widget._user.uid, 'myBooks');
    myConnector.initializeConnector();

    final collections = await myConnector.getAllCollection();

    customBookList = collections;
    return collections;
  }

  Future<List<BookInfo>> getRandom(value) async {
    BookSearcher searcher = BookSearcher();

    final result = await searcher.searchRandom(value);
    customBookList = result;

    return customBookList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: const Text(
                'Koleksi Mu',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: kColor2,
                ),
              ),
            ),
            FutureBuilder<List>(
              builder: (context, snapshot) {
                // Checking if future is resolved or not
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  print('OKE');
                  // return ListView.builder(
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.vertical,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemCount: snapshot.data!.length,
                  //   itemBuilder: (context, index) {
                  //     return Text(snapshot.data?[index]['Title'] ?? "got null");
                  //   },
                  // );
                }
                // Displaying LoadingSpinner to indicate waiting state
                return Center(
                  child:
                      // CircularProgressIndicator(),
                      Text("Kamu belum memiliki koleksi buku"),
                );
              },

              // Future that needs to be resolved
              // inorder to display something on the Canvas
              future: getData(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.network(
                                    defaultCover,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("bookTitle123",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: kColor5)),
                                        Text("authorName",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: kColor5)),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: kColor5,
                                              size: 18,
                                            ),
                                            Text("4.5 / 5",
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: kColor5)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 30,
                                    child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                          backgroundColor: kColor5),
                                      child: const Text("Lihat buku   >",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Koleksiku",
                      style: TextStyle(
                          fontSize: 20.00,
                          fontWeight: FontWeight.w500,
                          color: kColor2)),
                  TextButton(
                      onPressed: () {},
                      child: Text("Lebih banyak >",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                              color: kColor2)))
                ],
              ),
            ),
            FutureBuilder(
              builder: (context, snapshot) {
                // Checking if future is resolved or not
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  final book = snapshot.data;
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        book!.length,
                        (index) {
                          String title = book[index].data()['title'];
                          String rating = book[index].data()?['rating'];
                          String image =
                              snapshot.data?[index].data()['thumbnail'];
                          return InkWell(
                            onTap: () {
                              BookInfo bookDetail = BookInfo(
                                  title: book[index].data()['title'],
                                  subtitle: 'Null',
                                  authors: [book[index].data()['author']],
                                  publisher: 'Null Publisher',
                                  averageRating: double.parse(
                                      book[index].data()['rating']),
                                  categories: ['Null'],
                                  contentVersion: 'Null',
                                  description:
                                      book[index].data()['description'],
                                  industryIdentifiers: [
                                    IndustryIdentifier(
                                        type: 'ISBN_13',
                                        identifier:
                                            book[index].data()['isbn_13'])
                                  ],
                                  imageLinks: {
                                    'thumbnail': Uri.parse(
                                        book[index].data()['thumbnail'])
                                  },
                                  language: book[index].data()['language'],
                                  maturityRating: 'Null',
                                  pageCount: int.parse(
                                      book[index].data()['pageCount']),
                                  publishedDate: null,
                                  rawPublishedDate: 'Null',
                                  ratingsCount: 0,
                                  previewLink: Uri(),
                                  infoLink: Uri(),
                                  canonicalVolumeLink: Uri());

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookDetailPage(
                                        book: bookDetail, user: widget._user)),
                              );
                            },
                            child: Container(
                              width: 180,
                              // color: Colors.blue,
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // width: 190,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Card(
                                      elevation: 0,
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Image.network(
                                        image,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(title,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF3EC6FF))),
                                      // Text("authorName",
                                      //     style: TextStyle(
                                      //         fontSize: 15.0,
                                      //         // fontWeight: FontWeight.bold,
                                      //         color: kColor5)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: kColor5,
                                            size: 17,
                                          ),
                                          Text(rating.toString() + " / 5.0",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: kColor5)),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                // Displaying LoadingSpinner to indicate waiting state
                return Center(
                  child: CircularProgressIndicator(),
                );
              },

              // Future that needs to be resolved
              // inorder to display something on the Canvas
              future: FirebaseConnector(widget._user.uid, 'myBooks')
                  .getAllCollection(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Buku Rekomendasi",
                      style: TextStyle(
                          fontSize: 20.00,
                          fontWeight: FontWeight.w500,
                          color: kColor2)),
                  TextButton(
                      onPressed: () {},
                      child: Text("Lebih banyak >",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                              color: kColor2)))
                ],
              ),
            ),
            FutureBuilder<List>(
              builder: (context, snapshot) {
                // Checking if future is resolved or not
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        snapshot.data!.length,
                        (index) {
                          String title = snapshot.data?[index].title;
                          double rating = snapshot.data?[index].averageRating;
                          Uri image =
                              snapshot.data?[index].imageLinks['thumbnail'];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookDetailPage(
                                        book: snapshot.data?[index],
                                        user: widget._user)),
                              );
                            },
                            child: Container(
                              width: 180,
                              // color: Colors.blue,
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // width: 190,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Card(
                                      elevation: 0,
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Image.network(
                                        image.toString(),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(title,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF3EC6FF))),
                                      // Text("authorName",
                                      //     style: TextStyle(
                                      //         fontSize: 15.0,
                                      //         // fontWeight: FontWeight.bold,
                                      //         color: kColor5)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: kColor5,
                                            size: 17,
                                          ),
                                          Text(rating.toString() + " / 5.0",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: kColor5)),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                // Displaying LoadingSpinner to indicate waiting state
                return Center(
                  child: CircularProgressIndicator(),
                );
              },

              // Future that needs to be resolved
              // inorder to display something on the Canvas
              future: getRandom('Potter'),
            ),
          ],
        ),
      ),
    );
  }
}

late List<BookInfo> customBookList = [];
