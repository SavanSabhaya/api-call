class UserLocation {
  final String city;
  final String state;
  final String country;
  final String postcode;
  final LocationStreet street;
  final LocationCoordinates coordinates;
  final Locationtimezone timezone;

  UserLocation(
      {required this.coordinates,
      required this.street,
      required this.postcode,
      required this.city,
      required this.state,
      required this.country,
      required this.timezone});

  factory UserLocation.fromMap(Map<String, dynamic> json) {
    final street = LocationStreet(
      number: json['street']['number'],
      name: json['street']['name'],
    );
    final coordinates = LocationCoordinates(
        latitude: json['coordinates']['latitude'],
        longitude: json['coordinates']['longitude']);
    final timezone = Locationtimezone(
        description: json['timezone']['description'],
        offset: json['timezone']['offset']);
    return UserLocation(
        country: json['country'],
        postcode: json['postcode'].toString(),
        city: json['city'],
        state: json['state'],
        street: street,
        coordinates: coordinates,
        timezone: timezone);
  }
}

class LocationStreet {
  final int number;
  final String name;
  LocationStreet({required this.number, required this.name});
}

class LocationCoordinates {
  final String latitude;
  final String longitude;
  LocationCoordinates({required this.latitude, required this.longitude});
}

class Locationtimezone {
  final String description;
  final String offset;

  Locationtimezone({required this.description, required this.offset});
}
