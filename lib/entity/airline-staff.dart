
import 'package:floor/floor.dart';
import 'package:i_can_fly/entity/airline.dart';
import 'package:i_can_fly/entity/staff.dart';

/// intermediate table for airline and staff
@Entity(tableName: "airline_staff", foreignKeys: [
  ForeignKey(childColumns: ["airline_id"], parentColumns: ["id"], entity: Airline),
  ForeignKey(childColumns: ["staff_id"], parentColumns: ["id"], entity: Staff)
])
class AirlineStaff {
  @ColumnInfo(name: "airline_id")
  final int airlineId;
  @ColumnInfo(name: "staff_id")
  final int staffId;

  AirlineStaff({required this.airlineId, required this.staffId});
 
}