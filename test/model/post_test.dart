import 'package:flutter_test/flutter_test.dart';
import 'package:hackathon_supporterz/models/post.dart';

void main() {
  final Post myPost = Post();

  test('タイトルの長さについてのバリデーションテスト', () {
    // タイトルの文字数は40文字以内
    myPost.setTitle = 'a' * 40;
    expect(myPost.title, 'a' * 40);

    // 41文字からは追加されない
    myPost.setTitle = 'a' * 41;
    expect(myPost.title, 'a' * 40);
  });

  test('タイトルの2-gram変換についてのテスト', () {
    // 2文字以下の時はそのまま出力（タイトル○文字以上とフロントで制限する予定....）
    myPost.setTitle = 'a';
    expect(myPost.title2gram, {'a': true});

    myPost.setTitle = 'ab';
    expect(myPost.title2gram, {'ab': true});

    myPost.setTitle = 'abc';
    expect(myPost.title2gram, {'ab': true, 'bc': true});

    myPost.setTitle = 'abcab';
    expect(myPost.title2gram, {'ab': true, 'bc': true, 'ca': true});
  });
}
