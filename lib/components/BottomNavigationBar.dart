import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  final ThemeData appTheme;
  final List<Widget> bodies;
  int sel;
  BottomNav({Key? key, required this.appTheme, required this.sel, required this.bodies}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<BottomNavigationBarItem> createItems() {
    List<BottomNavigationBarItem> items = [];
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.home,
          color: widget.appTheme.primaryColor,
        ),
        icon: const Icon(
          Icons.home,
          color: Colors.black,
        ),
        label: "Explore"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.camera_alt_outlined,
          color: widget.appTheme.primaryColor,
        ),
        icon: const Icon(
          Icons.favorite,
          color: Colors.black,
        ),
        label: "Picture"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.local_offer,
          color: widget.appTheme.primaryColor,
        ),
        icon: const Icon(
          Icons.local_offer,
          color: Colors.black,
        ),
        label: "Deals"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.notifications,
          color: widget.appTheme.primaryColor,
        ),
        icon: const Icon(
          Icons.notifications,
          color: Colors.black,
        ),
        label: "Notifications"));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.bodies.elementAt(widget.sel),
        bottomNavigationBar: BottomNavigationBar(
          items: createItems(),
          unselectedItemColor: Colors.black,
          selectedItemColor: widget.appTheme.primaryColor,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: widget.sel,
          elevation: 1.5,
          onTap: (int index) {
            if (index != widget.sel) {
              setState(() {
                widget.sel = index;
              });
            }
          },
        ));
  }
}
