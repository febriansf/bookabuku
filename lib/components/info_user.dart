import 'package:bookabuku/pages/login_pages.dart';
import 'package:bookabuku/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookabuku/constant.dart';
import 'package:bookabuku/components/components.dart';

class InfoUserPage extends StatefulWidget {
  const InfoUserPage({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  State<InfoUserPage> createState() => _InfoUserPageState();
}

class _InfoUserPageState extends State<InfoUserPage> {
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
    return Center(
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
                          scale: 2.2,
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Material(
                          color: Colors.amber[200],
                          child: Icon(
                            Icons.person,
                            size: 25,
                            color: kColor5,
                          )),
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
        ],
      ),
    );
  }
}
