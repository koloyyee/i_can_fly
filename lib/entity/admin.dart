
import 'package:floor/floor.dart';

/// Admin Entity class that represents the admin table in the database
/// - id as primary key
/// - email as the email of the admin
/// - password as the password of the admin
/// - createdAt as the date and time the admin was created
/// 
/// usage:
/// 
/// ```dart
/// var newAdmin = Admin (
/// email: 'admin@example.com', 
/// password: 'password', 
/// createdAt: DateTime.now()
/// );
/// ```
@Entity(tableName: "admins")
class Admin{
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String email;
  final String password;
  final DateTime createdAt;

  Admin({this.id, required this.email, required this.password, required this.createdAt});
}