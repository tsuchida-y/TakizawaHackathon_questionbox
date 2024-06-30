import 'package:flutter/material.dart';

class NewScreen extends StatefulWidget {
  final String buttonText;
  final String questionText;
  final String category;

  const NewScreen(
      {super.key,
      required this.buttonText,
      required this.questionText,
      required this.category});

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
        title: const Text("回答画面"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  //タイトル！！！
                  Container(
                    alignment: Alignment.center,
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 212, 235, 255),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0), width: 2),
                    ),
                    child: Text(widget.buttonText,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        )),
                  ),

                  //カテゴリ！！！
                  Container(
                    width: 300,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0), width: 1),
                    ),
                    child: Text("Category: ${widget.category}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),

                  //質問内容
                  Container(
                    width: 300,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 212, 235, 255),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0), width: 1),
                    ),
                    child: Text(widget.questionText,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )),
                  ),

                  ..._responses
                      .map((response) => Container(
                            width: 300,
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

          //入力部分！！！
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
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
