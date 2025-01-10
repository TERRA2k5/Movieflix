import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movieflix/UI/HomePage.dart';
import 'package:movieflix/UI/SearchPage.dart';

void main() {
  runApp(const MaterialApp(home: MainContainer()));
}

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {

  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  void navigateToSearch() {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('clicked')),
    // );
    setState(() {
      currentIndex = 1;
    });
    pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index){
          setState(() {
            currentIndex = index;
          });
        },
        children: [
          Homepage(onSearchButtonPressed: navigateToSearch),
          Searchpage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        currentIndex: currentIndex,
        backgroundColor: Colors.black,
        onTap: (index) {
          pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home , color: Colors.white,), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search , color: Colors.white,), label: "Search" , )
        ],
      ),
    );
  }
}
