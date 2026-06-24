import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool backButton;

  const AppBarWidget({super.key, required this.backButton});

  @override
  Widget build(BuildContext context) {
    return switch (backButton) {
      true => AppBar(
        title: Text('Data App'),
        leading: Icon(Icons.computer),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
          ),
        ],
      ),
      false => AppBar(
        title: Text('Data App'),
        leading: Icon(Icons.computer),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    };
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
