/// アプリケーション内の各所で必要になる関数などをまとめたクラス
class AppHelper {
  /// 渡された文章を2-gramに分解し、辞書形式に変換する関数。
  /// Firebaseの全文検索で使用。大文字は小文字に変換しておく。
  static Map<String, bool> get2gramMap(String title) {
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

  /// 渡された文章を2-gramに分解し、リストで返す関数
  /// Firebaseの全文検索で使用。大文字は小文字に変換しておく。
  static List<String> get2gram(String title) {
    String lowerTitle = title.toLowerCase();
    if (lowerTitle.length < 3) {
      return [lowerTitle];
    }
    List<String> _result = [];
    for (var i = 0; i < lowerTitle.length - 1; i++) {
      _result.add(lowerTitle[i] + lowerTitle[i + 1]);
    }
    return _result;
  }
}
