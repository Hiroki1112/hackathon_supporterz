import 'package:flutter/material.dart';
import 'package:hackathon_supporterz/models/post.dart';

/// Providerなどで変更を通知しても良いが、他の画面でProviderをあまり使用しない
/// & 内部理解のためにInheritedWidget使ってみたいので、以下のWidgetを使用して状態の変更を通知する
class PostInherited extends InheritedWidget {
  const PostInherited({
    Key? key,
    required Widget child,
    required this.post,
  }) : super(key: key, child: child);
  final Post post;

  static PostInherited? of(
    BuildContext context, {
    required bool listen,
  }) {
    return listen
        ? context.dependOnInheritedWidgetOfExactType<PostInherited>()
        : context
            .getElementForInheritedWidgetOfExactType<PostInherited>()!
            .widget as PostInherited;
  }

  @override
  bool updateShouldNotify(PostInherited old) => post != old.post;
}
