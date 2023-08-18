
import 'package:account_manager/Second%20Page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';


class MyController extends GetxController{
  RxInt selectedindex = 0.obs;
  RxInt index = 0.obs;
  RxInt digit = 0.obs;
  RxString code = ''.obs;
  RxString password=''.obs;
  Box box=Hive.box("Account");


  addDigit(int digit) {
    if (code.value.length > 3) {
      return;
    }
    code.value = code + digit.toString();
    print('Code : ${code.value}');
    selectedindex.value = code.value.length;
  }

  backspace() {
    if (code.value.length == 0) {
      return;
    }
    code.value = code.value.substring(0, code.value.length - 1);
    selectedindex.value = code.value.length;
  }

  get_pass()
  {
    password.value=box.get("password");
    return password;
  }

  RxString selected1=''.obs;
  dropdown(value){
    selected1.value=value;
  }


  //----------------Database----------------------

  RxList<Map> getData=[{}].obs;
  RxList<Map<String, dynamic>> trData = RxList<Map<String, dynamic>>([]);

  insertData(String name) async{
    String insert= "insert into Account values(null,'$name','0','0','0')";
    await SecondPage.database!.rawInsert(insert).then((value) => (value) {
      print("value $value");
    });
    print("inserted");
  }

  selectData() async {
    String select = "select * from Account";
    getData.value = await SecondPage.database!.rawQuery(select);
    //totalstatement();
  }

  updateData(String name,int id) async{
    String update = "update Account set name='$name' where id='$id'";
    await SecondPage.database!.rawUpdate(update);
    selectData();
  }
  delateData(int id) async{
    String delete = "DELETE FROM Account WHERE id=$id";
    await SecondPage.database!.rawDelete(delete);
    selectData();
    totalstatement();
  }

  //------------------------balance Page---------------------

  DateTime? pickDate,todayDate = DateTime.now();
  RxString today=''.obs;

  mydate() {
    today.value="${todayDate!.day}/${todayDate!.month}/${todayDate!.year}";
  }

  datepickerbox(BuildContext context) async {
    today.value="${todayDate!.day}/${todayDate!.month}/${todayDate!.year}";
    pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.utc(1980),
        lastDate: DateTime.now(),
        );

    if(pickDate==null)
      {
        today.value="${todayDate!.day}/${todayDate!.month}/${todayDate!.year}";
      }
    else
      {
        today.value="${pickDate!.day}/${pickDate!.month}/${pickDate!.year}";
      }
    print(today);
  }

  RxString group="".obs;
  rediobtn(String value){
    group.value = value;
  }

  balanceData(id, detail,credit,debit) async {
    String insert = "insert into MyTransaction values(null,'${today.value}','$id','$detail',$credit,$debit)";
    await SecondPage.database!.rawInsert(insert);
    trans_select(id);
  }

  trans_select(int id) async {
    String select = "select * from MyTransaction where AcId='$id' order by id desc";
    trData.value = await SecondPage.database!.rawQuery(select);

    if(trData.isNotEmpty){
      total_rupe(id);
    }
  }

  trans_update(int tid,String date,name,credit,debit) async{
    String dd=date;
    if(today.value!="")
    {
      dd=today.value;
    }
    String update = "update MyTransaction set date='$dd',detail='$name',credit='$credit',debit='$debit' where id='$tid'";
    await SecondPage.database!.rawUpdate(update);
    print(update);
  }

  trans_delete(int id) async{
    String delete = "delete from MyTransaction where id = '$id'";
    await SecondPage.database!.rawDelete(delete);
    trans_select(id);
  }

  RxList<Map<String, dynamic>> totalTrans = RxList<Map<String, dynamic>>([]);
  RxString debits=''.obs;
  RxString credit=''.obs;
  RxString totalBalance=''.obs;

  total_rupe(int id) async {
    totalBalance.value = "";
    String Credit = "SELECT SUM(credit) as sum_cre , SUM(debit) as sum_deb FROM MyTransaction where AcId =$id";
    await SecondPage.database!.rawQuery(Credit).then((value) {
      totalTrans.value = value;
    });
    credit.value = totalTrans[0]['sum_cre'].toString();
    debits.value = totalTrans[0]['sum_deb'].toString();
    totalBalance.value = (int.parse(credit.value) - int.parse(debits.value)).toString();

    String update = "update Account set credit='${credit.value}',debit='${debits.value}', balance='${totalBalance.value}' where id=$id";
    await SecondPage.database!.rawUpdate(update);

    selectData();
  }

  RxList<Map<String, dynamic>> mainTrans = RxList<Map<String, dynamic>>([]);
  RxString mainBalance=''.obs , cr =''.obs, de =''.obs;
  RxInt a1 =0.obs;
  RxInt a2 =0.obs;

  totalstatement() async {
    String main = "SELECT SUM(credit) as mainCredit , SUM(debit) as mainDebit  FROM MyTransaction";
    mainTrans.value = await SecondPage.database!.rawQuery(main);

      cr.value = mainTrans[0]['mainCredit'].toString();
      de.value = mainTrans[0]['mainDebit'].toString();

      if(cr.value=='null')
        {
          cr.value = '0';
          de.value = '0';
        }
      mainBalance.value = (int.parse(cr.value) - int.parse(de.value)).toString();

      print("ttotal : ${mainBalance.value}");
  }

}
