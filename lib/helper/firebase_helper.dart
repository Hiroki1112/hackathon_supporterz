import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_supporterz/helper/app_helper.dart';
import 'package:hackathon_supporterz/helper/post_helper.dart';
import 'package:hackathon_supporterz/models/simple_post.dart';
import 'package:hackathon_supporterz/models/user.dart';

class FirebaseHelper {
  static Future<QuerySnapshot<Map<String, dynamic>>> getKeywordSearchResult(
      String title) async {
    var db = FirebaseFirestore.instance;
    // stringを2-gramに変換
    List<String> title2gram = AppHelper.get2gram(title);

    // 変換したものを元にタイトルを検索するクエリを実装
    var query = db.collection('api').doc('v1').collection('posts').limit(20);
    title2gram.forEach((key) {
      query = query.where('title2gram.' + key, isEqualTo: true);
    });

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
  static Future<QuerySnapshot<Map<String, dynamic>>> getPostByPostId(
      String postId) async {
    var db = FirebaseFirestore.instance;

    // postIdで検索
    var query = db
        .collection('api')
        .doc('v1')
        .collection('posts')
        .where('postId', isEqualTo: postId);

    return await query.get();
  }

  ///  タグ追加時に使用する
  static Future<List<Tag>> getTagListByKeyword(String keyword) async {
    var db = FirebaseFirestore.instance;
    // ignore: prefer_typing_uninitialized_variables
    Query<Map<String, dynamic>> query;
    if (keyword == '') {
      query = db.collection('api').doc('v1').collection('tags').limit(9);
    } else {
      List<String> keyword2gram = AppHelper.get2gram(keyword);
      print(keyword2gram);
      // 変換したものを元にタイトルを検索するクエリを実装
      query = db.collection('api').doc('v1').collection('tags').limit(9);

      keyword2gram.forEach((element) {
        query = query.where('tag2gram.' + element, isEqualTo: true);
      });
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
  static Future<MyUser> getUserInfo(String uid) async {
    var db = FirebaseFirestore.instance;
    var response =
        await db.collection('api').doc('v1').collection('users').doc(uid).get();
    MyUser _myUser = MyUser();
    _myUser.fromJson(response.data() ?? {});
    return _myUser;
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

    List<SimplePost> posts = [];
    if (response.docs.isNotEmpty) {
      response.docs.map((post) {
        posts.add(SimplePost.fromJson(post.data()));
      });
    }

    return posts;
  }

  ///  タグ追加時に使用する
  /*
  static Future<void> addNewTag() async {
    var db = FirebaseFirestore.instance;

    // 現在のタグを取得する
    var query = await db.collection('api').doc('v1').collection('tags').get();

    Future.forEach(query.docs,
        (QueryDocumentSnapshot<Map<String, dynamic>> element) async {
      Map<String, dynamic> newData = element.data();
      newData['tag2gram'] =
          AppHelper.get2gramMap(element.data()['tag'].toString().toLowerCase());
      await db
          .collection('api')
          .doc('v1')
          .collection('tags')
          .doc(element.id)
          .update(
            newData,
          );
    });
  }*/
}
