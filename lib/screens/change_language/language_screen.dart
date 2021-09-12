import 'package:capcha/core/public/translate.dart';
import 'package:capcha/core/widgets/image/local_image_widget.dart';
import 'package:capcha/models/language_model.dart';
import 'package:capcha/screens/change_language/language_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  static const String routeName = '/Language';

  const LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late LanguageNotifier presenter;

  @override
  Widget build(BuildContext context) {
    presenter = Provider.of<LanguageNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.text("change_language")),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: presenter.listLanguage.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemList(
            presenter.listLanguage[index],
          );
        },
      ),
    );
  }

  Widget _itemList(
    LanguageModel item,
  ) {
    return Column(
      children: [
        ListTile(
          leading: LocalImageWidget(
            url: item.image,
            height: 40,
            width: 40,
          ),
          title: Text(item.name,),
          onTap: () async {
            presenter.setLanguage(context,item);
          },
        ),
        Divider(
          height: 3,
          color: Colors.grey[400],
        )
      ],
    );
  }
}
