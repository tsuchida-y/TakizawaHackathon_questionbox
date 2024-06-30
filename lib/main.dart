import 'package:flutter/material.dart';

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

class MyQuestionPage extends StatefulWidget {
  const MyQuestionPage({super.key, required this.title});
  final String title;

  @override
  State<MyQuestionPage> createState() => _MyQuestionPageState();
}

class _MyQuestionPageState extends State<MyQuestionPage> {
  String _text1 = '';
  String _text2 = '';

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
                  labelText: "テーマ入力してください",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
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
                  labelText: "質問を入力してください",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blue),
              onPressed: () {
                Navigator.pop(
                    context, {'buttonText': _text1, 'questionText': _text2});
              },
              style: IconButton.styleFrom(),
            ),
          ],
        ),
      ),
    );
  }
}

class NewScreen extends StatefulWidget {
  final String buttonText;
  final String questionText;

  const NewScreen(
      {super.key, required this.buttonText, required this.questionText});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  String _text3 = '';
  final List<String> _responses = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.buttonText),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 400,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0), width: 2),
                    ),
                    child: Text(widget.buttonText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Container(
                    width: 300,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0), width: 1),
                    ),
                    child: Text(widget.questionText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  ..._responses
                      .map((response) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: Text(response),
                          ))
                      .toList(),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _controller,
              onChanged: (String value) {
                setState(() {
                  _text3 = value;
                });
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      _responses.add(_text3);
                      _controller.clear();
                      _text3 = '';
                    });
                  },
                  style: IconButton.styleFrom(),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
