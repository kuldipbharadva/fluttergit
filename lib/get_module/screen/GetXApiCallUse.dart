
import 'package:flutter/material.dart';
import 'package:flutter_learn_app/get_module/controller/DemoApiCallController.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class GetXApiCallUse extends StatefulWidget {
  @override
  _GetXApiCallUseState createState() => _GetXApiCallUseState();
}

class _GetXApiCallUseState extends State<GetXApiCallUse> {
  final DemoApiCallController controller = Get.put(DemoApiCallController());
  @override
  void initState() {
    super.initState();
    // controller.getApiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GetX Api"),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                    () => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : Text(controller.apiRes),
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.apiRes = "New Value";
                  },
                  child: Text("Click"))
            ],
          ),
        ),
      ),
    );
  }
}
