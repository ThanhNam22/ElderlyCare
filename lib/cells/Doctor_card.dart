import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class SelectCard extends StatefulWidget {
  final String name;
  final String email;
  final specialist;
  final String profileImage;
  final rating;
  final String did;

  SelectCard({
    required this.name,
    required this.email,
    required this.specialist,
    required this.profileImage,
    required this.rating,
    required this.did,
  });

  @override
  State<SelectCard> createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  var patientCount = 0;

  @override
  void initState() {
    super.initState();
    getPatientCount();
  }

  void getPatientCount() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('pending')
        .where('did', isEqualTo: widget.did)
        .get();
    setState(() {
      patientCount = querySnapshot.docs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // Kiểm tra xem tên của bác sĩ có trong danh sách không hiển thị hay không
    if (!shouldHideDoctor()) {
      return GestureDetector(
        child: Container(
          width: size.width * 1,
          height: 200,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 16,
                child: SizedBox(
                  width: 180,
                  height: 200,
                  child: Image(
                    image: AssetImage('assets/images/bg_shape.png'),
                  ),
                ),
              ),
              Positioned(
                top: 15,
                left: size.width / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bác sĩ.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Chuyên khoa ' + widget.specialist,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      patientCount.toString() + " Bệnh nhân thăm khám",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                        children: new List.generate(
                            5,
                            (index) => buildStar(
                                context,
                                index,
                                double.parse(widget.rating) != 'NaN'
                                    ? double.parse(widget.rating)
                                    : 0.0))),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  width: 77,
                  height: 54,
                  decoration: BoxDecoration(
                    color: kPrimarydark,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(32)),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: kPrimaryLightColor,
                    size: 25,
                  ),
                ),
              ),
              Positioned(
                top: 15,
                left: 20,
                child: Container(
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.white,
                    child: widget.profileImage == false
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                AssetImage('assets/images/account.png'),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(widget.profileImage),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(); // Trả về một SizedBox trống nếu tên của bác sĩ nằm trong danh sách không hiển thị
    }
  }

  // Phương thức kiểm tra xem tên của bác sĩ có trong danh sách không hiển thị hay không
  bool shouldHideDoctor() {
    List<String> blacklistedNames = [
      'Dipak Patel',
      'Kevin Prajapati',
      'Harsh Panchal',
      'Dishang Rana',
      'meet bharucha',
      'Dhvanip Palsanawala',
      'Harshiv Rana',
      'Yash Modi'
    ];
    return blacklistedNames.contains(widget.name);
  }

  Widget buildStar(BuildContext context, int index, double doc) {
    var icon;
    if (index >= doc) {
      icon = Icon(
        Icons.star_border,
        color: Colors.amber,
        size: 30,
      );
    } else if (index > doc - 1 && index < doc) {
      icon = Icon(
        Icons.star_half,
        color: Colors.amber,
        size: 30,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: Colors.amber,
        size: 30,
      );
    }
    return icon;
  }
}
