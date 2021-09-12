import 'package:capcha/core/public/global.dart';
import 'package:capcha/core/widgets/image/local_image_widget.dart';
import 'package:capcha/screens/change_language/language_screen.dart';
import 'package:flutter/material.dart';

class ButtonChangeLanguageWidget extends StatelessWidget {
  const ButtonChangeLanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, LanguageScreen.routeName);
      },
      child: Row(
        children: [
          LocalImageWidget(
            url: Global.imageLanguageSelected,
            height: 24,
            width: 24,
          ),
          Icon(Icons.arrow_drop_down_sharp,color: Colors.grey,)
        ],
      ),
    );
  }
}
