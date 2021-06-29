import 'package:blogapp/src/views/pages/login/loginpage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  String mobile;
  Home(this.mobile);

  @override
  _HomeState createState() => _HomeState(mobile);
}

class _HomeState extends State<Home> {
  String mobile;
  _HomeState(this.mobile);
  int _selectedIndex = 0;
  var pages = [
    Home(""),
    Home(""),
    //ExamlistPage(),
    Home(""),
    Home(""),
  ];

  logout() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginScreen();
        },
      ),
    );
  }

  Widget logoutButton() {
    return InkWell(
      onTap: () {
        logout();
      },
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Logout',
              style: TextStyle(
                  color: Colors.white, fontSize: 15.0, fontFamily: 'Merienda'),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final snackBar = SnackBar(
    content: Text("Snack Bar"),
    //backgroundColor: Colors.red,
    duration: Duration(seconds: 3),
  );

  @override
  Widget build(BuildContext context) {
    String m = "Hey user, Your number is " + mobile;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: Text("App Name"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _scaffoldKey.currentState.showSnackBar(snackBar);
              },
            )
          ],
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Text(
                "Normal Font Example",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "ProximaNova Font Example",
                style: TextStyle(fontFamily: "ProximaNova", fontSize: 20),
              ),
              Text(
                "ProximaNova Italic style Font Example",
                style: TextStyle(
                    fontFamily: "ProximaNova",
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                "ProximaNova w700 Font Example",
                style: TextStyle(
                    fontFamily: "ProximaNova",
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                m,
                style: TextStyle(
                    fontFamily: "ProximaNova",
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                "Image Example",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  'images/joker.jpg',
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.teal,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.class_),
              title: Text('Components'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pages),
              title: Text('Pages'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.stars),
              title: Text('Achievement'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              title: Text('Contact Us'),
            ),
          ],
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
        floatingActionButton: logoutButton());
  }
}
