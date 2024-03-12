import 'dart:io';

import 'package:firstapp/pages/user/user_list.dart';
import 'package:firstapp/pages/smsTemplate/SmsTemplate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: Icon(Platform.isIOS ? CupertinoIcons.person_2_fill : Icons.home_outlined),
            label: 'User',
          ),
          const NavigationDestination(
            icon: Icon(Icons.notifications_sharp),
            label: 'User History',
          ),

          NavigationDestination(
            icon: Icon(Platform.isIOS ? CupertinoIcons.gear_alt_fill : Icons.settings),
            label: 'SmsTemplates',
          ),
          NavigationDestination(
            icon: Icon(Platform.isIOS ? CupertinoIcons.gear_alt_fill : Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: screens[currentPageIndex],
    );
  }

  List<Widget> screens = [
    /// Home page
    const Card(
      shadowColor: Colors.transparent,
      margin: EdgeInsets.all(8.0),
      child: UserList(),
    ),
    ListView.builder(
      reverse: true,
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                // color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'Hello',
                // style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.onPrimary),
              ),
            ),
          );
        }
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              // color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'Hi!',
              // style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.onPrimary),
            ),
          ),
        );
      },
    ),
    const Card(
      shadowColor: Colors.transparent,
      margin: EdgeInsets.all(8.0),
      child: SmsTemplate(),
    ),
    Container(
      width: 200,
      height: 400,
      color: Colors.green,
    )
  ];
}
