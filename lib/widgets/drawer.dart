import 'package:appnews/core/app.dart';
import 'package:appnews/widgets/category_listtile.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _header,
          Expanded(
            child: CategoryListTile(),
          ),
          _footer
        ],
      ),
    );
  }

  Widget get _header => DrawerHeader(
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.black87,
          image: DecorationImage(image: NetworkImage(app_icon)),
        ),
        child: UserAccountsDrawerHeader(
          onDetailsPressed: () {
            Navigator.of(context).pushNamed("/");
          },
          accountName: Text(
            "$app_name",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          accountEmail: Text("$app_description"),
          decoration: BoxDecoration(),
        ),
      );

  Widget get _footer {
    return ListTile(
      onTap: () {
        showLicensePage(context: context);
      },
      title: Text("រចនាឡើងដោយ: $developer"),
      subtitle: Text("ជំនាន់ទី: $version"),
      trailing: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          Navigator.of(context).pushNamed("/setting");
        },
      ),
    );
  }
}
