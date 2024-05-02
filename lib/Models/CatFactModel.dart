// ignore_for_file: file_names

import 'dart:convert';

CatFactModelUi catFactModelUiFromJson(String str) =>
    CatFactModelUi.fromJson(json.decode(str));

String catFactModelUiToJson(CatFactModelUi data) => json.encode(data.toJson());

class CatFactModelUi {
  String fact;
  int length;

  CatFactModelUi({
    required this.fact,
    required this.length,
  });

  factory CatFactModelUi.fromJson(Map<String, dynamic> json) => CatFactModelUi(
        fact: json["fact"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "fact": fact,
        "length": length,
      };
}
