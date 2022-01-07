import 'package:day1/controller/day3_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Day3Page extends StatelessWidget {
  Day3Page({Key? key}) : super(key: key);

  final controller = Get.put(Day3Controller());

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
            controller: controller.textFieldController,
            decoration: const InputDecoration(hintText: "여기에 할 일을 입력하세요"),
            maxLines: 1,
          )),
          IconButton(
              onPressed: controller.addTodo,
              icon: const Icon(Icons.playlist_add))
        ],
      );

  Widget _toDoSection({required bool isAlive}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (isAlive
              ? Obx(()=>Text("할 일 (${controller.nowLeftTodo.value}개 남음)",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)))
              : const Text("다 한 일",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Obx(
                () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return _toDoItem(
                          isAlive
                              ? controller.toDoList[index]
                              : controller.endToDoList[index],
                          isAlive: isAlive);
                    },
                    itemCount: isAlive
                        ? controller.toDoList.length
                        : controller.endToDoList.length),
              ))
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
              onTap: () => controller.changeToDoState(todoText, isAlive),
              child: Icon(isAlive ? Icons.done : Icons.arrow_upward, size: 24)),
          const Padding(padding: EdgeInsets.only(left: 6)),
          InkWell(
              onTap: () => controller.removeTodo(todoText, isAlive),
              child: const Icon(Icons.delete_outline, size: 24)),
        ],
      ));
}
