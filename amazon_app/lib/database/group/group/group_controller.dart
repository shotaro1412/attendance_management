import 'package:amazon_app/storage/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'group.dart';

class GroupController {
    ///シングルトンパターンにしています。
  GroupController._internal();
  static final GroupController _instance =
      GroupController._internal();
  static GroupController get instance => _instance;

  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'groups';

  ///Create group database.
  static Future<String> create(
    String name,
    String? image,
    String? description,
  ) async {
    ///Create new document
    final groupDoc = db.collection(collectionPath).doc();
    String? imagePath;
    if (image != null) {
      imagePath =
          await StorageController.uploadGroupImageToStorage(groupDoc.id, image);
    } else {
      imagePath = 'src/images/group_img.jpeg';
    }
    ///Get server time
    final createdAt = FieldValue.serverTimestamp();

    await groupDoc.set({
      'name': name,
      'image': imagePath,
      'description': description,
      'updated_at': null,
      'created_at': createdAt,
    });

    return groupDoc.id;
  }

  ///後で消す。
  ///Read all members.
  static Future<List<GroupProfile>> readAll(String userDocId) async {
    final groups = await db
        .collection(collectionPath)
        .where('user_id', isEqualTo: userDocId)
        .get();
    final groupMembershipsRefs = groups.docs.map((doc) {
      final groupMembershipsRef = doc.data() as Map<String, dynamic>?;
      if (groupMembershipsRef == null) {
        throw Exception('Error : No found document data.');
      }

      return GroupProfile.fromMap(groupMembershipsRef);
    }).toList();

    return groupMembershipsRefs;
  }

  static Future<List<String>> readAllDocId(String userId) async {
    final groups = await db
        .collection(collectionPath)
        .where('user_id', isEqualTo: userId)
        .get();
    final groupMembershipsRefs = groups.docs.map((doc) {
      final groupMembershipsRef = doc.data() as Map<String, dynamic>?;
      if (groupMembershipsRef == null) {
        throw Exception('Error : No found document data.');
      }

      return doc.id;
    }).toList();

    return groupMembershipsRefs;
  }

  ///Get the group database.
  static Future<GroupProfile> read(String docId) async {
    final groupDoc = await db.collection(collectionPath).doc(docId).get();
    final groupDocRef = groupDoc.data();
    if (groupDocRef == null) {
      throw Exception('Error : No found document data.');
    }

    return GroupProfile.fromMap(groupDocRef);
  }

  ///後で、アップデート機能をfactoryにして、名前、説明、画像其々個別で変更できるような関数を作成する。
  ///Update group database
  static Future<void> update({
    required String docId,
    required String name,
    required String? description,
    required String image,
  }) async {
    final imagePath =
        await StorageController.uploadGroupImageToStorage(docId, image);
    if (imagePath == null) {
      return;
    }

    final updatedAt = FieldValue.serverTimestamp();

    final updateData = <String, dynamic>{
      'name': name,
      'description': description,
      'image': imagePath,
      'updated_at': updatedAt,
    };
    await db.collection(collectionPath).doc(docId).update(updateData);
  }

  ///後でcloud functionsに設定させる。（セキュリティ的な問題のため！）
  ///Delete group
  static Future<void> delete(String docId) async {
    await db.collection(collectionPath).doc(docId).delete();
  }
}
