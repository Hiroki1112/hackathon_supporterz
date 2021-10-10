import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hackathon_supporterz/helper/post_helper.dart';
import 'package:hackathon_supporterz/util/app_theme.dart';

class TagSetting extends StatefulWidget {
  const TagSetting({Key? key}) : super(key: key);

  @override
  _TagSettingState createState() => _TagSettingState();
}

class _TagSettingState extends State<TagSetting> {
  List<Tag> _tags = [];
  @override
  Widget build(BuildContext context) {
    print(_tags);
    return Column(
      children: [
        const Text(
          '制作物に関係するタグを選択してください。(5個以内)',
          maxLines: 2,
        ),
        TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            autofocus: true,
            style: DefaultTextStyle.of(context).style.copyWith(
                  fontStyle: FontStyle.italic,
                ),
          ),
          suggestionsCallback: (String pattern) {
            // タグ名と画像を取得する
            List<Tag> output = [];

            targetList.map((t) {
              if (t.tag.contains(pattern)) {
                return output.add(t);
              }
            }).toList();
            return PostHelper.getSuggestion(pattern);
          },
          itemBuilder: (BuildContext context, Tag suggestion) {
            return ListTile(
              leading: suggestion.url != ''
                  ? Image.network(suggestion.url)
                  : Icon(Icons.add),
              title: Text(suggestion.tag),
            );
          },
          onSuggestionSelected: (Tag suggestion) {
            if (_tags.length < 5) {
              setState(() {
                _tags.add(suggestion);
              });
            }
          },
        ),
        // タグは下に整列させる
        SizedBox(height: 15),
        Wrap(
          children: List.generate(
            _tags.length,
            (index) => TagIcon(
              tag: _tags[index],
              deleteFunc: () {
                _tags.removeAt(index);
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
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 5),
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
              : Image.asset(
                  tag.url,
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
