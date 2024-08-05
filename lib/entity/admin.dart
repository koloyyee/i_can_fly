
import 'package:floor/floor.dart';


/// Admin Entity Object
/// This class is used to represent an admin in the database. 
/// The @entity annotation is used to indicate that this class
/// is an Entity Object.
@Entity(tableName: "admins")
class Admin{
  /// The id of the admin.
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String email;
  final String password;
  final DateTime createdAt;

  Admin({this.id, required this.email, required this.password, required this.createdAt});
}