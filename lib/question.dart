import 'package:flutter/material.dart';

class MyQuestionPage extends StatefulWidget {
  const MyQuestionPage({super.key, required this.title});
  final String title;

  @override
  State<MyQuestionPage> createState() => _MyQuestionPageState();
}

class _MyQuestionPageState extends State<MyQuestionPage> {
  String _text1 = '';
  String _text2 = '';
  String? isSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (String value) {
                  setState(() {
                    _text1 = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "テーマを入力してください！",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Container(
              //margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.only(left: 30),
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: DropdownButton(
                underline: Container(),
                hint: const Text('カテゴリを選択'),
                items: const [
                  DropdownMenuItem(
                    value: '勉強',
                    child: Text('勉強'),
                  ),
                  DropdownMenuItem(
                    value: 'キャリア',
                    child: Text('キャリア'),
                  ),
                  DropdownMenuItem(
                    value: 'SNS・メディア',
                    child: Text('SNS・メディア'),
                  ),
                  DropdownMenuItem(
                    value: '趣味',
                    child: Text('趣味'),
                  ),
                  DropdownMenuItem(
                    value: '設備',
                    child: Text('設備'),
                  ),
                  DropdownMenuItem(
                    value: '友達',
                    child: Text('友達'),
                  ),
                  DropdownMenuItem(
                    value: '家庭・生活',
                    child: Text('家庭・生活'),
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    //画面更新
                    isSelectedItem = value;
                  });
                },
                value: isSelectedItem,
              ),
            ),
            Container(
              height: 200,
              width: 400,
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (String value) {
                  setState(() {
                    _text2 = value;
                  });
                },
                maxLines: 10,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(30),
                  labelText: "質問を入力してください！",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.blue),
                onPressed: () {
                  Navigator.pop(
                      context, {'buttonText': _text1, 'questionText': _text2});
                },
                style: IconButton.styleFrom(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
