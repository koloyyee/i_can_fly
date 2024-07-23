
import 'package:floor/floor.dart';

@Entity(tableName: "airlines")
class Airline {
   @PrimaryKey(autoGenerate: true)
    final int id;
    final String code;
    final String companyName;

    Airline({required this.id, required this.code, required this.companyName});
}