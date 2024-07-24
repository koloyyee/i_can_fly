
import 'package:floor/floor.dart';

@Entity(tableName: "staffs")
class Admin{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String email;
  final String password;
  final DateTime createdAt;

  Admin({required this.id, required this.email, required this.password, required this.createdAt});
}