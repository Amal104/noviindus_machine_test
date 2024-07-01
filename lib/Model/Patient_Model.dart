// To parse this JSON data, do
//
//     final patientModel = patientModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PatientModel patientModelFromJson(String str) =>
    PatientModel.fromJson(json.decode(str));

String patientModelToJson(PatientModel data) => json.encode(data.toJson());

class PatientModel {
  bool status;
  String message;
  List<Patient> patient;

  PatientModel({
    required this.status,
    required this.message,
    required this.patient,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        status: json["status"],
        message: json["message"],
        patient:
            List<Patient>.from(json["patient"].map((x) => Patient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "patient": List<dynamic>.from(patient.map((x) => x.toJson())),
      };
}

class Patient {
  int id;
  // List<PatientdetailsSet>? patientdetailsSet;
  // Branch? branch;
  String user;
  String name;
  String phone;
  String address;
  // DateTime? dateNdTime;

  Patient({
    required this.id,
    // required this.patientdetailsSet,
    // required this.branch,
    required this.user,
    required this.name,
    required this.phone,
    required this.address,
    // this.dateNdTime,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["id"] ?? "",
        // patientdetailsSet: json["patientdetails_set"] != null
        //     ? List<PatientdetailsSet>.from(json["patientdetails_set"]
        //         .map((x) => PatientdetailsSet.fromJson(x)))
        //     : null,
        // branch: json["branch"] != null ? Branch.fromJson(json["branch"]) : null,
        user: json["user"] ?? "Not found",
        name: json["name"] ?? "Not found",
        phone: json["phone"] ?? "Not found",
        address: json["address"] ?? "Not found",
        // dateNdTime: json["date_nd_time"] != null
        //     ? DateTime.parse(json["date_nd_time"])
        //     : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "patientdetails_set":
        //     List<dynamic>.from(patientdetailsSet.map((x) => x.toJson())),
        // "branch": branch.toJson(),
        "user": user,
        "name": name,
        "phone": phone,
        "address": address,
        // "date_nd_time": dateNdTime?.toIso8601String(),
      };
}