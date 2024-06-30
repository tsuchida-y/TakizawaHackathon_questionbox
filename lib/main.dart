import 'package:flutter/material.dart';
import 'package:questionbox/answer.dart';
import 'package:questionbox/question.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  late int state;
  late int state2;
  final List<ButtonInfo> _buttonInfos = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    state = widget.value;
    state2 = widget.value2;
    _addButtons(state);
  }

  void _addButtons(int counter) {
    for (int i = 0; i < counter; i++) {
      _addButton(
          "Button ${_buttonInfos.length + 1}", "Question text", "カテゴリなし");
    }
  }

  void _addButton(String buttonText, String questionText, String category) {
    setState(() {
      _buttonInfos.add(ButtonInfo(buttonText, questionText, category));
    });
  }

  void _incrementCounter(Map<String, String> result) {
    setState(() {
      state += 1;
      _addButton(
          result['buttonText']!, result['questionText']!, result['category']!);
    });
  }

  List<Widget> _filteredButtons() {
    List<ButtonInfo> filteredButtons;
    if (_selectedCategory == null || _selectedCategory!.isEmpty) {
      filteredButtons = _buttonInfos;
    } else {
      filteredButtons = _buttonInfos.where((buttonInfo) {
        return buttonInfo.category == _selectedCategory;
      }).toList();
    }

    return filteredButtons.map((buttonInfo) {
      return Column(
        children: [
          const SizedBox(height: 10), // 上部の空白
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewScreen(
                      buttonText: buttonInfo.buttonText,
                      questionText: buttonInfo.questionText,
                      category: buttonInfo.category),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              side: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 1,
              ),
              minimumSize: const Size(400, 50),
            ),
            child: Text(buttonInfo.buttonText),
          ),
          const SizedBox(height: 10), // 下部の空白
        ],
      );
    }).toList();
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
          children: [
            // カテゴリフィルタ用のDropdownButtonを追加
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButton<String>(
                value: _selectedCategory,
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
                    _selectedCategory = value;
                  });
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ..._filteredButtons(), // フィルタリングされたボタンリストを表示
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<Map<String, String>>(
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

class ButtonInfo {
  final String buttonText;
  final String questionText;
  final String category;

  ButtonInfo(this.buttonText, this.questionText, this.category);
}
