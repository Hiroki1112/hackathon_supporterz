import 'package:flutter_test/flutter_test.dart';
import 'package:jiffy/models/post.dart';

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

    // 重複するものは除かれる。大体の全文検索しかできないバグ(仕様)がある
    myPost.setTitle = 'abcab';
    expect(myPost.title2gram, {'ab': true, 'bc': true, 'ca': true});

    // 2-gram変換した時は、大文字は小文字に変換される
    myPost.setTitle = 'ABC';
    expect(myPost.title2gram, {'ab': true, 'bc': true});
  });

  test('企画のテキスト長についてのテスト', () {
    // 企画などのテキストは5万文字以内
    myPost.setPlanText = 'a' * 50000;
    expect(myPost.planText, 'a' * 50000);

    // 50001文字からは追加されない
    myPost.setPlanText = 'a' * 50001;
    expect(myPost.planText, 'a' * 50000);
  });

  test('本文のテキスト長についてのテスト', () {
    // 企画などのテキストは5万文字以内
    myPost.setBodyText = 'a' * 50000;
    expect(myPost.bodyText, 'a' * 50000);

    // 50001文字からは追加されない
    myPost.setBodyText = 'a' * 50001;
    expect(myPost.bodyText, 'a' * 50000);
  });

  test('技術タグについてのテスト', () {
    // タグはconstants.dartに保存しているもののみ使用できる仕様
    // また、1投稿につき5個のタグまで追加できる。

    // 正しく追加できる場合
    myPost.setTechTag = ['Python', 'Flutter'];
    expect(myPost.techTag, ['Python', 'Flutter']);

    // 不正なタグが追加された場合は弾く`
    myPost.setTechTag = ['Python', 'ほげほげ', '津軽海峡冬景色'];
    expect(myPost.techTag, ['Python']);

    // 5つ以上タグは追加できない
    myPost.setTechTag = ['Android', 'AWS', 'Dart', 'Flutter', 'Ruby', 'Rails'];
    expect(myPost.techTag, ['Android', 'AWS', 'Dart', 'Flutter', 'Ruby']);
  });

  test('header URLについてのテスト', () {
    // ignore: todo
    // TODO:URLの形式が正しいかテストする
  });
}
