import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'Second Page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _que1 = TextEditingController();
  final TextEditingController _que2 = TextEditingController();

  String dropvalue = 'Security Question';
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

  String? _selected1, _selected2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.cyan,
                  child: Icon(
                    Icons.book,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Account Manager",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  elevation: 5,
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white, //Color.fromRGBO(35, 36, 38, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: double.infinity,
                          color: Colors.cyan,
                          child: const Text(
                            "Settings",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.fromLTRB(5, 8, 5, 5),
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4)
                            ],
                            controller: _pass,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                labelText: "Set Password",
                                border: OutlineInputBorder()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Password must be 4 character long",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade500),
                          ),
                        ),
                        Text(
                          "➽ Set Security question for retrieve your password when you forget",
                          style: TextStyle(color: Colors.grey.shade400),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Container(),
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
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          height: 50,
                          child: TextField(
                            controller: _que1,
                            decoration: const InputDecoration(
                                labelText: "Answer",
                                border: OutlineInputBorder()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Container(),
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
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.all(5),
                          child: TextField(
                            controller: _que2,
                            decoration: const InputDecoration(
                                labelText: "Answer",
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(80, 30),
                            backgroundColor: Colors.cyan),
                        onPressed: () {},
                        child: const Text("Exit")),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(80, 30),
                            backgroundColor: Colors.cyan),
                        onPressed: () {
                          if (_pass.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Enter Password")));
                          } else if (_pass.text.length <= 3) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Enter Valid Password")));
                          } else if (_selected1 == null || _selected2 == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Select Both Security Question")));
                          } else if (_que1.text.isEmpty || _que2.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Enter Both Answer")));
                          } else {
                            String Question1, Question2, answer1, answer2;
                            Question1 = _selected1!;
                            Question2 = _selected2!;
                            answer1 = _que1.text;
                            answer2 = _que2.text;

                            box.put('password', _pass.text);
                            box.put("Question1", Question1);
                            box.put("Question2", Question2);
                            box.put("answer1", answer1);
                            box.put("answer2", answer2);

                            print(box.get('password'));

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SecondPage();
                            }));
                          }
                        },
                        child: Text("Set")),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
