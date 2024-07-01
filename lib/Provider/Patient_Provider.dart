import 'package:flutter/material.dart';

import '../Model/Patient_Model.dart';
import '../Services/Patient_List_Serrvices.dart';

class PatientProvider extends ChangeNotifier {

  List<PatientModel>? patient = [];
  var isLoading = false;

  getPatientData() async {
    isLoading = true;

     patient = (await PatientService().getPatient());

     isLoading = false;
     notifyListeners();
  }

  Future<void> refresh() async {
    
    await getPatientData();
    
  }

}