import 'package:bookabuku/constant.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatefulWidget {
  final book;
  const BookDetailPage({Key? key, required this.book}) : super(key: key);
  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColor2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: kColor0),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Detail Buku"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                      width: MediaQuery.of(context).size.width * 0.5,
                      // height: MediaQuery.of(context).size.height * 0.4,
                      child: Card(
                        elevation: 0,
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.network(
                          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1639163872l/58293924.jpg',
                          fit: BoxFit.contain,
                        ),
                        // color: Color(0xFF3EC6FF),
                      ),
                    ),
                    Text(widget.book + "Lorem Ipsum",
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: kColor1)),
                    Text("Dolor Sit Amet",
                        style: TextStyle(
                            fontSize: 15.0,
                            // fontWeight: FontWeight.bold,
                            color: kColor2)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
                width: MediaQuery.of(context).size.width,
                height: 70,
                // color: Colors.blue,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("bookPages"),
                          Text(
                            "212",
                            style: TextStyle(
                                color: Color(0xFF3EC6FF),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("bookGenre"),
                          Text(
                            "Horor",
                            style: TextStyle(
                                color: Color(0xFF3EC6FF),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("bookRating"),
                          Text(
                            "4,9/5",
                            style: TextStyle(
                                color: Color(0xFF3EC6FF),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(24),
                child: Text(
                  "The Bottom Navigation bar has become popular in the last few years for navigation between different UI. Many developers use bottom navigation because most of the app is available now using this widget for navigation between different screens.The bottom navigation bar in Flutter can contain multiple items such as text labels, icons, or both. It allows the user to navigate between the top-level views of an app quickly. If we are using a larger screen, it is better to use a side navigation bar.In Flutter application, we usually set the bottom navigation bar in conjunction with the scaffold widget. Scaffold widget provides a Scaffold.bottomNavigationBar argument to set the bottom navigation bar. It is to note that only adding BottomNavigationBar will not display the navigation items. It is required to set the BottomNavigationItems for Items property that accepts a list of BottomNavigationItems widgets.Remember the following key points while adding items to the bottom navigation bar:We can display only a small number of widgets in the bottom navigation that can be 2 to 5.It must have at least two bottom navigation items. Otherwise, we will get an error.It is required to have the icon and title properties, and we need to set relevant widgets for them.",
                  style: TextStyle(
                    fontSize: 15.0,
                    // fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
              )
            ],
          ),
        ),
      ),
    );
  }
}
