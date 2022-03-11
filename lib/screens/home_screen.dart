import 'package:chat_app/helper.dart';
import 'package:chat_app/pages/calls_page.dart';
import 'package:chat_app/pages/contacts_page.dart';
import 'package:chat_app/pages/message_page.dart';
import 'package:chat_app/pages/notifications_page.dart';
import 'package:chat_app/widgets/glowing_action_button.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex=ValueNotifier(0);
  final ValueNotifier<String> title=ValueNotifier('Message');

  final pages = const [
    MessagesPage(),
    NotificationPage(),
    CallsPage(),
    ContactsPage(),
  ];

  final pageTitles = const[
    'Messages',
    'Notification',
    'Calls',
    'Contacts',
  ];

  void _onNavigationItemSelected(index){
    title.value = pageTitles[index];
    pageIndex.value= index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _){
            return Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.red,
              )
            );
          },
        ),
        leadingWidth: 64,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: Icons.search,
            onTap: (){
              print('TODO search');
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 44.0),
            child: Avatar.small(url: Helpers.randomPictureUrl()),
        )],
      ),
      
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _){
          return pages[value];
         },
       ),
       bottomNavigationBar: _BottomNavigationBar(
         onItemSelected: _onNavigationItemSelected,
       ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                index: 0,
                lable: 'Messages',
                icon: Icons.message,
               onTap: widget.onItemSelected,
              ),_NavigationBarItem(
                index: 1,
                lable: 'Notification',
                icon: Icons.message,
                onTap: widget.onItemSelected,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: GlowingActionButton(color:Colors.blue, icon: CupertinoIcons.add, onPressed: (){
                  print('todo');
                },
                ),
              ),
              _NavigationBarItem(
                index: 2,
                lable: 'Calls',
                icon: Icons.message,
                onTap: widget.onItemSelected,
              ),_NavigationBarItem(
                index: 3,
                lable: 'Contacts',
                icon: Icons.message,
                onTap: widget.onItemSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    required this.index,
    required this.lable,
    required this.icon,
    required this.onTap,
    }) : super(key: key);

  final int index;
  final String lable;
  final IconData icon;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width:70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            Text(lable),
          ],
        ),
      ),
    );
  }
}