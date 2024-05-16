import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_appointment/Screens/home/doctor_home_page.dart';
import 'package:hospital_appointment/Screens/login/doctor_registration.dart';
import 'package:hospital_appointment/widget/inputdecoration.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../componets/loadingindicator.dart';
import '../../constants.dart';
import '../../services/shared_preferences_service.dart';
import '../../widget/Alert_Dialog.dart';
import 'ForgetPassword.dart';

class doctor_page extends StatefulWidget {
  const doctor_page({Key? key}) : super(key: key);

  @override
  _doctor_pageState createState() => _doctor_pageState();
}

class _doctor_pageState extends State<doctor_page> {
  var _isObscure = true;
  var t_email, t_password;
  var user = FirebaseFirestore.instance.collection("doctor").snapshots();
  final PrefService _prefService = PrefService();
  var auth = FirebaseAuth.instance;

  var errorMessage;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  var result;
  var subscription;
  bool status = false;

  getConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
// I am connected to a mobile network.
      status = true;
      print("Mobile Data Connected !");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("Wifi Connected !");
      status = true;
// I am connected to a wifi network.
    } else {
      print("No Internet !");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnectivity();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          status = false;
        });
      } else {
        setState(() {
          status = true;
        });
      }
    });
  }

  Future<bool> getInternetUsingInternetConnectivity() async {
    result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('YAY! Free cute dog pics!');
    } else {
      print('No internet :( Reason:');
    }
    return result;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    t_password.dispose();
    t_email.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmailValid(String email) {
      var pattern =
          r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      return regex.hasMatch(email);
    }

    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: isLoading
              ? Loading()
              : SingleChildScrollView(
                  child: Container(
                    height: size.height * 1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/6.jpg"),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * 0.39,
                          ),
                          Container(
                            child: Center(
                                child: Text(
                              "Đăng Nhập Bác Sĩ",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 2,
                            width: 150,
                            color: kPrimaryLightColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          // ************************************
                          // Email Field
                          //*************************************
                          Container(
                            width: size.width * 0.9,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: kPrimaryColor,
                              decoration: buildInputDecoration(
                                  Icons.email, "Email của bạn "),
                              onChanged: (email) {
                                t_email = email.trim();
                              },
                              validator: (email) {
                                if (isEmailValid(email!))
                                  return null;
                                else
                                  return 'Nhập địa chỉ email hợp lệ';
                              },
                              onSaved: (var email) {
                                t_email = email.toString().trim();
                              },
                            ),
                          ),
                          // ************************************
                          // Password Field
                          //*************************************

                          Container(
                            width: size.width * 0.9,
                            margin: EdgeInsets.all(10),
                            child: TextFormField(
                              obscureText: _isObscure,
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: kPrimaryLightColor,
                                      width: 2,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: kPrimaryColor,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: kPrimaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                        print("on password");
                                      });
                                    },
                                  ),
                                  fillColor: kPrimaryLightColor,
                                  filled: true,
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                        color: kPrimaryColor, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: kPrimaryLightColor,
                                      width: 2,
                                    ),
                                  ),
                                  hintText: "Password"),
                              validator: (var value) {
                                if (value!.isEmpty) {
                                  return "Nhập mật khẩu của bạn";
                                }
                                return null;
                              },
                              onChanged: (password) {
                                t_password = password;
                              },
                              onSaved: (var password) {
                                t_password = password;
                              },
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: size.width * 0.8,
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 5),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder(),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 15),
                                      backgroundColor: kPrimaryColor),
                                  onPressed: () async {
                                    if (status == false) {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) =>
                                              AdvanceCustomAlert());
                                    } else {
                                      if (_formkey.currentState!.validate()) {
                                        if (isLoading) return;
                                        setState(() {
                                          isLoading = true;
                                        });
                                        try {
                                          userCredential1 = await auth
                                              .signInWithEmailAndPassword(
                                                  email: t_email,
                                                  password: t_password);
                                          showLoadingDialog(context: context);
                                        } on FirebaseAuthException catch (error) {
                                          print("FirebaseError: " + error.code);
                                          switch (error.code) {
                                            case "invalid-email":
                                              errorMessage =
                                                  "Địa chỉ email của bạn dường như không đúng định dạng.";
                                              break;
                                            case "wrong-password":
                                              errorMessage =
                                                  "Mật khẩu của bạn sai.";
                                              break;
                                            case "user-not-found":
                                              errorMessage =
                                                  "Bác sĩ với email này không tồn tại.";
                                              break;
                                            case "user-disabled":
                                              errorMessage =
                                                  "Người dùng có email này đã bị vô hiệu hóa.";
                                              break;
                                            case "too-many-requests":
                                              errorMessage =
                                                  "Quá nhiều yêu cầu";
                                              break;
                                            case "operation-not-allowed":
                                              errorMessage =
                                                  "Đăng nhập bằng Email và Mật khẩu không được kích hoạt.";
                                              break;
                                            case "email-already-in-use":
                                              {
                                                errorMessage =
                                                    "Email đã được sử dụng";
                                                break;
                                              }
                                            default:
                                              errorMessage =
                                                  "Đã xảy ra lỗi không xác định.";
                                              break;
                                          }
                                          Fluttertoast.showToast(
                                              msg: errorMessage);
                                          if (errorMessage ==
                                              "Email này không tồn tại.") {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DocRegistration()));
                                          } else {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        doctor_page()));
                                          }

                                          print("error data" + error.code);
                                          setState(() {});
                                        }

                                        if (userCredential1 != null) {
                                          await auth
                                              .signInWithEmailAndPassword(
                                                  email: t_email,
                                                  password: t_password)
                                              .then((value) =>
                                                  _prefService.createCache(1))
                                              .then((uid) => {
                                                    print("Login Successful"),
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Đăng nhập thành công",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            kPrimaryColor,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0),
                                                    Navigator.pushAndRemoveUntil<
                                                            dynamic>(
                                                        context,
                                                        MaterialPageRoute<
                                                                dynamic>(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                DocHomePage()),
                                                        (route) => false),
                                                  })
                                              .catchError((e) {
                                            print(e);
                                          });
                                        }
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Đăng nhập',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),

                              TextButton(
                                onPressed: () {
                                  if (status == false) {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) =>
                                            AdvanceCustomAlert());
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgetPassword()));
                                  }
                                },
                                child: Text(
                                  "Quên mật khẩu ?",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 2,
                                width: 150,
                                color: kPrimaryLightColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // ************************************
                              // add new account
                              //*************************************
                              Container(
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Bạn chưa có tài khoản?",
                                          style: TextStyle(
                                              color: Colors.black26,
                                              fontSize: 14),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (status == false) {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder:
                                                    (BuildContext context) =>
                                                        AdvanceCustomAlert());
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DocRegistration()));
                                          }
                                        },
                                        child: Text(
                                          " Tạo tài khoản mới",
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void sigin(var email, var password) async {
    if (_formkey.currentState!.validate()) {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                print("Đăng nhập thành công"),
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DocHomePage()),
                ),
              })
          .catchError((e) {
        print(e);
      });
    }
  }
}
