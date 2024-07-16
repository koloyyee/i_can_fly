 class FlightDetails { 
  final String flightNumber;
  final String airlineCode;
  final String airplaneInfo; 
  final String arrivalCity;
  final String departureCity;
  final DateTime departureDateTime;
  final DateTime arrivalDateTime;

  FlightDetails(
      {required this.flightNumber,
      required this.airlineCode,
      required this.airplaneInfo,
      required this.arrivalCity,
      required this.departureCity,
      required this.departureDateTime,
      required this.arrivalDateTime});
 }