import 'package:flashchat/FlashChat/screens/home_page.dart';
import 'package:flashchat/Tmart/screens/home.dart';
import 'package:flashchat/Tmart/screens/store.dart';
import 'package:flashchat/Tmart/screens/wishlist.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget {
  static const String id = 'navigation_menu';

  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentPageIndex = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black12, width: 1), // Black top border
          ),
        ),
        child: NavigationBar(  //I am using navigation bar not Bottom navigation bar
          backgroundColor: Colors.white,
          indicatorColor: Colors.green[100],
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.message,color: Colors.green,),
              icon: Badge(label: Text('2'), child: Icon(Icons.message_outlined)),
              label: 'Chats',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.home,color: Colors.green,),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.storefront_rounded,color: Colors.green,),
              icon: Badge(child: Icon(Icons.storefront_outlined)),
              label: 'Store',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.favorite,color: Colors.green,),
              icon: Badge(child: Icon(Icons.favorite_border_outlined)),
              label: 'Store',
            ),
          ],
        ),
      ),
      body:
      <Widget>[
        const HomePage(),
        const Home(),
        const Store(),
        const Wishlist(),
      ][currentPageIndex],
    );
  }
}
