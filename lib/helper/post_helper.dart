import 'package:hackathon_supporterz/util/constants.dart';

class PostHelper {
  /// 渡された単語に近い単語群を返すメソッド
  static List<Tag> getSuggestion(String keyword) {
    // targetList内で検索する
    List<Tag> output = [];

    targetList.map((tag) {
      if (tag.tag.contains(keyword)) {
        return output.add(tag);
      }
    }).toList();

    return output;
  }

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
}

class Tag {
  String tag, url;

  Tag({
    required this.tag,
    required this.url,
  });
}

List<Tag> targetList = [
  Tag(tag: 'Android', url: ''),
  Tag(tag: 'AWS', url: ''),
  Tag(tag: 'Dart', url: ''),
  Tag(tag: 'Flutter', url: ''),
  Tag(tag: 'Ruby', url: ''),
  Tag(tag: 'Rails', url: ''),
  Tag(tag: 'CSS', url: ''),
  Tag(tag: 'HTML', url: ''),
  Tag(tag: 'Git', url: ''),
  Tag(tag: 'Docker', url: ''),
  Tag(tag: 'Java', url: ''),
  Tag(tag: 'JavaScript', url: ''),
  Tag(tag: 'Firebase', url: ''),
  Tag(tag: 'Supabase', url: ''),
  Tag(tag: 'PHP', url: ''),
  Tag(tag: 'iOS', url: ''),
  Tag(tag: 'Laravel', url: ''),
  Tag(tag: 'Go', url: ''),
  Tag(tag: 'Python', url: ''),
  Tag(tag: 'サポーターズハッカソンVol.10', url: '')
];
