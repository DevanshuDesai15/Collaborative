import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Tabs/homeTab.dart';
import 'package:flutter_application_1/Tabs/profileTab.dart';
import 'package:flutter_application_1/Tabs/searchTab.dart';
import 'package:flutter_application_1/Tabs/sellTab.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/widgets/bottomTabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[600],
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/appScreen.jpg'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PageView(
                  controller: _tabsPageController,
                  onPageChanged: (num) {
                    setState(() {
                      _selectedTab = num;
                    });
                  },
                  children: [HomeTab(), SearchTab(), SellTab(), ProfileTab()],
                ),
              ),
              BottomTabs(
                selectedTab: _selectedTab,
                tabpressed: (num) {
                  _tabsPageController.animateToPage(num,
                      duration: Duration(microseconds: 300),
                      curve: Curves.easeOutCubic);
                },
              ),
            ],
          ),
        ));
  }
}
