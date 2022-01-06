import 'package:flutter/material.dart';

class Day3Page extends StatefulWidget {
  const Day3Page({Key? key}) : super(key: key);

  @override
  _Day3PageState createState() => _Day3PageState();
}

class _Day3PageState extends State<Day3Page> {
  final TextEditingController _textFieldController =
      TextEditingController(text: "");
  final List<String> _toDoList = [];
  final List<String> _endToDoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("TODO", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _inputSection(),
          const Padding(padding: EdgeInsets.only(bottom: 24)),
          _toDoSection(isAlive: true),
          const Padding(padding: EdgeInsets.only(bottom: 24)),
          _toDoSection(isAlive: false),
        ],
      ),
    );
  }

  Widget _inputSection() => Row(
        children: [
          Expanded(
              child: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "여기에 할 일을 입력하세요"),
            maxLines: 1,
          )),
          IconButton(
              onPressed: () => setState(_addTodo),
              icon: const Icon(Icons.playlist_add))
        ],
      );

  Widget _toDoSection({required bool isAlive}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isAlive ? "할 일" : "다 한 일",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return _toDoItem(
                      isAlive ? _toDoList[index] : _endToDoList[index],
                      isAlive: isAlive);
                },
                itemCount: isAlive ? _toDoList.length : _endToDoList.length),
          )
        ],
      );

  Widget _toDoItem(String todoText, {required bool isAlive}) => Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Text(
            todoText,
            style: const TextStyle(fontSize: 15),
          )),
          InkWell(
              onTap: () => setState(() => _changeToDoState(todoText, isAlive)),
              child: Icon(isAlive ? Icons.done : Icons.arrow_upward, size: 24)),
          const Padding(padding: EdgeInsets.only(left: 6)),
          InkWell(
              onTap: () => setState(() => _removeTodo(todoText, isAlive)),
              child: const Icon(Icons.delete_outline, size: 24)),
        ],
      ));

  _addTodo() {
    if (_textFieldController.text.isEmpty) return;

    _toDoList.add(_textFieldController.text);
    _textFieldController.text = "";
  }

  _removeTodo(String todoText, bool isAlive) {
    if (isAlive) {
      _toDoList.remove(todoText);
    } else {
      _endToDoList.remove(todoText);
    }
  }

  _changeToDoState(String todoText, bool isAlive) {
    if (isAlive) {
      // 다 한 일로 보내야함
      _endToDoList.add(todoText);
      _toDoList.remove(todoText);
    } else {
      // 할 일로 보내야 함
      _toDoList.add(todoText);
      _endToDoList.remove(todoText);
    }
  }
}
