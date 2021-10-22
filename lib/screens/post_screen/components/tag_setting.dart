import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hackathon_supporterz/helper/firebase_helper.dart';
import 'package:hackathon_supporterz/models/tag.dart';
import 'package:hackathon_supporterz/screens/post_screen/components/popup/add_tag.dart';
import 'package:hackathon_supporterz/screens/post_screen/components/post_inherited.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';

class TagSetting extends StatefulWidget {
  const TagSetting({
    Key? key,
  }) : super(key: key);

  @override
  _TagSettingState createState() => _TagSettingState();
}

class _TagSettingState extends State<TagSetting> {
  List<Tag> tags = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '制作物に関係するタグを選択してください。(5個以内)',
              maxLines: 2,
            ),
            TextButton(
              onPressed: () async {
                Map? data = await addTagPopup(context);
                if (data == null) {
                  return;
                }
                await FirebaseHelper.addNewTags(data['image'], data['tag']);
              },
              child: const Text('（タグを追加する）'),
            ),
          ],
        ),
        TypeAheadField(
          suggestionsCallback: (String pattern) {
            return FirebaseHelper.getTagListByKeyword(pattern);
          },
          itemBuilder: (BuildContext context, Tag suggestion) {
            return ListTile(
              leading: suggestion.url != ''
                  ? Container(
                      padding: const EdgeInsets.all(8.0),
                      width: 50,
                      height: 50,
                      child: Image.network(
                        suggestion.url,
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                    )
                  : const Icon(Icons.add),
              title: Text(suggestion.tag),
            );
          },
          onSuggestionSelected: (Tag suggestion) {
            // 同じタグは追加できないようにする。
            // .contains()ではうまく判定できなかった。
            for (var tag in tags) {
              if (tag.tag == suggestion.tag) {
                return;
              }
            }
            if (tags.length < 5) {
              setState(() {
                tags.add(suggestion);
                List<String> tag = tags.map((t) => t.tag).toList();
                PostInherited.of(context, listen: false)!.post.setTechTag = tag;
              });
            }
          },
        ),
        // タグは下に整列させる
        const SizedBox(height: 15),
        Wrap(
          children: List.generate(
            tags.length,
            (index) => TagIcon(
              tag: tags[index],
              deleteFunc: () {
                tags.removeAt(index);
                List<String> tag = tags.map((t) => t.tag).toList();
                PostInherited.of(context, listen: false)!.post.setTechTag = tag;
                setState(() {});
              },
            ),
          ),
        )
      ],
    );
  }
}

class TagIcon extends StatelessWidget {
  const TagIcon({
    Key? key,
    required this.tag,
    required this.deleteFunc,
  }) : super(key: key);
  final Tag tag;
  final Function deleteFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkShadow,
            spreadRadius: 1.0,
            blurRadius: 3.0,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          tag.url == ''
              ? const Text(
                  '#',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  width: 50,
                  height: 50,
                  child: Image.network(
                    tag.url,
                    width: 50,
                    height: 50,
                    fit: BoxFit.fill,
                  ),
                ),
          Text(tag.tag),
          IconButton(
            onPressed: () async {
              await deleteFunc();
            },
            padding: const EdgeInsets.all(0.0),
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
    );
  }
}
