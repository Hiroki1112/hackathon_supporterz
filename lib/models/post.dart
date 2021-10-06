import 'package:hackathon_supporterz/util/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// 投稿するデータ用モデル。
class Post {
  String _title = '';
  String _planText = '';
  String _techText = '';
  String _apealText = '';

  List<String> _techTag = [];
  String _headerImageURL = '';
  // postIdはコメントなどを取得する際に使用
  String _postId = const Uuid().v1();
  DateTime _timeCreated = DateTime.now();
  DateTime _timeUpdated = DateTime.now();
  int _goods = 0;

  // == getterの定義 ================

  /// 投稿のタイトルを格納する変数。最大長は40文字。
  String get title => _title;

  /// 企画・構想の文章を格納する変数。最大長は5万文字
  String get planText => _planText;

  /// 使用した技術についての文章を保存する変数。最大長は5万文字
  String get techText => _techText;

  /// プロダクトのアピールポイントを保存する変数。最大長は5万文字
  String get apealText => _apealText;

  List<String> get techTag => _techTag;

  // titleを2-gram分割した変数。
  Map<String, bool> get title2gram => get2gram(title);

  // == setterの定義 ================

  /// 文字数が40文字以内である時のみ値をセットする。
  set setTitle(String val) {
    if (val.length < 40) {
      _title = val;
    }
  }

  set setPlanText(String val) {
    if (val.length < 50000) {
      _planText = val;
    }
  }

  set setTechText(String val) {
    if (val.length < 50000) {
      _techText = val;
    }
  }

  set setApealText(String val) {
    if (val.length < 50000) {
      _apealText = val;
    }
  }

  ///  タグは5つまで
  set setTechTag(List<String> tags) {
    // constants内に定義したもののみ追加する
    if (tags.length > 5) {
      tags = tags.sublist(0, 5);
    }
    List<String> result = [];
    for (var element in tags) {
      if (allTechTag.contains(element)) {
        result.add(element);
      }
    }
    _techTag = result;
  }

  set setHeaderImageURL(String url) {
    //　TODO: 正規表現をでURLの形式を確認する
  }

  //== method ================

  /// 渡された文章を2-gramに分解し、辞書形式に変換する関数。
  /// Firebaseの全文検索で使用。大文字は小文字に変換しておく。
  Map<String, bool> get2gram(String title) {
    String lowerTitle = title.toLowerCase();
    if (lowerTitle.length < 3) {
      return {lowerTitle: true};
    }
    Map<String, bool> _result = {};
    for (var i = 0; i < lowerTitle.length - 1; i++) {
      _result[lowerTitle[i] + lowerTitle[i + 1]] = true;
    }
    return _result;
  }

  /// Firebaseから受け取った情報を受け取る
  void fromJson(Map<String, Object> json) {
    setTitle = json['title'] as String;
    setPlanText = json['planText'] as String;
    setTechText = json['techText'] as String;
    setApealText = json['apealText'] as String;

    setTechTag = (json['techTag'] as List<String>);
    setHeaderImageURL = json['headerImageURL'] as String;
    _postId = json['postId'] as String;

    // FirebaseからはTimeStamp型で返されるのでキャストする
    _timeCreated = (json['timeCreated'] as Timestamp).toDate();
    _timeUpdated = (json['timeUpdated'] as Timestamp).toDate();

    _goods = (json['goods'] as int);
  }

  /// モデルの持つ情報をjson変換する関数
  Map<String, dynamic> toJson(String userId) {
    return {
      'title': _title,
      'title2gram': title2gram,
      'apealText': _apealText,
      'planText': _planText,
      'techText': _techText,
      'techTag': _techTag,
      'headerImageURL': _headerImageURL,
      'postId': _postId,
      'timeCreated': _timeCreated,
      'userId': userId,
      'goods': _goods,
    };
  }
}
