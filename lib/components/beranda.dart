import 'package:bookabuku/pages/login_pages.dart';
import 'package:bookabuku/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  late User _user;
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
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 20),
      child: Column(
        children: [
          Row(),
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
                          scale: 1.5,
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
              Row(
                children: [
                  const Text(
                    'Hello, ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget._user.displayName!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _isSigningOut
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent)),
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
    );
  }
}
