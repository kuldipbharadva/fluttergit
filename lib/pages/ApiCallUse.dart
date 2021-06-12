import 'package:flutter/material.dart';
import 'package:flutter_learn_app/api_call/ApiCall.dart';
import 'package:flutter_learn_app/utilities/AppColor.dart';
import 'package:flutter_learn_app/utilities/CommonFunctions.dart';
import 'package:flutter_learn_app/utilities/DateFunctions.dart';
import 'package:flutter_learn_app/utilities/Validations.dart';

class ApiCallUse extends StatefulWidget {
  @override
  _ApiCallUseState createState() => _ApiCallUseState();
}

class _ApiCallUseState extends State<ApiCallUse> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();

  String apiRes = "";

  @override
  void initState() {
    super.initState();
    getApiCall();
    dateFunctionUsage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ApiCall & Validation"),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  text: "This is use of RichText Widget!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  children: <TextSpan>[
                    TextSpan(
                      text: " ",
                    ),
                    TextSpan(
                      text: "Flutter",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColor.appBlack),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _controllerEmail,
                focusNode: focusNodeEmail,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _controllerPassword,
                focusNode: focusNodePassword,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(onPressed: () {
                if (isValidateFields()) {
                  CommonFunctions.showToast(context, "Field Validate");
                } else {
                  CommonFunctions.showToast(context, "Field Not Validate");
                }
              },
              child: Text("Submit")),
              SizedBox(height: 12),
              Text("Api Res :: $apiRes")
            ],
          ),
        ),
      ),
    );
  }

  // https://reqbin.com/echo/get/json
  /* this function call api using common class */
  getApiCall() async {
    ApiCall.makeApiCall(context, "https://reqbin.com/echo/get/json", MethodType.GET).then((value) {
      if (value != null) {
        setState(() {
          apiRes = value.toString();
          print("api response value :: " + value.toString());
        });
      } else {
        print("api response value null :: ");
      }
    }, onError: (error) {
      print("error ::: " + error.toString());
    }).catchError((onError) {
      print("catchError ::: " + onError.toString());
    });
  }

  /* this function check validation using common validation class functions */
  bool isValidateFields() {
    CommonFunctions.clearFocus(context);
    return Validations.isValidateBlank(context, _controllerEmail,
            focusNodeEmail, "Please enter your email!") &&
        Validations.isValidateBlank(context, _controllerPassword,
            focusNodePassword, "Please enter your password!") &&
        Validations.isValidateLength(context, _controllerPassword,
            focusNodePassword, "Password should be minimum 4 characters!", "Password should be max 16 characters only!", 4, 16);
  }

  void dateFunctionUsage() {
    print("Date change format : " + DateFunctions.getFormattedDate("17 Dec, 1994", "dd MMM, yyyy", "dd-MM-yyyy"));
    print("Get Current Date : " + DateFunctions.getCurrentDate("dd MMM, yyyy"));
    print("Get Millisecond from date : " + DateFunctions.getMillisFromDate("17 Dec, 1994", "dd MMM, yyyy").toString());
    print("Get month name from date : " + DateFunctions.getMonthNameFromDate("17 Dec, 1994", "dd MMM, yyyy", "MMMM"));
    print("Get day name from date : " + DateFunctions.getDayNameFromDate("18 Dec, 1994", "dd MMM, yyyy", "EEEE"));
    print("Get current month full name : " + DateFunctions.getCurrentMonthFullName());
    print("Get current time : " + DateFunctions.getCurrentTime("hh:mm:ss"));
    print("Get current day name : " + DateFunctions.getCurrentDayName("EEEE"));
    print("Get current year name : " + DateFunctions.getCurrentYear());
    print("Get M : " + DateFunctions.getCurrentM());
    print("Get MD : " + DateFunctions.getCurrentMD());
    print("Get MMDD : " + DateFunctions.getCurrentMMDD());
    print("Get MMMD : " + DateFunctions.getCurrentMMMD());
    print("Next specific date : " + DateFunctions.getNextDate("1/5/2021", "dd/MM/yyyy", 3).toString());
    print("Next specific date : " + DateFunctions.getPreviousDate("1/5/2021", "dd/MM/yyyy", 5).toString());
  }
}
