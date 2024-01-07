// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gsheed_crud_backend_demo/gsheet_crud.dart';
import 'package:gsheed_crud_backend_demo/gsheet_setup.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GsheetIntit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final inputText = TextEditingController();
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  Random _rnd = Random();
  String? ID;

  UniqueIdGenerator() async {
    Random random = await new Random();
    int randomNumber = await random.nextInt(1000000); //it gives random number

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    ID = await '${randomNumber}${getRandomString(10)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gsheet demo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextFormField(
                controller: inputText,
                onChanged: (value) {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xffe4e4e4),
                    )),
                    contentPadding: EdgeInsets.only(top: 10, left: 5),
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: Color(0xffb2b2b2),
                    ),
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextButton(
                  onPressed: () async {
                    await UniqueIdGenerator();
                    List<Map<String, dynamic>> userDetailsList = [
                    {
                      'id': '${ID}',
                      'name': '${inputText == null ? '' : inputText.text}'
                    }
                    ];
                    await insertDataIntoSheet(userDetailsList);
                    //  await updateDataFromSheet();
                    // await deleteDataFromSheet();
                    await readDataFromSheet();
                    setState(() {});
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            ListView.builder(
              itemCount: dataFromSheet.length,
              controller: ScrollController(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    dataFromSheet[index]['name'],
                    style: TextStyle(fontSize: 20),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
