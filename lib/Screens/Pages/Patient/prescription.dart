import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_appointment/constants.dart';
import 'package:intl/intl.dart';
import '../../../models/doctor.dart';

class Prescription extends StatefulWidget {
  final String doctorId;
  Prescription({required this.doctorId});

  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  var appointment = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  var todayDate = (DateFormat('dd-MM-yyyy')).format(DateTime.now()).toString();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference firebase =
      FirebaseFirestore.instance.collection("doctor");
  User? user = FirebaseAuth.instance.currentUser;

  bool isLoading = true;
  DoctorModel loggedInUser = DoctorModel();
  DoctorModel doctor = DoctorModel();

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  Future<void> _getDoctor() async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('doctor')
        .doc(widget.doctorId)
        .get();

    if (docSnapshot.exists) {
      setState(() {
        doctor =
            DoctorModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    _getDoctor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: IconButton(
            splashRadius: 20,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Đơn Thuốc',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bác sĩ: ${doctor.name ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Chuyên khoa: ${doctor.specialist ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    if (doctor.specialist == 'Thận') ...[
                      Text(
                        'Tên thuốc: Rowatinex',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Công dụng: Trị sỏi thận, giảm nhanh các triệu chứng khó chịu do bệnh sỏi thận gây ra như tiểu khó, tiểu bí, tiểu rắt, đau nhức lưng bụng,…',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Hướng dẫn: 1 viên mỗi ngày',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Tên thuốc: Bổ thận',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Công dụng: Bổ thận, làm giảm các triệu chứng như đi ngoài nhiều lần, tiểu đêm, tiểu dắt, ...',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Hướng dẫn: 1 viên sau mỗi bữa ăn',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ] else if (doctor.specialist == 'Thần kinh') ...[
                      Text(
                        'Tên thuốc: Thuốc an thần',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Công dụng: Điều trị rối loạn thần kinh',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Hướng dẫn: Thuốc được sử dụng trực tiếp thông qua đường uống, nên dùng vào trước bữa ăn khoảng 30 phút',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ] else if (doctor.specialist == 'Tai') ...[
                      Text(
                        'Tên thuốc: Thuốc mỡ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Công dụng: Giảm các triệu chứng của bệnh chàm tai',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Hướng dẫn: Ngày bôi 2 đến 3 lần',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ] else if (doctor.specialist == 'Sương khớp') ...[
                      Text(
                        'Tên thuốc: Paracetamol',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Công dụng: gồm hạ sốt và giảm đau, phù hợp với những bệnh nhân bị đau nhức xương khớp do chấn thương, lao động gắng sức, hoạt động sai tư thế.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Hướng dẫn:  Uống 1 viên Paracetamol 500mg/ lần mỗi 4 – 6 giờ. Uống thuốc liên tục 5 đến 7 ngày.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ] else ...[
                      Center(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Bác sĩ chưa kê đơn thuốc!',
                                style: TextStyle(
                                  color: Colors.blue[800],
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ),
    );
  }
}
