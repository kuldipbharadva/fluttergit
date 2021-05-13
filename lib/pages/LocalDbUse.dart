import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learn_app/custom_widgets/CardView.dart';
import 'package:flutter_learn_app/local_db/MyDatabase.dart';
import 'package:flutter_learn_app/model/playerList.dart';
import 'package:flutter_learn_app/utilities/AppTheme.dart';
import 'package:flutter_learn_app/utilities/CommonFunctions.dart';
import 'package:flutter_learn_app/utilities/MySharedPreference.dart';

class LocalDbUse extends StatefulWidget {
  @override
  _LocalDbUseState createState() => _LocalDbUseState();
}

class _LocalDbUseState extends State<LocalDbUse> {

  TextEditingController txtNameEditController, txtCityEditController;
  FocusNode nameFocus, cityFocus;

  final myDatabase = MyDatabase.instance;

  int recordId = 1, updateRecordId = 0;
  bool isRecordEdit = false;

  List<PlayerList> dbGetList = [];

  @override
  void initState() {
    super.initState();
    txtNameEditController = new TextEditingController();
    txtCityEditController = new TextEditingController();
    nameFocus = new FocusNode();
    cityFocus = new FocusNode();
    getListFromDB();
    getLastRecordFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Database"),
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
                keyboardType: TextInputType.text,
                autocorrect: true,
                controller: txtNameEditController,
                cursorColor: AppTheme.lightTheme.cursorColor,
                enableSuggestions: true,
                maxLines: 1,
                // maxLength: 10,
                textDirection: TextDirection.ltr,
                // style: Fonts.regularTextStyle,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: "Name",
                  // labelStyle: Fonts.hintTextStyle,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 15.0, 20.0),
                  // border: Borders.borderFull,
                  // focusedBorder: Borders.borderFull,
                  // enabledBorder: Borders.borderFullGrey,
                ),
                focusNode: nameFocus,
                onFieldSubmitted: (term) {
                  CommonFunctions.fieldFocusChange(
                      context, nameFocus, cityFocus);
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                inputFormatters: [LengthLimitingTextInputFormatter(40)],
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                autocorrect: true,
                controller: txtCityEditController,
                cursorColor: AppTheme.lightTheme.cursorColor,
                enableSuggestions: true,
                maxLines: 1,
                // maxLength: 10,
                textDirection: TextDirection.ltr,
                // style: Fonts.regularTextStyle,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: "City",
                  // labelStyle: Fonts.hintTextStyle,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 15.0, 20.0),
                  // border: Borders.borderFull,
                  // focusedBorder: Borders.borderFull,
                  // enabledBorder: Borders.borderFullGrey,
                ),
                focusNode: cityFocus,
                onFieldSubmitted: (term) {
                  cityFocus.unfocus();
                },
              ),
              SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () {
                    if (isRecordEdit) {
                      updateRecordInDB();
                    } else {
                      insertRecord();
                    }
                  },
                  child: Center(child: Text("Submit"))),
              SizedBox(height: 12),
              ListView.builder(
                  itemCount: dbGetList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: CardView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(dbGetList[index].playerName)),
                                  InkWell(
                                    onTap: () {
                                      updateRecordId = int.parse(dbGetList[index].id);
                                      txtNameEditController.text = dbGetList[index].playerName;
                                      txtCityEditController.text = dbGetList[index].playerTeam;
                                      nameFocus.requestFocus();
                                      isRecordEdit = true;
                                    },
                                    child: Icon(Icons.edit),
                                  ),
                                  SizedBox(width: 8),
                                  InkWell(
                                    onTap: () {
                                      deleteRecordFromDB(index, dbGetList[index].playerName);
                                    },
                                    child: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2),
                              Text(dbGetList[index].playerTeam),
                              SizedBox(height: 5),
                              // Divider(height: 1),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  void clearField() {
    txtNameEditController.clear();
    txtCityEditController.clear();
    nameFocus.requestFocus();
  }

  /* this function insert record in given table of database */
  void insertRecord() {
    Map<String, dynamic> row = {
      myDatabase.id: recordId.toString(),
      myDatabase.name: txtNameEditController.text.trim().toString(),
      myDatabase.city: txtCityEditController.text.trim().toString()
    };
    myDatabase.insert(MyDatabase.tableTest, row).then((value) {
      print('inserted row id: $value');
      clearField();
      recordId++;
      getListFromDB();
    });
  }

  /* this function get last record from table, here i have used for manage my custom id, you can use as per your requirement if needed */
  void getLastRecordFromDb() async {
    myDatabase.queryGetLastRecord(MyDatabase.tableTest, "id").then((value) {
      if (value.length > 0) {
        value.forEach((element) async {
          recordId = int.parse(element["id"]);
          recordId++;
        });
      }
    });
  }

  /* this function get list of all records from database */
  void getListFromDB() async {
    dbGetList.clear();
    final dbList = await myDatabase.queryAllRows(MyDatabase.tableTest);
    dbList.forEach((element) async {
      dbGetList.add(new PlayerList(element["id"], element["name"], element["city"]));
      print("record id : " + element["id"]);
    });
    setState(() {});
  }

  /* this function update record in database */
  void updateRecordInDB() {
    Map<String, dynamic> row = {
      myDatabase.id: updateRecordId,
      myDatabase.name: txtNameEditController.text.trim().toString(),
      myDatabase.city: txtCityEditController.text.trim().toString()
    };
    myDatabase.update(MyDatabase.tableTest, row, "id").then((value) {
      print('inserted row id: $value');
      setState(() {
        isRecordEdit = false;
        clearField();
        getListFromDB();
      });
    });
  }

  /* this function delete record from database */
  void deleteRecordFromDB(int index, value) {
    myDatabase.delete(MyDatabase.tableTest, "name", value).then((value) {
      setState(() {
        dbGetList.removeAt(index);
      });
    });
  }

  preferenceUse() async {
    await MySharedPreference.savePreferenceValue("in", 10, PreferenceType.INT);
    await MySharedPreference.savePreferenceValue("dbl", 10.0, PreferenceType.DOUBLE);
    await MySharedPreference.savePreferenceValue("str", "10", PreferenceType.STRING);
    await MySharedPreference.savePreferenceValue("bl", true, PreferenceType.BOOL);
    await MySharedPreference.savePreferenceValue("bol", true, PreferenceType.BOOL);
    int i = await MySharedPreference.readPreferenceValue("in", PreferenceType.INT);
    double d = await MySharedPreference.readPreferenceValue("dbl", PreferenceType.DOUBLE);
    String s = await MySharedPreference.readPreferenceValue("str", PreferenceType.STRING);
    bool b = await MySharedPreference.readPreferenceValue("bl", PreferenceType.BOOL);
    bool bl = await MySharedPreference.readPreferenceValue("bol", PreferenceType.BOOL);
    print("pref val int : $i");
    print("pref val double : $d");
    print("pref val string : $s");
    print("pref val bool : $b");
    print("pref val bool : $bl");
  }
}
