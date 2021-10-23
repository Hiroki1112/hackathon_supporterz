import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fbStorage;
import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/helper/app_helper.dart';
import 'package:hackathon_supporterz/models/event.dart';
import 'package:hackathon_supporterz/models/post.dart';
import 'package:hackathon_supporterz/models/simple_post.dart';
import 'package:hackathon_supporterz/models/tag.dart';
import 'package:hackathon_supporterz/models/user.dart';
import 'package:uuid/uuid.dart';

// エラーを伝えるためぶ使用する
enum CODE { userNotFound, postNotFound, tagAlreadyExists, success, failed }

class FirebaseHelper {
  static String generateUniqueId() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getKeywordSearchResult(
      String title) async {
    var db = FirebaseFirestore.instance;
    // stringを2-gramに変換
    List<String> title2gram = AppHelper.get2gram(title);

    // 変換したものを元にタイトルを検索するクエリを実装
    var query = db.collection('api').doc('v1').collection('posts').limit(20);
    for (var key in title2gram) {
      query = query.where('title2gram.' + key, isEqualTo: true);
    }

    // 取得したデータをList<Map<String, dynamic>>型に変換する

    return await query.get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getTagSearchResult(
      String tag) async {
    var db = FirebaseFirestore.instance;

    // 変換したものを元にタイトルを検索するクエリを実装
    var query = db
        .collection('api')
        .doc('v1')
        .collection('posts')
        .limit(20)
        .where('techTag', arrayContains: tag);

    return await query.get();
  }

  /// postIDが一致する投稿を取得する
  /// FUTURE: SimplePostモデル内に投稿へのドキュメントIDを含めておき
  /// 検索なしでアクセスできるようにする
  static Future<DocumentSnapshot<Map<String, dynamic>>> getPost(
      {required String postId, required String userId}) async {
    var db = FirebaseFirestore.instance;
    print(postId);
    print(userId);
    // postIdで検索
    var query = db
        .collection('api')
        .doc('v1')
        .collection('users')
        .doc(userId)
        .collection('posts')
        .doc(postId);

    var response = await query.get();

    return response;
  }

  ///  タグ追加時に使用する
  static Future<List<Tag>> getTagListByKeyword(String keyword) async {
    var db = FirebaseFirestore.instance;
    // ignore: prefer_typing_uninitialized_variables
    Query<Map<String, dynamic>> query;
    if (keyword.length < 2) {
      query = db.collection('api').doc('v1').collection('tags').limit(16);
    } else {
      List<String> keyword2gram = AppHelper.get2gram(keyword);

      // 変換したものを元にタイトルを検索するクエリを実装
      query = db.collection('api').doc('v1').collection('tags').limit(9);

      for (var element in keyword2gram) {
        query = query.where('tag2gram.' + element, isEqualTo: true);
      }
    }

    List<Tag> recommendTags = [];
    var response = await query.get();

    if (response.docs.isNotEmpty) {
      for (var element in response.docs) {
        Map data = element.data();
        recommendTags.add(
          Tag(tag: element.data()['tag'], url: data['url']),
        );
      }
    }

    return recommendTags;
  }

  static Future<List<Tag>?> getTags() async {
    var db = FirebaseFirestore.instance;
    List<Tag> recommendTags = [];

    try {
      var res = await db
          .collection('api')
          .doc('v1')
          .collection('tags')
          .limit(16)
          .get();

      if (res.docs.isNotEmpty) {
        for (var element in res.docs) {
          Map data = element.data();
          recommendTags.add(
            Tag(tag: element.data()['tag'], url: data['url']),
          );
        }
      }

      return recommendTags;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<void> userRegistration(MyUser user) async {
    var db = FirebaseFirestore.instance;
    await db
        .collection('api')
        .doc('v1')
        .collection('users')
        .doc(user.userId)
        .set(user.toJson());
  }

  /// DBから引数で渡されたuidを持つ情報を取得
  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
      String uid) async {
    var db = FirebaseFirestore.instance;
    var response =
        await db.collection('api').doc('v1').collection('users').doc(uid).get();
    return response;
  }

  /// DBから引数で渡されたuidを持つ情報を取得
  static Future<QuerySnapshot<Map<String, dynamic>>> getUserInfoByFirebaseId(
      String firebaseId) async {
    var db = FirebaseFirestore.instance;
    var response = await db
        .collection('api')
        .doc('v1')
        .collection('users')
        .where('firebaseId', isEqualTo: firebaseId)
        .get();
    print(response.docs.first);
    return response;
  }

  static Future<QuerySnapshot<Map<String, dynamic>>?> getEventInfo() async {
    var db = FirebaseFirestore.instance;
    try {
      var res = await db
          .collection('api')
          .doc('v1')
          .collection('events')
          .limit(30)
          .get();
      return res;
    } catch (e) {
      return null;
    }
  }

  /// 指定したユーザーID下のpostsコレクションを取得する
  /// DBから引数で渡されたuidを持つ情報を取得
  static Future<List<SimplePost>> getUserPosts(String uid) async {
    var db = FirebaseFirestore.instance;
    var response = await db
        .collection('api')
        .doc('v1')
        .collection('users')
        .doc(uid)
        .collection('simplePosts')
        .get();
    print(response.docs.first.data());
    print(response.metadata);
    print(response.size);
    List<SimplePost> posts = [];
    for (var p in response.docs) {
      posts.add(SimplePost.fromJson(p.data()));
    }
    return posts;
  }

  // ================================
  //  firebaseへ情報を保存する系の関数
  //

  /// 引数で受け取ったPostクラス内の情報を保存する関数
  static Future<void> save2firebase(Post post, String userId) async {
    // firebaseへ投稿する
    var db = FirebaseFirestore.instance;
    await db
        .collection('api')
        .doc('v1')
        .collection('users')
        .doc(userId)
        .collection('posts')
        .doc(post.postId)
        .set(
          post.toJson(userId),
        );
  }

  // タグと画像を保存する
  static Future<dynamic> addNewTags(Uint8List? image, String tag) async {
    var db = FirebaseFirestore.instance;
    fbStorage.Reference ref = fbStorage.FirebaseStorage.instance.ref();
    Map<String, dynamic> json = {};
    String _fileName = generateUniqueId();

    // nullは弾く
    if (image == null) {
      return;
    }

    // まずは既に同じタグが保存されていないか確認する
    var result = await db
        .collection('api')
        .doc('v1')
        .collection('tags')
        .doc(tag.toLowerCase())
        .get();

    if (result.data() != null) {
      // 既にデータがある時には保存しない
      return CODE.tagAlreadyExists;
    }

    json['tag'] = tag;
    json['tag2gram'] = AppHelper.get2gramMap(tag.toLowerCase());

    // 画像をfirebase storageに保存してURLを取得する
    var snapshot =
        await ref.child('tagImage/' + _fileName + '.png').putData(image);
    String downloadUrl = await snapshot.ref.getDownloadURL();

    json['url'] = downloadUrl;
    // 受け取った情報を保存する
    await db
        .collection('api')
        .doc('v1')
        .collection('tags')
        .doc(tag.toLowerCase())
        .set(json);
    return CODE.success;
  }

  /// firebase storageに画像を保存し、URIを返却する関数
  static Future<dynamic> saveAndGetURL(Uint8List? image) async {
    fbStorage.Reference ref = fbStorage.FirebaseStorage.instance.ref();
    String _fileName = generateUniqueId();
    if (image == null) {
      return CODE.failed;
    }

    try {
      // 画像を保存する
      // 画像をfirebase storageに保存してURLを取得する
      var snapshot =
          await ref.child('postImage/' + _fileName + '.png').putData(image);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      return CODE.failed;
    }
  }

  static Future<dynamic> saveEvent(Event events) async {
    var db = FirebaseFirestore.instance;
    try {
      // 受け取った情報を保存する
      await db
          .collection('api')
          .doc('v1')
          .collection('events')
          .add(events.toJson());
      return CODE.success;
    } catch (e) {
      return CODE.failed;
    }
  }
}
