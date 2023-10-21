import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orient_news/webview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreeen extends StatefulWidget {
  const OnBoardingScreeen({super.key});

  @override
  State<OnBoardingScreeen> createState() => _OnBoardingScreeenState();
}

class _OnBoardingScreeenState extends State<OnBoardingScreeen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
   controller.dispose();

    super.dispose();
  }
  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
}) => Container(
    color: color,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(urlImage,
        fit: BoxFit.cover,
          width: double.infinity,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.teal.shade700, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            subtitle,
            style: const TextStyle(color: Colors.black),
          ),
        )
      ],
    ),

  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index){
            setState(() {
              isLastPage = index == 1  ;
            });
          },
          children: [
            buildPage(
              color: Colors.green.shade100,
              urlImage: "assets/images.png",
              title: "Syrian news channel",
              subtitle: "Our main offices are diversified in the cities of Dubai-istanbul- Amman, where it offers a range of diverse economic, social and political programs.",
            ),
            buildPage(
              color: Colors.blue.shade100,
              urlImage: "assets/onboarding.jpg",
              title: "Orient TV",
              subtitle: "Orinet TV is concerned with the local Syrian affairs in particular, in addition to keeping pace with Arabs and international events. Its media products include political, social, etc.",
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
        ? TextButton(onPressed: () async{
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("showHome", true);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyWebViewSecreen()),
          );
      },
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
            ),
            primary: Colors.white,
            backgroundColor: Colors.teal.shade700,
            minimumSize: const Size.fromHeight(80),
          ),
        child: const Text("GET STARTED", style: TextStyle(fontSize: 25),
        ),
      )

         :Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: (){
                  controller.nextPage(duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                },
                child: const Text("NEXT"),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 2,
                effect: WormEffect(
                  spacing: 15,
                  dotColor: Colors.black,
                  activeDotColor: Colors.teal.shade700,
                ),
                onDotClicked: (index){
                  controller.animateToPage(
                  index,
                      duration: const Duration(microseconds: 500),
                      curve: Curves.easeIn);
                },
              ),
            ),
            TextButton(
              onPressed: (){
                controller.jumpToPage(1);
              },
                child: const Text("SKIP"),),
          ],
        ),
      ),
    );
  }
}