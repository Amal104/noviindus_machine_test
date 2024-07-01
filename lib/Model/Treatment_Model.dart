// To parse this JSON data, do
//
//     final treatmentModel = treatmentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TreatmentModel treatmentModelFromJson(String str) => TreatmentModel.fromJson(json.decode(str));

String treatmentModelToJson(TreatmentModel data) => json.encode(data.toJson());

class TreatmentModel {
    bool status;
    String message;
    List<Treatment> treatments;

    TreatmentModel({
        required this.status,
        required this.message,
        required this.treatments,
    });

    factory TreatmentModel.fromJson(Map<String, dynamic> json) => TreatmentModel(
        status: json["status"],
        message: json["message"],
        treatments: List<Treatment>.from(json["treatments"].map((x) => Treatment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "treatments": List<dynamic>.from(treatments.map((x) => x.toJson())),
    };
}

class Treatment {
    int id;
    // List<Branch> branches;
    String name;
    String duration;
    String price;
    bool isActive;
    DateTime createdAt;
    DateTime updatedAt;

    Treatment({
        required this.id,
        // required this.branches,
        required this.name,
        required this.duration,
        required this.price,
        required this.isActive,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
        id: json["id"],
        // branches: List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
        name: json["name"],
        duration: json["duration"],
        price: json["price"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        // "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
        "name": name,
        "duration": duration,
        "price": price,
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
