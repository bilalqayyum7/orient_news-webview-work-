import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orient_news/onBoarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebViewSecreen extends StatefulWidget {
  const MyWebViewSecreen({super.key});

  @override
  State<MyWebViewSecreen> createState() => _MyWebViewSecreenState();
}

class _MyWebViewSecreenState extends State<MyWebViewSecreen> {

  late int _currentIndex = 0;
  final List<WebView> url = [
    WebView(initialUrl: "https://www.facebook.com/groups/3906591446148448/user/100064470078723/?_rdc=1&_rdr"),
    WebView(initialUrl: "https://www.youtube.com/user/televisionOrient"),
    WebView(initialUrl: "https://orient-news.net/radio/play?fbclid=IwAR0SL-u7nLnano_MHBuESpqjF9Js9iUzMmRAwhJQjl-7ERMw7jQy7_kHa6w"),
    WebView(initialUrl: "https://orient-news.net/en?fbclid=IwAR3jZpl5WnJX5yRzT504_G7HOObtJkVudOd_c_YIuWoSLjslLbNdua4FCHM"),
  ];
 void onItemTap(int index){
   setState(() {
     _currentIndex = index;
   });
 }
  showDialogBox(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.all(10),
            child: Text("Loading.."),
          )
        ],
      ),
    );
    // showDialog(builder: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Orient" , style: TextStyle(),),
          backgroundColor: Colors.deepPurple,
          actions: [
            if (_currentIndex == 0) // Show submit button on the post
              IconButton(onPressed: (){},
                icon: Icon(Icons.notifications), ),
            if  (_currentIndex == 1)
              FloatingActionButton.extended(onPressed: (){},
                  label: Text("Subcribe"),
                  backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(side: BorderSide(width: 10)),
                  icon: Icon(CupertinoIcons.play_rectangle_fill, size: 24,),),
            if (_currentIndex == 2) // Show submit button on the post
              IconButton(onPressed: (){},
                icon: Icon(Icons.notifications), ),
            if (_currentIndex == 3) // Show submit button on the post
              IconButton(onPressed: (){},
                icon: Icon(Icons.notifications), ),
            IconButton(onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool("showHome", false);

              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OnBoardingScreeen()),
              );
            },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: IndexedStack(index: _currentIndex, children: url,),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.deepPurple,
          selectedItemColor: Colors.white70,
          currentIndex: _currentIndex,
          onTap: onItemTap,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.facebook), label: "facebook", backgroundColor: Colors.deepPurple),
            BottomNavigationBarItem(icon: Icon(Icons.smart_display), label: "Youtube", backgroundColor: Colors.deepPurple),
            BottomNavigationBarItem(icon: Icon(Icons.radio), label: "Radio", backgroundColor: Colors.deepPurple),
            BottomNavigationBarItem(icon: Icon(Icons.add_home_work), label: "Home", backgroundColor: Colors.deepPurple),
          ],
        ),
      ),
    );
  }
}

