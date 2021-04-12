import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabpressed;
  BottomTabs({this.selectedTab, this.tabpressed});
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.7),
                spreadRadius: 1.0,
                blurRadius: 30)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(
            imagePath: "assets/images/tab_home1.png",
            selected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabpressed(0);
            },
          ),
          BottomTabBtn(
            imagePath: "assets/images/tab_search.png",
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabpressed(1);
            },
          ),
          BottomTabBtn(
            imagePath: "assets/images/tab_sell.png",
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabpressed(2);
            },
          ),
          BottomTabBtn(
            imagePath: "assets/images/tab_user.png",
            selected: _selectedTab == 3 ? true : false,
            onPressed: () {
              widget.tabpressed(3);
            },
          )
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function onPressed;
  BottomTabBtn({this.imagePath, this.selected, this.onPressed});
  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(
              color: _selected
                  ? Theme.of(context).accentColor
                  : Colors.transparent,
              width: 3.0),
        )),
        child: Image(
          image: AssetImage(imagePath ?? "assets/images/tab_home.png"),
          width: 26,
          height: 35,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
