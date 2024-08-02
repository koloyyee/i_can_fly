import 'package:flutter/material.dart';
import 'package:i_can_fly/db/database.dart';
import 'package:i_can_fly/db/database_manager.dart';

/// Class that handles the FutureBuilder for database initialization.
/// This separates the database initialization from other classes,
/// keeping them clean and focused on their own purposes.
class DatabaseInitializer extends StatelessWidget {
  final Widget Function(AppDatabase database) builder;

  const DatabaseInitializer({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppDatabase>(
      future: $FloorAppDatabase.databaseBuilder('app_database.db').build(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return builder(snapshot.data!);
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}