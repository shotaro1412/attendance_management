import 'dart:io';

import 'package:amazon_app/controller/entities/device/image_controller.dart';
import 'package:amazon_app/pages/src/group/create/parts/contents/group_contents_controller.dart';
import 'package:amazon_app/pages/src/group/setting/group_setting_controller.dart';
import 'package:amazon_app/pages/src/popup/schedule_create/parts/group_picker/riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../home/home_page.dart';
import '../../popup/member_add/member_add.dart';
import '../../popup/schedule_create/schedule_create.dart';
import 'parts/group_member_image.dart';
import 'parts/schedule_card.dart';

enum GroupOption { edit, list }

class GroupSettingPage extends ConsumerStatefulWidget {
  const GroupSettingPage({
    super.key,
    required this.groupId,
  });
  final String groupId;

  @override
  ConsumerState<GroupSettingPage> createState() {
    return GroupSettingPageState();
  }
}

class GroupSettingPageState extends ConsumerState<GroupSettingPage> {
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
    final groupId = widget.groupId;
    final groupAdminMemberProfile = ref.watch(groupAdminMemberProfileProvider);
    final groupProfile = ref.watch(groupSettingProvider(groupId));
    final groupProfileNotifier =
        ref.watch(groupSettingProvider(groupId).notifier);

    return ColoredBox(
      color: const Color.fromARGB(255, 233, 233, 246),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 100,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                        CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6, left: 15),
                      child: Row(
                        children: [
                          const Icon(
                            CupertinoIcons.back,
                            size: 25,
                            color: Colors.black,
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            child: const Text(
                              '戻る',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        '団体編集',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //ここのContainer切り出す
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, 3),
                    blurRadius: 3,
                    spreadRadius: 1,
                  ),
                ],
              ),
              width: 375,
              height: 203,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 20, 60, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (groupProfile?.image != null)
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: groupProfile!.image.startsWith('http')
                                    ? NetworkImage(
                                        groupProfileNotifier.group!.image,
                                      )
                                    : AssetImage(
                                        groupProfileNotifier.group!.image,
                                      ) as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(999),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 1), // 影のオフセット
                                ),
                              ],
                            ),
                          )
                        else
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
                            if (image != null) {
                              await groupProfileNotifier.changeProfile(image!);
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
                      color: const Color(0xFFD8EB61),
                      borderRadius: BorderRadius.circular(80),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 2),
                          blurRadius: 2,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 10,
                      ),
                      child: CupertinoTextField(
                        controller: groupProfileNotifier.groupNameController,
                        prefix: const Icon(
                          Icons.edit_note,
                          color: Color(0xFF6D6D6D),
                          size: 30,
                        ),
                        style: const TextStyle(fontSize: 16),
                        placeholder: '団体名',
                        decoration: const BoxDecoration(
                          color: Color(0xFFD8EB61),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //ここのSizedBox切り出す
            SizedBox(
              height: 95,
              width: 383,
              child: Stack(
                children: [
                  Container(
                    width: 371,
                    height: 77,
                    margin: const EdgeInsets.only(top: 10, left: 6),
                    padding: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          spreadRadius: 3,
                          offset: Offset(0, 3),
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'メンバー',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF9A9A9A),
                            ),
                          ),
                          Row(
                            children: [
                              groupAdminMemberProfile.when(
                                data: (adminUserProfile) {
                                  return GroupMemberImage(
                                    userProfile: adminUserProfile,
                                  );
                                },
                                loading: () => const SizedBox.shrink(),
                                error: (error, stack) => Text('$error'),
                              ),
                              //追加したユーザーを表示しています。
                              ...ref.watch(groupMemberListProvider).map(
                                    (member) => groupProfile != null
                                        ? GroupMemberImage(
                                            userProfile: member,
                                          )
                                        : const Text('No group'),
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -15,
                    right: -15,
                    child: CupertinoButton(
                      onPressed: () async {
                        await showCupertinoModalPopup<AddMember>(
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: AddMember(
                                groupId: groupId,
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD8EB61),
                          borderRadius: BorderRadius.circular(44),
                        ),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.person_add,
                            size: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            //ここのPadding切り出す
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                width: 390,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 3),
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      width: 374,
                      height: 220,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15, top: 15),
                            child: Row(
                              children: [
                                Text(
                                  '予定一覧',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              width: 354,
                              height: 180,
                              padding: const EdgeInsets.only(
                                top: 10,
                                right: 5,
                                left: 5,
                                bottom: 5,
                              ),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                ),
                                itemCount: 20,
                                itemBuilder: (BuildContext context, int index) {
                                  return const ScheduleCard();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 0,
                      child: GestureDetector(
                        onTap: () async {
                          ref.watch(groupNameProvider.notifier).state =
                              groupProfile!.name;
                          await showCupertinoModalPopup<ScheduleCreate>(
                            context: context,
                            builder: (BuildContext context) {
                              return const ScheduleCreate();
                            },
                          );
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD8EB61),
                            borderRadius: BorderRadius.circular(44),
                          ),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.calendar_badge_plus,
                              size: 25,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEB6161),
                            borderRadius: BorderRadius.circular(44),
                          ),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.calendar_badge_minus,
                              size: 25,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              onPressed: () {},
              color: const Color(0xFF7B61FF),
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                width: 117,
                child: Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.download,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text('変更を保存'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
