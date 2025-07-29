import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme;
    final drawerBg = theme.scaffoldBackgroundColor;
    final textTheme = theme.textTheme.bodyMedium;

    return Drawer(
      backgroundColor: drawerBg,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: theme.colorScheme.primary),
            child: Center(
              child: Icon(
                Icons.music_note,
                size: 48,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: ListTile(
              leading: Icon(Icons.home, color: iconColor.color),
              title: Text('H O M E', style: TextStyle(color: textTheme?.color)),
              onTap: () {
                context.pop();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: ListTile(
              leading: Icon(Icons.settings, color: iconColor.color),
              title: Text(
                'S E T T I N G',
                style: TextStyle(color: textTheme?.color),
              ),
              onTap: () {
                context.pop();
                GoRouter.of(context).push('/setting');
              },
            ),
          ),
        ],
      ),
    );
  }
}
