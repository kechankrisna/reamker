import 'package:appnews/core/app.dart';
import 'package:appnews/models/AppModel.dart';
import 'package:appnews/widgets/drawer.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ការកំនត់ផ្សេងៗ"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Navigator.of(context).pushNamed("/search"))
        ],
      ),
      drawer: DrawerWidget(),
      body: Container(
        child: Column(
          children: [
            ListTile(
              title: Text("កំនត់ប្រភេទពន្លឺ"),
              subtitle: Text("ចុចទីនេះដើម្បីកំនត់ថា ភ្លឺ ឬ ងងឹត"),
              trailing: Icon(Icons.settings_brightness),
              onTap: () {
                AppModel.of(context).toggleThemeMode();
              },
            ),
            ListTile(
              title: Text("អំពីយើងខ្ញុំ"),
              subtitle: Text("ចុចទីនេះដើម្បីអានពត័មានអំពីយើង"),
              trailing: Icon(Icons.info_rounded),
              onTap: () {
                showDialog(
                    context: context,
                    useSafeArea: true,
                    builder: (context) {
                      return AboutDialog(
                        applicationName: app_name,
                        applicationVersion: version,
                        applicationIcon: CircleAvatar(
                          child: Image.asset("assets/images/icon.png"),
                        ),
                        children: [
                          Text(app_content),

                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
