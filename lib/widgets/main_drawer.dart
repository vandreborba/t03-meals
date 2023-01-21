import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(Icon icon, String title, VoidCallback tapHandler) {
    return ListTile(
      leading: icon,
      title: Text(title,
          style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.primary,
            child: Text('Cooking Up!',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.white)),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(Icon(Icons.restaurant, size: 26), "Meals", () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile(Icon(Icons.settings, size: 26), "Filters", () {
            Navigator.of(context).pushReplacementNamed(FilterScreen.routName);
          }),
        ],
      ),
    );
  }
}
