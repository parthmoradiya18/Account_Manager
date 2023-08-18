import 'package:account_manager/Controller%20Screen/GetXController.dart';
import 'package:account_manager/First%20Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:hive/hive.dart';
import 'Balance Detail.dart';
import 'main.dart';
import 'First Page.dart';

class Dashbord extends StatefulWidget {
  Dashbord({Key? key}) : super(key: key);

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  final MyController _data = Get.put(MyController());
  final TextEditingController _account = TextEditingController();
  final TextEditingController _oldpass = TextEditingController();
  final TextEditingController _newpass = TextEditingController();
  final TextEditingController _search = TextEditingController();
  final TextEditingController _answer1 = TextEditingController();
  final TextEditingController _answer2 = TextEditingController();

  String? _selected1, _selected2;
  Box box = Hive.box("Account");

  List<String> Question1 = [
    "What was the first mobile that you purchased?",
    "What was the name of your best friend at childhood?",
    "What was the name of your first pet?",
    "What is your favourite children's book?",
    "What was the first film you saw in the cinema?",
    "What was the name of your favourite teacher in school?"
  ];
  List<String> Question2 = [
    "What is the name of your favourite sports team?",
    "Who was your favourite singer or band?",
    " What is your first job?",
    "What was the first dish you learned to cook?",
    "What was the model of your first motorised vehicle?",
    "What was your childhood nickname?"
  ];

