import 'package:flutter/material.dart';

class NewScreen extends StatefulWidget {
  final String buttonText;
  final String questionText;
  final String category;

  const NewScreen({
    super.key,
    required this.buttonText,
    required this.questionText,
    required this.category,
  });

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  String _text3 = '';
  final List<Map<String, dynamic>> _responses = [];
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

                  // タイトル
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),

                  // カテゴリ
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

                  // 質問内容
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

                  ..._responses.map((response) {
                    return Container(
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
                      child: Column(
                        children: [
                          Text(response['text']),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(Icons.thumb_up,
                                    color: response['liked'] == true
                                        ? Colors.green
                                        : Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    if (response['liked'] == null ||
                                        response['liked'] == false) {
                                      response['likes'] =
                                          (response['likes'] ?? 0) + 1;
                                      response['liked'] = true;
                                      if (response['disliked'] == true) {
                                        response['dislikes'] =
                                            (response['dislikes'] ?? 1) - 1;
                                        response['disliked'] = false;
                                      }
                                    }
                                  });
                                },
                              ),
                              Text('いいね: ${response['likes'] ?? 0}'),
                              IconButton(
                                icon: Icon(Icons.thumb_down,
                                    color: response['disliked'] == true
                                        ? Colors.red
                                        : Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    if (response['disliked'] == null ||
                                        response['disliked'] == false) {
                                      response['dislikes'] =
                                          (response['dislikes'] ?? 0) + 1;
                                      response['disliked'] = true;
                                      if (response['liked'] == true) {
                                        response['likes'] =
                                            (response['likes'] ?? 1) - 1;
                                        response['liked'] = false;
                                      }
                                    }
                                  });
                                },
                              ),
                              Text('ダメ: ${response['dislikes'] ?? 0}'),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          // 入力部分
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
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          _responses.add({
                            'text': _text3,
                            'likes': 0,
                            'dislikes': 0,
                            'liked': false,
                            'disliked': false,
                          });
                          _controller.clear();
                          _text3 = '';
                        });
                      },
                    ),
                  ],
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
