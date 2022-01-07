import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class Day3Controller extends GetxController {
  final TextEditingController textFieldController =
      TextEditingController(text: "");
  final toDoList = [].obs;
  final endToDoList = [].obs;
  final nowLeftTodo = 0.obs;

  late final Box _todoBox;
  late final Box _endTodoBox;
  static const _boxName = "todo";
  static const _endBoxName = "end_todo";
  final uuid = const Uuid();

  addTodo() async {
    if (textFieldController.text.isEmpty) {
      return;
    } else if (toDoList.contains(textFieldController.text) ||
        endToDoList.contains(textFieldController.text)) {
      Get.rawSnackbar(
          message: "이미 등록된 할 일입니다.",
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          margin: const EdgeInsets.all(20),
          borderRadius: 100);
      return;
    }

    toDoList.add(textFieldController.text);
    await _todoBox.put(textFieldController.text, textFieldController.text);

    textFieldController.text = "";

    print(_todoBox.values);
  }

  removeTodo(String todoText, bool isAlive) {
    if (isAlive) {
      toDoList.remove(todoText);
      _todoBox.delete(todoText);
    } else {
      endToDoList.remove(todoText);
      _endTodoBox.delete(todoText);
    }

    Get.rawSnackbar(
        message: "삭제되었습니다.",
        mainButton: TextButton(
            onPressed: () {
              if (isAlive) {
                toDoList.add(todoText);
                _todoBox.put(todoText, todoText);
              } else {
                endToDoList.add(todoText);
                _endTodoBox.put(todoText, todoText);
              }

              Get.back();
            },
            child: const Text("삭제 취소")));
  }

  changeToDoState(String todoText, bool isAlive) {
    if (isAlive) {
      // 다 한 일로 보내야함
      endToDoList.add(todoText);
      toDoList.remove(todoText);

      _endTodoBox.put(todoText, todoText);
      _todoBox.delete(todoText);
    } else {
      // 할 일로 보내야 함
      toDoList.add(todoText);
      endToDoList.remove(todoText);

      _todoBox.put(todoText, todoText);
      _endTodoBox.delete(todoText);
    }
  }

  @override
  void onInit() async {
    ever(toDoList, (List list) {
      // nowLeftTodo.value = list.length;
      nowLeftTodo(list.length);
      print("현재 남은 할 일 : ${nowLeftTodo.value}개");
    });

    _todoBox = await Hive.openBox(_boxName);
    _endTodoBox = await Hive.openBox(_endBoxName);

    toDoList.addAll(_todoBox.values);
    endToDoList.addAll(_endTodoBox.values);

    super.onInit();
  }
}
