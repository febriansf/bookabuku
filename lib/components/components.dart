import 'package:bookabuku/pages/home_page.dart';
import 'package:bookabuku/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookabuku/constant.dart';
import 'package:bookabuku/components/detail_buku.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.textField});

  final TextField textField;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          width: 2.5,
          color: Colors.amber,
        ),
      ),
      child: textField,
    );
  }
}

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: _isSigningIn
            ? const CircularProgressIndicator(
                // Warna Loading Circle jangan sama dengan BG lah
                valueColor: AlwaysStoppedAnimation<Color>(kColor6),
              )
            : OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kColor4),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    _isSigningIn = true;
                  });

                  User? user =
                      await Authentication.signInWithGoogle(context: context);

                  setState(() {
                    _isSigningIn = false;
                  });

                  if (user != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomePage(user: user),
                      ),
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/icons/google.png'),
                        height: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Sign in with Google',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}

//list buku card
class bookList extends StatelessWidget {
  const bookList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        // onTap: () => navigateToDetailsPage(context),
        child: Column(
          children: [
            Container(
              width: 190,
              margin: EdgeInsets.only(bottom: 10),
              child: Card(
                elevation: 0,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                  defaultCover,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Column(
              children: [
                Text("Book Of Night",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3EC6FF))),
                Text("authorName",
                    style: TextStyle(
                        fontSize: 15.0,
                        // fontWeight: FontWeight.bold,
                        color: kColor5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: kColor5,
                      size: 17,
                    ),
                    Text("4.5 / 5",
                        style: TextStyle(fontSize: 15.0, color: kColor5)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void navigateToDetailsPage(bookDetail, BuildContext context) {
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => BookDetailPage(bookDetail)),
  // );
  // Navigator.of(context).push(MaterialPageRoute(
  //   builder: (context) => BookDetailPage(),
  // ));
  // Navigator.of(context).push(
  //   MaterialPageRoute(
  //     builder: (context) => BookDetailPage(),
  //   ),
  // );
}
