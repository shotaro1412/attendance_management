// ignore_for_file: inference_failure_on_function_invocation

import 'dart:ui';
import 'package:amazon_app/pages/src/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<dynamic> filteringPopupController(BuildContext context) async {
  await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return const GroupFilteringPopup();
      });
}

class GroupFilteringPopup extends ConsumerStatefulWidget {
  const GroupFilteringPopup({super.key});
  @override
  ConsumerState<GroupFilteringPopup> createState() => _FilteringScreenState();
}

class _FilteringScreenState extends ConsumerState<GroupFilteringPopup> {
  @override
  Widget build(BuildContext context) {
    final deviceH = MediaQuery.of(context).size.height;
    final deviceW = MediaQuery.of(context).size.width;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: deviceH * 0.08),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //閉じるボタン
                Container(
                  margin: const EdgeInsets.only(
                    top: 77,
                  ),
                  width: deviceW * 0.81,
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: deviceW * 0.4,
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(88, 42, 231, 1),
                        borderRadius: BorderRadius.circular(25)),
                    child: CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                              right: 67,
                              bottom: 3,
                            ),
                            child: const Text(
                              '閉じる',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 33,
                          ),
                        ],
                      ),
                      onPressed: () async{
                        await Navigator.push(
                            context,
                            CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                                builder: (context) => const HomePage()));
                      },
                    ),
                  ),
                ),
                //出席簿絞り込みの文字
                Container(
                  width: deviceW * 0.81,
                  height: 39,
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 10,
                  ),
                  child: const Text(
                    '出席簿の絞り込み',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 31,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //”すべて”ボタン
                //ここのContainer切り出す
                Container(
                  width: deviceW * 0.81,
                  height: 92,
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: CupertinoButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 30,
                            bottom: 10,
                          ),
                          child: const Icon(
                            Icons.account_circle,
                            color: Color.fromRGBO(80, 49, 238, 1),
                            size: 65,
                          ),
                        ),
                        const Text(
                          'すべて',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      //ここに処理が入るよ！！
                    },
                  ),
                ),
                //仮団体1
                //ここのContainer切り出す
                Container(
                  width: deviceW * 0.81,
                  height: 92,
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: CupertinoButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 30,
                            bottom: 10,
                          ),
                          child: const Icon(
                            Icons.account_circle,
                            color: Color.fromRGBO(80, 49, 238, 1),
                            size: 65,
                          ),
                        ),
                        const Text(
                          '仮団体1',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      //ここに処理が入るよ！！
                    },
                  ),
                ),
                //仮団体2
                //ここのContainer切り出す
                Container(
                  width: deviceW * 0.81,
                  height: 92,
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: CupertinoButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 30,
                            bottom: 10,
                          ),
                          child: const Icon(
                            Icons.account_circle,
                            color: Color.fromRGBO(80, 49, 238, 1),
                            size: 65,
                          ),
                        ),
                        const Text(
                          '仮団体2',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      //ここに処理が入るよ！！
                    },
                  ),
                ),
                //仮団体3
                //ここのContainer切り出す
                Container(
                  width: deviceW * 0.81,
                  height: 92,
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: CupertinoButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 30,
                            bottom: 10,
                          ),
                          child: const Icon(
                            Icons.account_circle,
                            color: Color.fromRGBO(80, 49, 238, 1),
                            size: 65,
                          ),
                        ),
                        const Text(
                          '仮団体3',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      //ここに処理が入るよ！！
                    },
                  ),
                ),
                //仮団体4
                //ここのContainer切り出す
                Container(
                  width: deviceW * 0.81,
                  height: 92,
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: CupertinoButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 30,
                            bottom: 10,
                          ),
                          child: const Icon(
                            Icons.account_circle,
                            color: Color.fromRGBO(80, 49, 238, 1),
                            size: 65,
                          ),
                        ),
                        const Text(
                          '仮団体4',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      //ここに処理が入るよ！！
                    },
                  ),
                ),
                //仮団体5
                //ここのContainer切り出す
                Container(
                  width: deviceW * 0.81,
                  height: 92,
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: CupertinoButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 30,
                            bottom: 10,
                          ),
                          child: const Icon(
                            Icons.account_circle,
                            color: Color.fromRGBO(80, 49, 238, 1),
                            size: 65,
                          ),
                        ),
                        const Text(
                          '仮団体5',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      //ここに処理が入るよ！！
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
