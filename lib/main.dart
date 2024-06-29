import 'package:flutter/material.dart';
//import 'package:questionbox/question.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //final int value;
  // _MyQuestionPage({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 104, 183)),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'ホーム',
        value: 0,
        value2: 0,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.title,
      required this.value,
      required this.value2});
  final int value;
  final int value2;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //ここから追加
  late int state;
  late int state2;
  List<Widget> buttons = [];
  @override
  void initState() {
    //初回のみ実行
    super.initState();

    // 受け取ったデータを状態を管理する変数に格納
    state = widget.value;
    state2 = widget.value2;
    _addButtons(state);
  }

  void _addButtons(int counter) {
    for (int i = 0; i < counter; i++) {
      _addButton("Button ${buttons.length + 1}");
    }
  }

  //_MyHomePageState(text1);

  void _addButton(String buttonText) {
    setState(() {
      buttons.add(ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewScreen(buttonText: buttonText),
            ),
          );
        },
        child: Text(buttonText),
      ));
    });
  }

  void _incrementCounter(String buttonText) {
    setState(() {
      state += 1;
      _addButton(buttonText);
    });
  }

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
          ...buttons, // ボタンのリストを展開して表示
          const SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: _addButton,
          //   child: const Text('Add Button'),
          // ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<String>(
            context,
            MaterialPageRoute(
              builder: (context) => const MyQuestionPage(title: '質問入力'),
            ),
          );
          if (result != null) {
            _incrementCounter(result);
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////
class MyQuestionPage extends StatefulWidget {
  const MyQuestionPage({super.key, required this.title});
  final String title;

  @override
  State<MyQuestionPage> createState() => _MyQuestionPageState();
}

class _MyQuestionPageState extends State<MyQuestionPage> {
  String _text1 = '';
  // String _text2 = '';

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
                onChanged: (String value) {
                  //ユーザーが特定の入力フィールドに対して入力を行った際に発火されるコールバック
                  // データが変更したことを知らせる（画面を更新する）
                  setState(() {
                    // データを変更
                    _text1 = value;
                  });
                },
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
                onChanged: (String value2) {
                  //ユーザーが特定の入力フィールドに対して入力を行った際に発火されるコールバック
                  // データが変更したことを知らせる（画面を更新する）
                  setState(() {
                    // データを変更
                    //   _text2 = value2;
                  });
                },
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
                onPressed: () async {
                  // 入力された値を取得
                  Navigator.pop(context, _text1); //text2も追加できるようにする
                  await Future.delayed(const Duration(milliseconds: 10));
                },
                style: IconButton.styleFrom())
          ],
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////
class NewScreen extends StatelessWidget {
  final String buttonText;

  const NewScreen({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(buttonText),
      ),
      body: Center(
        child: Text(buttonText),
      ),
    );
  }
}
