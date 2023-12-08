import 'package:bookabuku/components/beranda.dart';
import 'package:bookabuku/components/cari.dart';
import 'package:bookabuku/components/rak_buku.dart';
import 'package:bookabuku/constant.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  static String id = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User _user;
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColor3,
      body: SafeArea(
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          controller: _pageController,
          children: <Widget>[
            Beranda(user: _user),
            SearchPage(),
            ShelvesPage(),
          ],
        ),
      ),
      floatingActionButton: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Beranda'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.search),
            title: Text('Cari'),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.shelves),
            title: Text('Rak Buku'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

FloatingActionButton buildFloatingActionButton() {
  return FloatingActionButton(
    onPressed: () {
      // handle search action
    },
    child: Icon(Icons.search),
  );
}

Widget buildBottomNavigationBar() {
  return Container(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        useLegacyColorScheme: false,
        currentIndex: 0,
        selectedLabelStyle:
            TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        onTap: (value) {
          print('BottomNavigationBar onTap: $value');
        },
        items: [
          BottomNavigationBarItem(
            icon: Column(children: [
              CircleAvatar(
                radius: 24.0,
                backgroundColor: Colors.grey[200],
                child: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              Text('Beranda')
            ]),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 24.0,
              backgroundColor: Colors.grey[200],
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 24.0,
              backgroundColor: Colors.grey[200],
              child: Icon(
                Icons.shelves,
                color: Colors.black,
              ),
            ),
            label: 'Rak Buku',
          ),
        ],
      ),
    ),
  );
}
