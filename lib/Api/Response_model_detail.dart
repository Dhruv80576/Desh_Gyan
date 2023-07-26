class CountryModel {
  const CountryModel({
    required this.tld,
    required this.car,
    required this.timezone,
    required this.google_map,
    required this.border,
    required this.language,
    required this.postal_code,
    required this.nameCommon,
    required this.nameOfficial,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.area,
    required this.population,
    required this.continents,
    required this.flagPng,
    required this.latlong,
    required this.currency,
    required this.phone_code,
  });

  final Map<String, String> language;
  final String car;
  final String timezone;
  final String tld;
  final String google_map;
  final String border;
  final String postal_code;
  final String nameCommon;
  final String nameOfficial;
  final String capital;
  final String region;
  final String subregion;
  final double area;
  final int population;
  final String continents;
  final String flagPng;
  final String latlong;
  final Map<String, String> currency;
  final String phone_code;

  @override
  List<Object?> get props => [
        nameCommon,
        nameOfficial,
        capital,
        region,
        subregion,
        area,
        population,
        continents,
        flagPng,
        tld,
        car,
        language,
        google_map,
        timezone,
        border,
        postal_code,
        latlong,
        currency,
        phone_code,
      ];

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      nameCommon: json["name"]["common"],
      nameOfficial: json["name"]["official"],
      capital: List<String>.from(
              json["capital"]?.map((cap) => cap) ?? ['No Capital'])
          .toString()
          .replaceAll(']', '')
          .replaceAll('[', ''),
      region: json["region"],
      subregion: json["subregion"] ?? 'No Subregion',
      area: json["area"],
      population: json["population"],
      continents: json["continents"][0],
      flagPng: json["flags"]["png"] ?? "",
      tld: json["tld"].toString().replaceAll('[', '').replaceAll(']', '') ?? "",
      car: json["car"]["side"].toString().toUpperCase() ?? "Right",
      timezone: json["timezones"].toString() ?? "",
      google_map: json["maps"]["googleMaps"] ?? "",
      border: List<String>.from(
              json["borders"]?.map((x) => x) ?? ['No Bordering Countries'])
          .toString()
          .replaceAll('[', ' ')
          .replaceAll(']', ' '),
      language: {"": ""},
      postal_code: '',
      latlong: json["capitalInfo"]["latlng"]
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '') ??
          "",
      currency: {"": ""},
      phone_code: json["idd"]["root"]??"",

    );
  }
}
