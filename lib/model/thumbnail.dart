import 'dart:convert';

class Thumbnail {
  final String small;
  final String large;

  Thumbnail({this.small, this.large});

  Map<String, dynamic> toMap() {
    return {
      'small': small,
      'large': large,
    };
  }

  factory Thumbnail.fromMap(Map<String, dynamic> map) {
    return Thumbnail(
      small: map['small'],
      large: map['large'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Thumbnail.fromJson(String source) =>
      Thumbnail.fromMap(json.decode(source));
}
