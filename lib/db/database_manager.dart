import 'package:i_can_fly/db/database.dart';

///Class that handles the database initialization.
///This class will provide a method to get the AppDatabase instance.
class DatabaseManager {
  static Future<AppDatabase> getDatabase() async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return database;
  }
}
