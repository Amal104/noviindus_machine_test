import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noviindus_machine_test/Model/Branch_Model.dart';
import 'package:noviindus_machine_test/Model/Treatment_Model.dart';
import 'package:noviindus_machine_test/Services/Branch_List_Services.dart';
import 'package:noviindus_machine_test/Services/Treatment_List_Services.dart';
import 'package:noviindus_machine_test/Utils/AppColor.dart';
import 'package:noviindus_machine_test/Utils/CustomSnackbar.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../Constants/urls.dart';
import '../Model/TreatmentList_Model.dart';

class RegisterProvider extends ChangeNotifier {
  final nameConroller = TextEditingController();
  final whatsappConroller = TextEditingController();
  final aaddressConroller = TextEditingController();
  final totalamtConroller = TextEditingController();
  final discountamtConroller = TextEditingController();
  final blncamtConroller = TextEditingController();
  final advcamtConroller = TextEditingController();

  List<Branch> branch = [];
  var isLoadingBranch = false;

  List<Treatment> treatment = [];
  var isLoadingTreament = false;

  var locationItems = ['Kochi', 'Kozhikode', 'Bangaluru', 'Chennai', 'Mumbai'];
  String? selectedLocation;
  String? selectedBranch;
  String? selectedTreatment;

  String? selectedDate;

  String? selectedPaymentMethod;

  int? selectedHour;
  int? selectedMinutes;

  int maleCount = 0;
  int femaleCount = 0;

  List<TreatmentList> treatmetntsList = [];
  List<String> male = [];
  List<String> female = [];
  List<String> treatments = [];

  final _dio = Dio();

  onLocationChanged(String? value) {
    selectedLocation = value;
    notifyListeners();
  }

  onPaymentChanged(String? value) {
    if (kDebugMode) {
      print(value);
    }
    selectedPaymentMethod = value;
    notifyListeners();
  }

  onBranchChanged(String? value) {
    selectedBranch = value;
    notifyListeners();
  }

  onTreatmentChanged(String? value) {
    selectedTreatment = value;
    notifyListeners();
  }

  onHourChanged(int? value) {
    selectedHour = value;
    notifyListeners();
  }

  onMinutesChanged(int? value) {
    selectedMinutes = value;
    notifyListeners();
  }

  getBranchData() async {
    isLoadingBranch = true;
    notifyListeners();

    branch = (await BranchListServices().getBranch());

    isLoadingBranch = false;
    notifyListeners();
  }

  getTreatmentData() async {
    isLoadingTreament = true;
    notifyListeners();

    treatment = (await TreatmentListServices().getTreatment());

    isLoadingTreament = false;
    notifyListeners();
  }

  addTreatmentListData() {
    treatmetntsList.add(TreatmentList(
        treatmentName: selectedTreatment!,
        maleCount: maleCount,
        femaleCount: femaleCount));
    notifyListeners();
    male.add(maleCount.toString());
    female.add(maleCount.toString());
    treatments.add(selectedTreatment!);

    maleCount = 0;
    femaleCount = 0;
    notifyListeners();

    if (kDebugMode) {
      print(treatmetntsList);
    }
  }

  removeTreatmentListData() {
    treatmetntsList.remove(TreatmentList(
        treatmentName: selectedTreatment!,
        maleCount: maleCount,
        femaleCount: femaleCount));
    notifyListeners();

    if (kDebugMode) {
      print(treatmetntsList);
    }
  }

  String limitWords(String text, int wordLimit) {
    List<String> words = text.split(' ');
    if (words.length <= wordLimit) {
      return text;
    } else {
      return words.sublist(0, wordLimit).join(' ') + '...';
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      if (kDebugMode) {
        print(picked);
      }
      selectedDate =
          "${picked.day.toString()}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString().padLeft(2, '0')}";
      print(selectedDate);
      notifyListeners();
    }
  }

  final List<int> hours = List<int>.generate(24, (index) => index + 1);
  final List<int> minutes = List<int>.generate(60, (index) => index + 1);

  Future<void> sendPatientData(BuildContext context) async {
    FormData formData = FormData.fromMap({
      "name": nameConroller.text,
      "address": aaddressConroller.text,
      "executive": "test",
      "phone": whatsappConroller.text,
      "payment": selectedPaymentMethod,
      "total_amount": totalamtConroller.text,
      "discount_amount": discountamtConroller.text,
      "advance_amount": advcamtConroller.text,
      "balance_amount": blncamtConroller.text,
      "date_nd_time": "$selectedDate - $selectedHour-$selectedMinutes",
      "id": "",
      "male": male,
      "female": female,
      "branch": "",
      "treatments": treatments
    });

    try {
      Response response = await _dio.post(
        '${AppUrl.baseUrl}PatientUpdate', // Replace with your API endpoint
        data: formData,
      );
      if (response.statusCode == 401) {
        if (kDebugMode) {
          print('Response: ${response.data}');
          print(response.statusCode);
        }
        Customsnackbar.showSnackBar(context, "Success",
            "Patient registerd successfully", AppColor.green);
      } else {
        Customsnackbar.showSnackBar(
            context, "Failed", "Patient registration failed!", Colors.red);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> pdf(BuildContext context) async {
    final pdf = pw.Document();

    final image =
        (await rootBundle.load('assets/logo.jpeg')).buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(pw.MemoryImage(image), width: 50),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(nameConroller.text,
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold)),
                      pw.Text(aaddressConroller.text),
                      pw.Text('e-mail: unknown@gmail.com'),
                      pw.Text('Mob: ${whatsappConroller.text}'),
                      pw.Text('GST No: 32AABCU9603R1ZW'),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Container(
                color: PdfColors.green,
                height: 1,
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Patient Details',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 10),
                      pw.Text('Name: ${nameConroller.text}'),
                      pw.Text('Address: ${aaddressConroller.text}'),
                      pw.Text('WhatsApp Number: ${whatsappConroller.text}'),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Booked On: ${DateTime.now()}'),
                      pw.Text('Treatment Date: ${selectedDate!}'),
                      pw.Text(
                          'Treatment Time: ${selectedHour!} :${selectedMinutes!} am'),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Container(
                color: PdfColors.green,
                height: 1,
              ),
              pw.SizedBox(height: 20),
              pw.Text('Treatment',
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Treatment')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Price')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Male')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Female')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Total')),
                  ]),
                  pw.TableRow(children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Panchakarma')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('230')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('4')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('4')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('2,540')),
                  ]),
                  pw.TableRow(children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Njavara Kizhi Treatment')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('230')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('4')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('4')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('2,540')),
                  ]),
                  pw.TableRow(children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Panchakarma')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('230')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('4')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('4')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('2,540')),
                  ]),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Total Amount: 7,620'),
                      pw.Text('Discount: 500'),
                      pw.Text('Advance: 1,200'),
                      pw.Text('Balance: 5,920'),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text('Thank you for choosing us',
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text(
                  'Your well-being is our commitment, and were honored youve entrusted us with your health journey'),
              pw.SizedBox(height: 20),
              pw.Text('----------------------',
                  style: const pw.TextStyle(fontSize: 16)),
              pw.Text(
                  'Booking amount is non-refundable, and its important to arrive on the allotted time for your treatment'),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/example.pdf');
    await file.writeAsBytes(await pdf.save());
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
    Customsnackbar.showSnackBar(
        context, "PDF Generated", file.path, AppColor.black);
  }
}
