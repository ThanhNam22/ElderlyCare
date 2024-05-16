import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class about extends StatefulWidget {
  @override
  _aboutState createState() => _aboutState();
}

class _aboutState extends State<about> {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'thanhnamd67@gmail.com',
    query: encodeQueryParameters(<String, String>{
      'subject': 'Facing issues in ElderlyCare',
    }),
  );

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
          'Thông tin về chúng tôi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.only(left: 5, right: 5),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey[50],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        ' ElderlyCare',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "\t\t\t\tElderlyCare là ứng dụng dành cho cả hai bên, tức là bên bác sĩ và bên bệnh nhân. Đây là ứng dụng thân thiện với người dùng cho phép bệnh nhân đặt cuộc hẹn với bác sĩ mà họ lựa chọn.\n\n\t\t\t\tTại bác sĩ, bác sĩ có thể dễ dàng xem cuộc hẹn mới nhất của họ và xác nhận lịch trình bận rộn của họ.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        ' Tính năng',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "» Giao diện thân thiện với người dùng để đặt lịch hẹn dễ dàng\n» Cả bác sĩ và bệnh nhân đều có thể Thêm, cập nhật, xóa cuộc hẹn một cách dễ dàng\n» Cả bệnh nhân và bác sĩ đều có thể Tải ảnh lên\n> Bệnh nhân có thể đánh giá bác sĩ theo phương pháp điều trị\n Bệnh nhân có thể nhắn tin trực tiếp cho bác sĩ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "\t\t\t\tNhóm phát triển đã sử dụng công nghệ và công cụ mới nhất để đảm bảo rằng ứng dụng ElderlyCare an toàn, đáng tin cậy và dễ sử dụng. Họ cũng đã kết hợp phản hồi của người dùng vào quá trình phát triển, đảm bảo rằng ứng dụng đáp ứng được nhu cầu của bác sĩ cũng như bệnh nhân.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Đối mặt với vấn đề?",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                textStyle: TextStyle(color: Colors.white)),
                            onPressed: () {
                              launchUrl(emailLaunchUri);
                            },
                            child: Text("GỬI MAIL CHO CHÚNG TÔI"))),
                    SizedBox(
                      height: 5,
                    )
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Center(
                  child: Text(
                "© 2024 Duong Thanh Nam.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              )),
            ),
          ],
        ),
      ),
    );
  }

  static encodeQueryParameters(Map<String, String> map) {
    return map.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
