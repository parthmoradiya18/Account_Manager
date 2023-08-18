import 'package:account_manager/Dashbord.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'Controller Screen/GetXController.dart';

class BalanceDetail extends StatefulWidget {
  var person;

  BalanceDetail(this.person);

  @override
  State<BalanceDetail> createState() => _BalanceDetailState();
}

class _BalanceDetailState extends State<BalanceDetail> {
  MyController _data = Get.put(MyController());
  int id = 0;
  DateTime? todayDate = DateTime.now();
  bool temp = false;

  final TextEditingController _amount = TextEditingController();
  final TextEditingController _particulare = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.person);
    id = widget.person['id'];
    _data.trans_select(id);
    //_data.total_rupe(id);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    TextStyle textStyle1 = const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${widget.person["name"]}"),
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dashbord(),
                    ));
              },
              icon: Icon(Icons.arrow_back)),
          actions: [
            IconButton(
                onPressed: () {
                  add_upTransaction(0, "", "", "", "");
                },
                icon: Icon(Icons.add_circle)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 1, 0, 3),
                  padding: EdgeInsets.all(8),
                  color: Colors.grey.shade300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 10),
                        child: Text("Date",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text("Particular",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text("Credit",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700)),
                      ),
                      Text("Debit",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 7,
              child: Obx(() => ListView.builder(
                    itemCount: _data.trData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var debitlength =
                          (_data.trData[index]['debit'].bitLength >= 20);
                      var creditlength =
                          (_data.trData[index]['credit'].bitLength >= 20);
                      var namelength =
                          (_data.trData[index]['detail'].toString().length >=
                              7);
                      var mycolor = _data.trData[index]['credit'] == 0
                          ? Colors.red
                          : Colors.green.shade500;

                      return InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GFButton(
                                      onPressed: () {
                                        Get.back();
                                        add_upTransaction(
                                            _data.trData[index]['id'],
                                            _data.trData[index]['date'],
                                            _data.trData[index]['detail'],
                                            _data.trData[index]['credit'],
                                            _data.trData[index]['debit']);
                                      },
                                      text: "Edit",
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
                                        Get.back();
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  "Are Want To Delete?"),
                                              actions: [
                                                GFButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  text: "cancel",
                                                  textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.cyan,
                                                      fontSize: 15),
                                                  type: GFButtonType.outline,
                                                  shape: GFButtonShape.pills,
                                                  color: Colors.cyan,
                                                ),
                                                GFButton(
                                                  onPressed: () {
                                                    _data.trans_delete(_data
                                                        .trData[index]['id']);
                                                    Get.back();
                                                  },
                                                  text: "Delete",
                                                  textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  shape: GFButtonShape.pills,
                                                  color: Colors.cyan,
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      text: "Delete",
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.cyan,
                                          fontSize: 15),
                                      type: GFButtonType.outline,
                                      shape: GFButtonShape.pills,
                                      color: Colors.cyan,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                          padding: EdgeInsets.all(5),
                          color: (index % 2 == 0)
                              ? Colors.grey.shade50
                              : Colors.grey.shade200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${_data.trData[index]['date']}",
                                      style: TextStyle(
                                          color: mycolor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                      "${_data.trData[index]['detail']}",
                                      style: TextStyle(
                                          fontSize: namelength ? 13 : 16,
                                          color: mycolor,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 1),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                          "${_data.trData[index]['credit']}",
                                          style: TextStyle(
                                              fontSize: creditlength ? 13 : 16,
                                              color: mycolor,
                                              fontWeight: FontWeight.w500)))),
                              Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                          "${_data.trData[index]['debit']}",
                                          style: TextStyle(
                                              fontSize: debitlength ? 13 : 16,
                                              color: mycolor,
                                              fontWeight: FontWeight.w500)))),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
            Row(
              children: [
                Container(
                  height: height * 0.08,
                  width: width * 0.32,
                  margin: EdgeInsets.fromLTRB(7, 0, 0, 3),
                  color: Colors.blue.shade100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Credit", style: textStyle),
                      Obx(() => Text(
                          (_data.credit.value == "null")
                              ? "₹ 00"
                              : (temp)
                                  ? _data.totalTrans[0]['sum_cre'].toString()
                                  : "₹ ${widget.person['credit']} ",
                          style: TextStyle(fontSize: 20)))
                    ],
                  ),
                ),
                Container(
                  height: height * 0.08,
                  width: width * 0.32,
                  margin: EdgeInsets.only(
                    bottom: 3,
                  ),
                  color: Colors.blue.shade200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Debit", style: textStyle),
                      Obx(() => Text(
                          (_data.debits.value == "null")
                              ? "₹ 00"
                              : (temp)
                                  ? _data.totalTrans[0]['sum_deb'].toString()
                                  : "₹ ${widget.person['debit']} ",
                          style: TextStyle(fontSize: 20)))
                    ],
                  ),
                ),
                Container(
                  height: height * 0.08,
                  width: width * 0.32,
                  margin: const EdgeInsets.fromLTRB(0, 0, 7, 3),
                  color: Colors.blue.shade300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Balance",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      Text(
                        (temp)
                            ? "${_data.totalBalance.value}"
                            : "₹ ${widget.person['balance']} ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ], //${_data.totalBalance.value}
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      onWillPop: () async {
        _data.totalstatement();
        Navigator.pop(context);
        return true;
      },
    );
  }

  add_upTransaction(int tid, String date, name, credit, debit) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        _data.mydate();
        if (date != '') {
          _data.today.value = date;
          _particulare.text = name;
          if (credit > 0) {
            _data.group.value = "Credit";
            _amount.text = "$credit";
          } else {
            _data.group.value = "Debit";
            _amount.text = "$debit";
          }
        }

        return AlertDialog(
          title: Container(
            height: 50,
            width: double.infinity,
            color: Colors.cyan,
            alignment: Alignment.center,
            child:
                Text((date != '') ? "Update Transaction" : "Add Transaction"),
          ),
          content: SizedBox(
            height: 280,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(" Date :"),
                      SizedBox(
                        width: 10,
                      ),
                      Obx(() => Text(_data.today.value,
                          style: TextStyle(color: Colors.black))),
                      IconButton(
                        onPressed: () async {
                          _data.datepickerbox(context);
                        },
                        icon: const Icon(Icons.calendar_month_rounded),
                      ),
                    ],
                  ),
                  Text(
                    "Transcation Type : ",
                    style: TextStyle(fontSize: 12),
                  ),
                  Row(
                    children: [
                      const Text("Credit(+)"),
                      Obx(() => Radio(
                          value: "Credit",
                          groupValue: _data.group.value,
                          onChanged: (value) {
                            _data.rediobtn(value.toString());
                          })),
                      const Text("Debit(-)"),
                      Obx(() => Radio(
                          value: "Debit",
                          groupValue: _data.group.value,
                          onChanged: (value) {
                            _data.rediobtn(value.toString());
                          }))
                    ],
                  ),
                  TextField(
                    controller: _amount,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(label: Text("Amount")),
                  ),
                  TextField(
                    controller: _particulare,
                    decoration:
                        const InputDecoration(label: Text("Particular")),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GFButton(
                        onPressed: () {
                          _data.group.value = "";
                          _particulare.clear();
                          _amount.clear();
                          _data.mydate();
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
                          temp = true;
                          String credit = "0",
                              debit = "0",
                              detail = _particulare.text;
                          if (_data.group.value == "Credit") {
                            credit = _amount.text;
                            _amount.clear();
                          } else {
                            debit = _amount.text;
                            _amount.clear();
                          }

                          if (date != '') {
                            _data.trans_update(
                                tid, date, detail, credit, debit);
                            _data.trans_select(id);
                          } else {
                            _data.balanceData(id, detail, credit, debit);
                          }
                          _particulare.clear();
                          _data.group.value = "";
                          Get.back();
                        },
                        text: (date != "") ? "Update" : "ADD",
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
          ),
        );
      },
    );
  }
}
