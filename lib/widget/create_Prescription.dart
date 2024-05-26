import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PrescriptionInputForm extends StatefulWidget {
  final String doctorId;
  final String patientId;

  PrescriptionInputForm({required this.doctorId, required this.patientId});

  @override
  _PrescriptionInputFormState createState() => _PrescriptionInputFormState();
}

class _PrescriptionInputFormState extends State<PrescriptionInputForm> {
  final TextEditingController conditionIdController = TextEditingController();
  final TextEditingController medicationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void createPrescription({
    required String doctorId,
    required String patientId,
    required String conditionId,
    required String medication,
    required String description,
  }) async {
    try {
      final CollectionReference prescriptionsCollection = FirebaseFirestore
          .instance
          .collection('doctor/$doctorId/prescriptions');

      await prescriptionsCollection.add({
        'patientId': patientId,
        'conditionId': conditionId,
        'medication': medication,
        'description': description,
        'dateIssued': DateTime.now().toIso8601String(),
      });

      print('Prescription added successfully: $patientId');
    } catch (error) {
      print('Error adding prescription: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kê Đơn',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: conditionIdController,
              decoration: InputDecoration(labelText: 'Tên thuốc'),
            ),
            TextField(
              controller: medicationController,
              decoration: InputDecoration(labelText: 'Công dụng'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Hướng dẫn sử dùng'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                createPrescription(
                  doctorId: widget.doctorId,
                  patientId: widget.patientId,
                  conditionId: conditionIdController.text,
                  medication: medicationController.text,
                  description: descriptionController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Lưu đơn thuốc'),
            ),
          ],
        ),
      ),
    );
  }
}