  @override
  void initState() {
    super.initState();
    // _data.selectData();
    _data.totalstatement();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashbord"),
        actions: [
          IconButton(
              onPressed: () {
                searchbar();
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      drawer: Drawer(
        width: 270,
        backgroundColor: Colors.green.shade50,
        child: SafeArea(
          child: Column(children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Column(
                  children: [
                    const Icon(size: 80, Icons.account_balance),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Account Manager",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                        ),
                        height: 130,
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Credit",
                                      style: TextStyle(fontSize: 17),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 10, 15, 10),
                                    child: Obx(
                                      () => Text(
                                          (_data.cr.value == "null")
                                              ? "₹00"
                                              : "₹ ${_data.cr.value}",
                                          style: const TextStyle(fontSize: 17)),
                                    ))
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Debit",
                                      style: TextStyle(fontSize: 17),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 10, 15, 10),
                                    child: Obx(() => Text(
                                        (_data.de.value == "null")
                                            ? "₹00"
                                            : "₹ ${_data.de.value}",
                                        style: const TextStyle(fontSize: 17))))
                              ]),
                          Container(
                            height: 1,
                            color: Colors.white,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Balance",
                                    style: TextStyle(fontSize: 17),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 15, 10),
                                  child: Obx(() => Text(
                                      (_data.mainBalance.value == '')
                                          ? "₹00"
                                          : "₹ ${_data.mainBalance.value}",
                                      style: const TextStyle(fontSize: 17)))),
                            ],
                          )
                        ]),
                      ),
                    )
                  ],
                )
              ],
            ),
            ListTile(
              leading: const Icon(Icons.home_filled),
              title: const Text("Home"),
              onTap: () => Get.reload(),
            ),
            ListTile(
                leading: const Icon(Icons.key),
                title: const Text("Change Password"),
                onTap: () {
                  changePass();
                }),
            ListTile(
              leading: const Icon(Icons.question_answer),
              title: const Text("Change security Question"),
              onTap: () => change_question(),
            ),
            ListTile(
              leading: const Icon(Icons.settings_rounded),
              title: const Text("Setting"),
              onTap: () => setting_screen(),
            ),
          ]),
        ),
      ),
      body: (_data.getData.isEmpty)
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 50,
                ),
                Text("No Account Added", style: TextStyle(fontSize: 25)),
                SizedBox(height: 5),
                Text("Click On Add Button to add Account."),
              ],
            ))
          : Obx(() => Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: ListView.builder(
                  itemCount: _data.getData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return BalanceDetail(_data.getData[index]);
                          },
                        ));
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        elevation: 8,
                        child: SizedBox(
                          height: height * 0.173,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 5),
                                      child: Text(
                                        "${_data.getData[index]['name']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      )),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        account_data(_data.getData[index]['id'],
                                            _data.getData[index]['name']);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 20,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  "Are Want To Delete?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child:
                                                        const Text("Cancel")),
                                                TextButton(
                                                    onPressed: () {
                                                      _data.delateData(
                                                          _data.getData[index]
                                                              ['id']);
                                                      Get.back();
                                                    },
                                                    child: const Text("Delete"))
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 20,
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: height * 0.075,
                                    width: width * 0.27,
                                    // margin: EdgeInsets.all(4),
                                    margin:
                                        const EdgeInsets.fromLTRB(9, 7, 5, 7),
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade100,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text("Creadit(➹)",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        Text(
                                          "₹ ${_data.getData[index]['credit']}",
                                          style: const TextStyle(fontSize: 20),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: height * 0.075,
                                    width: width * 0.27,
                                    // margin: EdgeInsets.all(4),
                                    margin:
                                        const EdgeInsets.fromLTRB(7, 7, 5, 7),
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade100,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text("Debit(➷)",
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        Text(
                                          "₹ ${_data.getData[index]['debit']}",
                                          style: const TextStyle(fontSize: 20),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: height * 0.075,
                                    width: width * 0.27,
                                    //  margin: EdgeInsets.all(4),

                                    margin:
                                        const EdgeInsets.fromLTRB(7, 7, 5, 7),
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade300,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text(
                                          "Balance",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "₹ ${_data.getData[index]['balance']}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        tooltip: "Add Account",
        onPressed: () {
          account_data(0, "");
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }

  account_data(int id, String name) {
    showDialog(
      context: context,
      builder: (context) {
        if (id != 0) {
          _account.text = name;
        }
        return AlertDialog(
          title: Container(
            height: 50,
            width: double.infinity,
            color: Colors.cyan,
            alignment: Alignment.center,
            child: Text((id == 0) ? "Add New Account" : "Update Account"),
          ),
          content: SizedBox(
            height: 115,
            child: Column(
              children: [
                TextField(
                  controller: _account,
                  decoration:
                      const InputDecoration(label: Text("Account Name")),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GFButton(
                      onPressed: () {
                        _account.clear();
                        Get.back();
                      },
                      text: "cancel",
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan,
                          fontSize: 15),
                      type: GFButtonType.outline,
                      shape: GFButtonShape.pills,
                      color: Colors.cyan,
                    ),
                    GFButton(
                      onPressed: () {
                        String name = _account.text;
                        if (id == 0) {
                          if (name.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Enter Account Name",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.cyan,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          } else {
                            _data.insertData(name);
                            Get.back();
                          }
                        } else {
                          _data.updateData(name, id);
                          Get.back();
                        }
                        _account.clear();
                        _data.selectData();
                      },
                      text: "Save",
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15),
                      shape: GFButtonShape.pills,
                      color: Colors.cyan,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  changePass() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            width: double.infinity,
            height: 40,
            color: Colors.cyan,
            alignment: Alignment.center,
            child: const Text("Change Password?"),
          ),
          content: Container(
            height: 165,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                    controller: _oldpass,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [LengthLimitingTextInputFormatter(4)],
                    decoration:
                        const InputDecoration(hintText: "Current Password")),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: _newpass,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [LengthLimitingTextInputFormatter(4)],
                    decoration:
                        const InputDecoration(hintText: "New Password")),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GFButton(
                      onPressed: () {
                        Get.back();
                      },
                      text: "cancel",
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan,
                          fontSize: 15),
                      type: GFButtonType.outline,
                      shape: GFButtonShape.pills,
                      color: Colors.cyan,
                    ),
                    GFButton(
                      onPressed: () {
                        if (_oldpass.text.isEmpty || _newpass.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter Password",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.cyan,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        } else {
                          if (_oldpass.text == box.get("password")) {
                            box.put('password', '${_newpass.text}');
                            Fluttertoast.showToast(
                                msg: "Successfully Reset Password",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.cyan,
                                textColor: Colors.black,
                                fontSize: 16.0);
                            _oldpass.clear();
                            _newpass.clear();
                            Get.back();
                          } else {
                            Fluttertoast.showToast(
                                msg: "Incorrect Answer",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.cyan,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          }
                        }
                      },
                      text: "Verify",
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15),
                      shape: GFButtonShape.pills,
                      color: Colors.cyan,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  searchbar() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: SizedBox(
            height: 300,
            child: Column(
              children: [
                Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 5,
                    child: TextField(
                      controller: _search,
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: "Search Account",
                          border: InputBorder.none),
                    )),
                Expanded(
                  child: ListView.builder(
                    itemCount: _data.getData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return BalanceDetail(_data.getData[index]);
                            },
                          ));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "${_data.getData[index]['name']}",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  change_question() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Container(
            width: double.infinity,
            height: 50,
            color: Colors.cyan,
            alignment: Alignment.center,
            child: const Text("Change Security Questions",
                style: TextStyle(fontSize: 16)),
          ),
          contentPadding: EdgeInsets.all(10),
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "➽ Change Security questions for retrieve your password when you forgot.",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  DropdownButton(
                    isExpanded: true,
                    hint: const Text('Security Question 1'),
                    value: _selected1,
                    onChanged: (newValue) {
                      setState(() {
                        _selected1 = newValue;
                      });
                    },
                    items: Question1.map((location) {
                      return DropdownMenuItem(
                        value: location,
                        child: Text(
                          location,
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                  ),
                  TextField(
                      controller: _answer1,
                      decoration: InputDecoration(hintText: "Answer")),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButton(
                    isExpanded: true,
                    hint: const Text('Security Question 2'),
                    value: _selected2,
                    onChanged: (newValue) {
                      setState(() {
                        _selected2 = newValue;
                      });
                    },
                    items: Question2.map((location) {
                      return DropdownMenuItem(
                        value: location,
                        child: Text(
                          location,
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                  ),
                  TextField(
                      controller: _answer2,
                      decoration: InputDecoration(hintText: "Answer")),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GFButton(
                        onPressed: () {
                          Get.back();
                        },
                        text: "cancel",
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan,
                            fontSize: 15),
                        type: GFButtonType.outline,
                        shape: GFButtonShape.pills,
                        color: Colors.cyan,
                      ),
                      GFButton(
                        onPressed: () {
                          if (_selected1 == null || _selected2 == null) {
                            Fluttertoast.showToast(
                                msg: "Enter Security Question",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.cyan,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          } else if (_answer1.text.isEmpty ||
                              _answer2.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Enter Answer",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.cyan,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          } else {
                            String Question1 = _selected1!,
                                Question2 = _selected2!;
                            String answer1 = _answer1.text,
                                answer2 = _answer2.text;
                            print(_answer1.text);
                            print(_answer2.text);
                            print(Question1);
                            print(Question2);
                            box.put("Question1", Question1);
                            box.put("Question2", Question2);
                            box.put("answer1", answer1);
                            box.put("answer2", answer2);
                            Get.back();
                            _answer1.clear();
                            _answer2.clear();
                            // _selected1="";
                            // _selected2="";
                          }
                        },
                        text: "Verify",
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15),
                        shape: GFButtonShape.pills,
                        color: Colors.cyan,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  setting_screen() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            alignment: Alignment.center,
            height: 50,
            width: 300,
            color: Colors.cyan,
            child: const Text("Setting"),
          ),
          content: SizedBox(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.warning),
                const Text(
                  "No Settings Available",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 9,
                ),
                GFButton(
                  onPressed: () {
                    Get.back();
                  },
                  text: "OK",
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan,
                      fontSize: 15),
                  type: GFButtonType.outline,
                  shape: GFButtonShape.pills,
                  color: Colors.cyan,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
