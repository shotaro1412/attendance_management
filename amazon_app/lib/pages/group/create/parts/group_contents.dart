import 'dart:io';

import 'package:amazon_app/image/image.dart';
import 'package:amazon_app/pages/group/create/parts/group_member.dart';
import 'package:amazon_app/pages/home/home_page.dart';
import 'package:amazon_app/pages/popup/member_add/member_add_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class GroupContents extends ConsumerStatefulWidget {
  const GroupContents({super.key});
  @override
  ConsumerState<GroupContents> createState() => GroupContentsState();
}

class GroupContentsState extends ConsumerState<GroupContents> {
  File? image;

  ///画像を選択する関数。
  Future<String> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return 'no image';
      }
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
      return 'Success: selected image.';
    } on PlatformException catch (e) {
      debugPrint('Failed: $e');
      return 'Failed';
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFF5F3FE),
      child: Stack(
        children: [
          Positioned(
            top: deviceHeight * 0.12,
            left: deviceWidth * 0.1,
            child: Container(
              //中央トピック
              width: 350,
              height: 210,
              margin: const EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(225, 127, 145, 145),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 20, 60, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //image
                        const Icon(
                          Icons.group,
                          size: 70,
                          color: Colors.grey,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 30,
                          color: Colors.grey,
                        ),
                        CupertinoButton(
                          onPressed: () async {
                            final imageGetResult = await pickImage();
                            if (imageGetResult == 'Failed') {
                              if (!mounted) {
                                return;
                              }
                              await showPhotoAccessDeniedDialog(context);
                            }
                          },
                          child: const SizedBox(
                            child: Icon(
                              Icons.image,
                              size: 70,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 272,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 253, 194),
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                          color: Color.fromARGB(225, 127, 145, 145),
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 13),
                      child: CupertinoTextField(
                        prefix: Icon(Icons.add),
                        style: TextStyle(fontSize: 18),
                        placeholder: '団体名',
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: deviceHeight * 0.38,
            left: deviceWidth * 0.1,
            child: Container(
              //下トピック
              width: 350,
              height: 400,
              margin: const EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(225, 147, 145, 145),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 30,
                      bottom: 10,
                    ),
                    child: const Text(
                      'メンバー',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Center(
                      child: SizedBox(
                        height: 344,
                        width: 330,
                        child: GridView.count(
                          crossAxisSpacing: 26,
                          mainAxisSpacing: 14,
                          childAspectRatio: 2.5,
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10),
                          children: const <Widget>[
                            //後でデータベースと繋げます
                            GroupMember(),
                            GroupMember(),
                            GroupMember(),
                            GroupMember(),
                            GroupMember(),
                            GroupMember(),
                            GroupMember(),
                            GroupMember(),
                            GroupMember(),
                            GroupMember(),
                            GroupMember(),
                            GroupMember(),
                            GroupMember(),
                            GroupMember(),
                            GroupMember(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: deviceHeight * 0.86,
            left: deviceWidth * 0.26,
            child: Container(
              margin: const EdgeInsets.only(top: 25),
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                color: const Color.fromARGB(255, 107, 88, 252),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(225, 127, 145, 145),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      '団体を作成',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: deviceHeight * 0.45,
            left: deviceWidth * 0.84,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  const CircleBorder(),
                ),
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFFD8EB61)),
              ),
              child: const Icon(
                Icons.person_remove,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                    builder: (context) => const ShowMemberAddPopup(),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: deviceHeight * 0.5,
            left: deviceWidth * 0.84,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  const CircleBorder(),
                ),
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFFEB6161)),
              ),
              child: const Icon(
                Icons.person_remove,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () async {},
            ),
          ),
        ],
      ),
    );
  }
}
