// To parse this JSON data, do
//
//     final rukuModel2 = rukuModel2FromJson(jsonString);

import 'dart:convert';

RukuModel2 rukuModel2FromJson(String str) => RukuModel2.fromJson(json.decode(str));

String rukuModel2ToJson(RukuModel2 data) => json.encode(data.toJson());

class RukuModel2 {
  int code;
  String status;
  Data data;

  RukuModel2({
    required this.code,
    required this.status,
    required this.data,
  });

  factory RukuModel2.fromJson(Map<String, dynamic> json) => RukuModel2(
    code: json["code"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  int number;
  List<Ayah> ayahs;
  Surahs surahs;
  Edition edition;

  Data({
    required this.number,
    required this.ayahs,
    required this.surahs,
    required this.edition,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    number: json["number"],
    ayahs: List<Ayah>.from(json["ayahs"].map((x) => Ayah.fromJson(x))),
    surahs: Surahs.fromJson(json["surahs"]),
    edition: Edition.fromJson(json["edition"]),
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "ayahs": List<dynamic>.from(ayahs.map((x) => x.toJson())),
    "surahs": surahs.toJson(),
    "edition": edition.toJson(),
  };
}

class Ayah {
  int number;
  String text;
  The2 surah;
  int numberInSurah;
  int juz;
  int manzil;
  int page;
  int ruku;
  int hizbQuarter;
  bool sajda;

  Ayah({
    required this.number,
    required this.text,
    required this.surah,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) => Ayah(
    number: json["number"],
    text: json["text"],
    surah: The2.fromJson(json["surah"]),
    numberInSurah: json["numberInSurah"],
    juz: json["juz"],
    manzil: json["manzil"],
    page: json["page"],
    ruku: json["ruku"],
    hizbQuarter: json["hizbQuarter"],
    sajda: json["sajda"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "text": text,
    "surah": surah.toJson(),
    "numberInSurah": numberInSurah,
    "juz": juz,
    "manzil": manzil,
    "page": page,
    "ruku": ruku,
    "hizbQuarter": hizbQuarter,
    "sajda": sajda,
  };
}

class The2 {
  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  String revelationType;
  int numberOfAyahs;

  The2({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.numberOfAyahs,
  });

  factory The2.fromJson(Map<String, dynamic> json) => The2(
    number: json["number"],
    name: json["name"],
    englishName: json["englishName"],
    englishNameTranslation: json["englishNameTranslation"],
    revelationType: json["revelationType"],
    numberOfAyahs: json["numberOfAyahs"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "name": name,
    "englishName": englishName,
    "englishNameTranslation": englishNameTranslation,
    "revelationType": revelationType,
    "numberOfAyahs": numberOfAyahs,
  };
}

class Edition {
  String identifier;
  String language;
  String name;
  String englishName;
  String format;
  String type;
  String direction;

  Edition({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
    required this.direction,
  });

  factory Edition.fromJson(Map<String, dynamic> json) => Edition(
    identifier: json["identifier"],
    language: json["language"],
    name: json["name"],
    englishName: json["englishName"],
    format: json["format"],
    type: json["type"],
    direction: json["direction"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "language": language,
    "name": name,
    "englishName": englishName,
    "format": format,
    "type": type,
    "direction": direction,
  };
}

class Surahs {
  The2 the2;

  Surahs({
    required this.the2,
  });

  factory Surahs.fromJson(Map<String, dynamic> json) => Surahs(
    the2: The2.fromJson(json["2"]),
  );

  Map<String, dynamic> toJson() => {
    "2": the2.toJson(),
  };
}
