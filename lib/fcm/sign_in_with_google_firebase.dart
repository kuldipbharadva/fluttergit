import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learn_app/utilities/AppTheme.dart';
import 'package:flutter_learn_app/utilities/CommonFunctions.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInWithGoogleFirebase extends StatefulWidget {
  const SignInWithGoogleFirebase({Key key}) : super(key: key);

  @override
  _SignInWithGoogleFirebaseState createState() =>
      _SignInWithGoogleFirebaseState();
}

class _SignInWithGoogleFirebaseState extends State<SignInWithGoogleFirebase> {
  String verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn();

  TextEditingController txtOtpController, txtMobileController;

  @override
  void initState() {
    super.initState();
    txtOtpController = TextEditingController();
    txtMobileController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google&Mobile Login With Firebase"),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                inputFormatters: [LengthLimitingTextInputFormatter(40)],
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.number,
                autocorrect: true,
                controller: txtMobileController,
                cursorColor: AppTheme.lightTheme.cursorColor,
                enableSuggestions: true,
                maxLines: 1,
                // maxLength: 10,
                textDirection: TextDirection.ltr,
                // style: Fonts.regularTextStyle,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: "Mobile No.",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 15.0, 20.0),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                inputFormatters: [LengthLimitingTextInputFormatter(40)],
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.number,
                autocorrect: true,
                controller: txtOtpController,
                cursorColor: AppTheme.lightTheme.cursorColor,
                enableSuggestions: true,
                maxLines: 1,
                // maxLength: 10,
                textDirection: TextDirection.ltr,
                // style: Fonts.regularTextStyle,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: "OTP",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 15.0, 20.0),
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () {
                    _sendCodeToPhoneNumber();
                  },
                  child: Text("SEND OTP")),
              SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () {
                    _signInWithPhoneNumber(
                        txtOtpController.text.trim().toString());
                  },
                  child: Text("Verify OTP")),
              SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () {
                    signInWithGoogle(context);
                  },
                  child: Text("Google SignIn"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendCodeToPhoneNumber() async {
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('Phone number verification failed. Code: ${authException.code}. '
          'Message: ${authException.message}');

      CommonFunctions.showToast(context,
          'Phone number verification failed. ${authException.message}.');
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      // you have to manage navigation to otp screen and enter otp, so redirect to otp screen with mobile number for resend code.
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
      print("time out");
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: "+91" + txtMobileController.text.trim(),
        codeSent: codeSent,
        verificationFailed: verificationFailed,
        verificationCompleted: (AuthCredential authCredential) {
          _auth
              .signInWithCredential(authCredential)
              .then((UserCredential result) {
            print("userCredential :: " + result.credential.asMap().toString());
            CommonFunctions.showToast(
                context, "Verification successfully done!");
            /*Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => YourHomeScreen()));*/
          }).catchError((e) {
            print(e);
          });
        },
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _signInWithPhoneNumber(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    _auth
        .signInWithCredential(credential)
        .then((UserCredential userCredential) {
      if (userCredential.user != null) {
        CommonFunctions.showToast(context, "Otp Verified");
      } else {
        CommonFunctions.showToast(context, "Otp Failed");
      }
    }).catchError((onError) {});
  }

  signInWithGoogle(BuildContext context) {
    setState(() {
      //showLoader = true;
    });

    googleSignIn.signIn().then((googleSignInAccount) {
      googleSignInAccount.authentication
          .then((googleSignInAuthentication) async {
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential authResult =
            await _auth.signInWithCredential(credential).catchError((onError) {
          CommonFunctions.showToast(context, onError.toString());
        });
        User user = authResult.user;
        CommonFunctions.showToast(context, "You are logged in now.");

        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);
        String displayName = user.displayName;
        var splited = displayName.split(" ");
        String firstName = "", lastName = "";
        firstName = splited[0];
        lastName = splited[1];
      });
    });
  }
}
