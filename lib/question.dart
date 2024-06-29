import 'package:flutter/material.dart';

class QuestionBox extends StatelessWidget {
  const QuestionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyQuestionPage(title: '質問入力'),
    );
  }
}

class MyQuestionPage extends StatefulWidget {
  const MyQuestionPage({super.key, required this.title});

  final String title;

  @override
  State<MyQuestionPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyQuestionPage> {
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
              height: 100, //高さを設定
              padding: const EdgeInsets.all(10.0), //余白の設定
              child: TextField(
                decoration: InputDecoration(
                  labelText: "テーマ入力してください",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // 枠線の角の丸みを設定
                  ),
                ),
              ),
            ),
            Container(
              height: 200, //高さを設定
              width: 400, // ここで幅を設定
              padding: const EdgeInsets.all(10.0), //余白の設定
              child: TextField(
                maxLines: 10, //10行かけるよ
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(30),
                  labelText: "質問を入力してください",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // 枠線の角の丸みを設定
                  ),
                ),
              ),
            ),
            IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  // ボタンが押された際の動作を記述する
                },
                style: IconButton.styleFrom())
          ],
        ),
      ),
    );
  }
}
