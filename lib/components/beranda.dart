import 'package:bookabuku/pages/login_pages.dart';
import 'package:bookabuku/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookabuku/constant.dart';
import 'package:bookabuku/components/components.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  bool _isSigningOut = false;

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            //   child: Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           widget._user.photoURL != null
            //               ? ClipOval(
            //                   child: Material(
            //                     color: Colors.amber[200],
            //                     child: Image.network(
            //                       widget._user.photoURL!,
            //                       fit: BoxFit.fitHeight,
            //                       scale: 2.2,
            //                     ),
            //                   ),
            //                 )
            //               : ClipOval(
            //                   child: Material(
            //                       color: Colors.amber[200],
            //                       child: Icon(
            //                         Icons.person,
            //                         size: 25,
            //                         color: kColor5,
            //                       )),
            //                 ),
            //           _isSigningOut
            //               ? const CircularProgressIndicator(
            //                   valueColor:
            //                       AlwaysStoppedAnimation<Color>(Colors.white),
            //                 )
            //               : ElevatedButton(
            //                   style: ButtonStyle(
            //                       backgroundColor: MaterialStateProperty.all(
            //                           Colors.transparent)),
            //                   onPressed: () async {
            //                     setState(() {
            //                       _isSigningOut = true;
            //                     });

            //                     await Authentication.signOut(context: context);
            //                     setState(() {
            //                       _isSigningOut = false;
            //                     });

            //                     Navigator.of(context)
            //                         .pushReplacement(_routeToLogInPage());
            //                   },
            //                   child: Icon(Icons.exit_to_app),
            //                 )
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: const Text(
                'Buku Rekomendasi',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: kColor2,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                // color: kColor5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.start,
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
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1639163872l/58293924.jpg',
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
                  const Text("Drama",
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
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                  child: const Row(
                    children: [
                      bookList(),
                      bookList(),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Fantasi",
                      style: TextStyle(
                          fontSize: 20.0,
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
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                  child: const Row(
                    children: [
                      bookList(),
                      bookList(),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Horor",
                      style: TextStyle(
                          fontSize: 20.0,
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
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                  child: const Row(
                    children: [
                      bookList(),
                      bookList(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}