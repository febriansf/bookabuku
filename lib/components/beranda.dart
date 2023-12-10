import 'package:bookabuku/pages/login_pages.dart';
import 'package:bookabuku/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookabuku/constant.dart';

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
      pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
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
    // return
    //
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget._user.photoURL != null
                          ? ClipOval(
                              child: Material(
                                color: Colors.amber[200],
                                child: Image.network(
                                  widget._user.photoURL!,
                                  fit: BoxFit.fitHeight,
                                  scale: 2,
                                ),
                              ),
                            )
                          : ClipOval(
                              child: Material(
                                  color: Colors.amber[200],
                                  child: Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.grey[400],
                                  )),
                            ),
                      _isSigningOut
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              onPressed: () async {
                                setState(() {
                                  _isSigningOut = true;
                                });

                                await Authentication.signOut(context: context);
                                setState(() {
                                  _isSigningOut = false;
                                });

                                Navigator.of(context)
                                    .pushReplacement(_routeToLogInPage());
                              },
                              child: Icon(Icons.exit_to_app),
                            )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.fromLTRB(20, 20, 0, 20),
              child: Text(
                'Hai, ' + widget._user.displayName!,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: kColor5,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              // height: 235,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                // color: Color(0xFF3EC6FF),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Rekomendasi",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3EC6FF))),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
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
                                    // alignment: Alignment.topRight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("bookTitle123",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF3EC6FF))),
                                        Text("4.5 / 5",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                // fontWeight: FontWeight.bold,
                                                color: Color(0xFF3EC6FF))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      // alignment: Alignment.bottomRight,
                                      child: Container(
                                    width: 100,
                                    height: 35,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text("Lihat buku   >",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      style: TextButton.styleFrom(
                                          backgroundColor: Color(0xFF3EC6FF)),
                                    ),
                                  )),
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
            Text("Rekomendasi",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3EC6FF))),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 5),
                  child: Row(
                    children: [
                      bookList(),
                      bookList(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                  child: Row(
                    children: [
                      bookList(),
                      bookList(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                  child: Row(
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

class bookList extends StatelessWidget {
  const bookList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Card(
              elevation: 0,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1639163872l/58293924.jpg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text("Book Of Night",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3EC6FF))),
          Text("4.5/5",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3EC6FF))),
        ],
      ),
    );
  }
}
