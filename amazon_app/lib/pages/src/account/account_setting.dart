import 'dart:io';
import 'package:amazon_app/controller/entities/device/image_controller.dart';
import 'package:amazon_app/pages/src/account/account_setting_controller.dart';
import 'package:amazon_app/pages/src/account/parts/group/joined_group.dart';
import 'package:amazon_app/pages/src/account/parts/id/id_setting.dart';
import 'package:amazon_app/pages/src/home/parts/group/controller/joined_group_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../home/home_page.dart';
import 'parts/email/email_setting.dart';
import 'parts/password/password_setting.dart';

class AccountSettingPage extends ConsumerStatefulWidget {
  const AccountSettingPage({super.key});
  @override
  ConsumerState<AccountSettingPage> createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends ConsumerState<AccountSettingPage> {
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
    final groupsProfile = ref.watch(readJoinedGroupsProfileProvider);
    final userProfile = ref.watch(userProfileProvider);
    final userProfileNotifier = ref.watch(userProfileProvider.notifier);

    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF5F3FE),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 55,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: CupertinoButton(
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        //init
                        await userProfileNotifier.initUserProfile();
                        userProfileNotifier.nameController.text =
                            userProfile!.name;
                        
                        if (!mounted) {
                          return;
                        }
                        await Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                            builder: (context) => const HomePage(),
                          ),
                          (_) => false,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 45,
                    ),
                    child: Container(
                      width: 178,
                      height: 38,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFD9D9D9),
                            offset: Offset(0, 2),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                        color: const Color(0xFFD8EB61),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.manage_accounts,
                              color: Colors.grey,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 30),
                              child: const Text('ユーザ設定'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //１個目の白い箱
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(top: 10),
                width: 360,
                height: 180,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFD9D9D9),
                      offset: Offset(1, 3),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                  border: Border.all(
                    color: const Color(0xFFD9D9D9),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 60,right: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (userProfile?.image != null)
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: userProfile!.image.startsWith('http')
                                      ? NetworkImage(userProfile.image)
                                      : AssetImage(userProfile.image)
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(999),
                              ),
                            )
                          else
                            const Icon(
                              Icons.face,
                              size: 70,
                              color: Colors.grey,
                            ),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: const Icon(
                              Icons.cached_sharp,
                              size: 40,
                              color: Colors.grey,
                            ),
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
                                userProfileNotifier.changeImage(image!);
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
                    //ユーザーネーム変更
                    Container(
                      width: 256,
                      height: 38,
                      margin: const EdgeInsets.only(
                        top: 5,
                        bottom: 20,
                      ),
                      padding: const EdgeInsets.only(left: 3),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFD9D9D9),
                            offset: Offset(0, 2),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                        color: const Color.fromARGB(255, 231, 238, 189),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: CupertinoTextField(
                        controller: userProfileNotifier.nameController,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 106, 114, 61),
                          backgroundBlendMode: BlendMode.dstIn,
                        ),
                        prefix: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.create_sharp,
                            color: Colors.black,
                          ),
                        ),
                        placeholder: 'username',
                      ),
                    ),
                  ],
                ),
              ),
              //Account ID
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: 350,
                height: 54,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFD9D9D9),
                      offset: Offset(1, 3),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                  color: const Color.fromARGB(255, 231, 238, 189),
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                  border: Border.all(
                    color: const Color(0xFFD9D9D9),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: CupertinoButton(
                    onPressed: () async {
                      await Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                          builder: (context) => const IdSettingPage(),
                        ),
                        (_) => false,
                      );
                    },
                    child: const Row(
                      children: <Widget>[
                        Icon(
                          Icons.info,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Account ID',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 169),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      
              //Email
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: 350,
                height: 54,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFD9D9D9),
                      offset: Offset(1, 3),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                  color: const Color.fromARGB(255, 231, 238, 189),
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                  border: Border.all(
                    color: const Color(0xFFD9D9D9),
                  ),
                ),
                child: CupertinoButton(
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.mail_outline,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'メールアドレス',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 130),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    await Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                        builder: (context) => const EmailSettingPage(),
                      ),
                      (_) => false,
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: 350,
                height: 54,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFD9D9D9),
                      offset: Offset(1, 3),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                  color: const Color.fromARGB(255, 231, 238, 189),
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                  border: Border.all(
                    color: const Color(0xFFD9D9D9),
                  ),
                ),
                child: CupertinoButton(
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.key,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'パスワード',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 162),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    await Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                        builder: (context) => const PasswordSettingPage(),
                      ),
                      (_) => false,
                    );
                  },
                ),
              ),
              //最後の白い箱
              const SizedBox(height: 15),
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
                                    '所属団体',
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Container(
                                width: 354,
                                height: 180,
                                padding: const EdgeInsets.only(
                                  right: 5,
                                  left: 5,
                                  bottom: 5,
                                ),
                                child: GridView.count(
                                  primary: false,
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  childAspectRatio: 3,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  children: groupsProfile.when(
                                    data: (groupProfile) {
                                      if (groupProfile.isEmpty) {
                                        return const [SizedBox.shrink()];
                                      }
                                      return groupProfile.map((groupWithId) {
                                        return JoinedGroupComponent(
                                          groupWithId: groupWithId,
                                        );
                                      }).toList();
                                    },
                                    loading: () => const [SizedBox.shrink()],
                                    error: (error, stack) => [Text('$error')],
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                onPressed: () async {
                  final success = await changeUserProfile(
                    userProfileNotifier.nameController.text,
                    image,
                    null,
                    ref,
                  );
                  if (!success) {
                    return;
                  }
      
                  if (!mounted) {
                    return;
                  }
                  await Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                      builder: (context) => const HomePage(),
                    ),
                    (_) => false,
                  );
                },
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
      ),
    );
  }
}
