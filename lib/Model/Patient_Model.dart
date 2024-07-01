// To parse this JSON data, do
//
//     final patientModel = patientModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PatientModel patientModelFromJson(String str) => PatientModel.fromJson(json.decode(str));

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
        patient: List<Patient>.from(json["patient"].map((x) => Patient.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "patient": List<dynamic>.from(patient.map((x) => x.toJson())),
    };
}

class Patient {
    int id;
    List<PatientdetailsSet> patientdetailsSet;
    Branch branch;
    String user;
    String payment;
    String name;
    String phone;
    String address;
    dynamic price;
    int totalAmount;
    int discountAmount;
    int advanceAmount;
    int balanceAmount;
    DateTime dateNdTime;
    bool isActive;
    DateTime createdAt;
    DateTime updatedAt;

    Patient({
        required this.id,
        required this.patientdetailsSet,
        required this.branch,
        required this.user,
        required this.payment,
        required this.name,
        required this.phone,
        required this.address,
        required this.price,
        required this.totalAmount,
        required this.discountAmount,
        required this.advanceAmount,
        required this.balanceAmount,
        required this.dateNdTime,
        required this.isActive,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["id"],
        patientdetailsSet: List<PatientdetailsSet>.from(json["patientdetails_set"].map((x) => PatientdetailsSet.fromJson(x))),
        branch: Branch.fromJson(json["branch"]),
        user: json["user"],
        payment: json["payment"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        price: json["price"],
        totalAmount: json["total_amount"],
        discountAmount: json["discount_amount"],
        advanceAmount: json["advance_amount"],
        balanceAmount: json["balance_amount"],
        dateNdTime: DateTime.parse(json["date_nd_time"]),
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "patientdetails_set": List<dynamic>.from(patientdetailsSet.map((x) => x.toJson())),
        "branch": branch.toJson(),
        "user": user,
        "payment": payment,
        "name": name,
        "phone": phone,
        "address": address,
        "price": price,
        "total_amount": totalAmount,
        "discount_amount": discountAmount,
        "advance_amount": advanceAmount,
        "balance_amount": balanceAmount,
        "date_nd_time": dateNdTime.toIso8601String(),
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Branch {
    int id;
    Name name;
    int patientsCount;
    Location location;
    Phone phone;
    Mail mail;
    Address address;
    String gst;
    bool isActive;

    Branch({
        required this.id,
        required this.name,
        required this.patientsCount,
        required this.location,
        required this.phone,
        required this.mail,
        required this.address,
        required this.gst,
        required this.isActive,
    });

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        patientsCount: json["patients_count"],
        location: locationValues.map[json["location"]]!,
        phone: phoneValues.map[json["phone"]]!,
        mail: mailValues.map[json["mail"]]!,
        address: addressValues.map[json["address"]]!,
        gst: json["gst"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "patients_count": patientsCount,
        "location": locationValues.reverse[location],
        "phone": phoneValues.reverse[phone],
        "mail": mailValues.reverse[mail],
        "address": addressValues.reverse[address],
        "gst": gst,
        "is_active": isActive,
    };
}

enum Address {
    KOCHI_KERALA_685565,
    KOTTAYAM_KERALA_686563,
    KOZHIKODE
}

final addressValues = EnumValues({
    "Kochi, Kerala-685565": Address.KOCHI_KERALA_685565,
    "Kottayam, Kerala-686563": Address.KOTTAYAM_KERALA_686563,
    "Kozhikode": Address.KOZHIKODE
});

enum Location {
    KOCHI,
    KOZHIKODE,
    KUMARAKOM_KOTTAYAM
}

final locationValues = EnumValues({
    "Kochi": Location.KOCHI,
    "Kozhikode": Location.KOZHIKODE,
    "Kumarakom, Kottayam": Location.KUMARAKOM_KOTTAYAM
});

enum Mail {
    USER123_GMAIL_COM
}

final mailValues = EnumValues({
    "user123@gmail.com": Mail.USER123_GMAIL_COM
});

enum Name {
    EDAPPALI,
    KUMARAKOM,
    NADAKKAVU,
    THONDAYADU
}

final nameValues = EnumValues({
    "Edappali": Name.EDAPPALI,
    "KUMARAKOM": Name.KUMARAKOM,
    "Nadakkavu": Name.NADAKKAVU,
    "Thondayadu": Name.THONDAYADU
});

enum Phone {
    PHONE_99463314529747331452,
    THE_9846123456,
    THE_99463314529747331452
}

final phoneValues = EnumValues({
    "9946331452,9747331452": Phone.PHONE_99463314529747331452,
    "9846123456": Phone.THE_9846123456,
    "9946331452, 9747331452": Phone.THE_99463314529747331452
});

class PatientdetailsSet {
    int id;
    String male;
    String female;
    int patient;
    int treatment;
    String treatmentName;

    PatientdetailsSet({
        required this.id,
        required this.male,
        required this.female,
        required this.patient,
        required this.treatment,
        required this.treatmentName,
    });

    factory PatientdetailsSet.fromJson(Map<String, dynamic> json) => PatientdetailsSet(
        id: json["id"],
        male: json["male"],
        female: json["female"],
        patient: json["patient"],
        treatment: json["treatment"],
        treatmentName: json["treatment_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "male": male,
        "female": female,
        "patient": patient,
        "treatment": treatment,
        "treatment_name": treatmentName,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
