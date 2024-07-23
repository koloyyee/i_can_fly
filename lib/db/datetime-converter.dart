
import 'package:floor/floor.dart';

/// https://pub.dev/documentation/floor/latest/floor/TypeConverter-class.html
class DateTimeConverter extends TypeConverter<DateTime, String > {
  @override
  DateTime decode(String datetime) {
    return DateTime.parse(datetime) ;
  }

  @override
  String encode(DateTime value) {
    return value.toIso8601String();
  }
}