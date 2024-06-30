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
  List<Widget> buttons = [];

  @override
  void initState() {
    super.initState();
    state = widget.value;
    state2 = widget.value2;
    _addButtons(state);
  }

  void _addButtons(int counter) {
    for (int i = 0; i < counter; i++) {
      _addButton("Button ${buttons.length + 1}", "Question text");
    }
  }

  void _addButton(String buttonText, String questionText) {
    setState(() {
      buttons.add(
        Column(
          children: [
            const SizedBox(height: 10), // 上部の空白
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewScreen(
                        buttonText: buttonText, questionText: questionText),
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
              child: Text(buttonText),
            ),
            const SizedBox(height: 10), // 下部の空白
          ],
        ),
      );
    });
  }

  void _incrementCounter(Map<String, String> result) {
    setState(() {
      state += 1;
      _addButton(result['buttonText']!, result['questionText']!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ...buttons,
            const SizedBox(height: 20),
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
