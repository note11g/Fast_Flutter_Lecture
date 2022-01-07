import 'package:day1/ui/day3_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false, home: HomePageTest());
  }
}

class HomePageTest extends StatefulWidget {
  const HomePageTest({Key? key}) : super(key: key);

  @override
  _HomePageTestState createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {
  int nowIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF2F4F6),
        body: SafeArea(
            child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 14, right: 16, bottom: 14),
                child: Row(
                    children: [
                      Image.asset("assets/image/toss_icon.png", height: 82 / 4),
                      Row(children: [
                        Image.asset("assets/image/toss_qr.png", height: 78 / 4),
                        const Padding(padding: EdgeInsets.only(right: 18)),
                        Image.asset("assets/image/toss_chat.png",
                            height: 78 / 4),
                        const Padding(padding: EdgeInsets.only(right: 18)),
                        Image.asset("assets/image/toss_alert.png",
                            height: 75 / 4)
                      ], crossAxisAlignment: CrossAxisAlignment.center)
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween)),
            Padding(
                padding: const EdgeInsets.all(14),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.to(()=>Day3Page());
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("자산",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Icon(Icons.arrow_forward_ios_rounded,
                                        color: Color(0xFFB1B8C0), size: 16)
                                  ],
                                ))),
                        _accountItem(
                            iconName: "toss_icon_kb",
                            accountName: "KB국민은행",
                            accountWon: "20,000"),
                        const Padding(padding: EdgeInsets.only(bottom: 16)),
                        _accountItem(
                            iconName: "toss_icon_wb",
                            accountName: "내맘대로자유적금",
                            accountWon: "0"),
                        const Padding(padding: EdgeInsets.only(bottom: 16)),
                        _accountItem(
                            iconName: "toss_icon_wb",
                            accountName: "까까 사묵어야징~",
                            accountWon: "1,500"),
                        const Padding(padding: EdgeInsets.only(bottom: 16)),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Divider()),
                        const Padding(padding: EdgeInsets.only(bottom: 16)),
                        _accountItem(
                            iconName: "toss_icon_wb",
                            accountName: "위비 포인트",
                            accountWon: "20",
                            isAccount: false),
                        const Padding(padding: EdgeInsets.only(bottom: 16)),
                      ],
                    )))
          ],
        )),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: nowIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "홈"),
            BottomNavigationBarItem(icon: Icon(Icons.money), label: "혜택"),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money), label: "송금"),
            BottomNavigationBarItem(icon: Icon(Icons.assessment), label: "주식"),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "전체"),
          ],
          onTap: (int index) => setState(() => nowIndex = index),
          selectedItemColor: const Color(0xFF353D4A),
          unselectedItemColor: const Color(0xFFD2D6DA),
        ));
  }

  Widget _accountItem(
          {required String iconName,
          required String accountName,
          required String accountWon,
          bool isAccount = true}) =>
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/image/$iconName.png",
                height: 36,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        accountName,
                        style: const TextStyle(
                            fontSize: 12, color: Color(0xFF7A828E)),
                      ),
                      Text("$accountWon 원",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold))
                    ]),
              )),
              isAccount
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Material(
                        color: const Color(0xFFF2F3F4),
                        child: InkWell(
                          onTap: () {
                            print("후후 너희 몰래 송금을 하겠다 근데 지금 은행 점검시간이네;;");
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text("송금",
                                style: TextStyle(
                                    color: Color(0xFF505967),
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ))
                  : Container()
            ],
          ));
}
