import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'color.dart';

class RatingBarScreen extends StatelessWidget {
  const RatingBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingBar.builder(
            initialRating: 3,
            itemCount: 5,
            updateOnDrag: true,
            glow: false, wrapAlignment: WrapAlignment.spaceEvenly,

            // glowColor: ,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return const Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: Colors.red,
                  );
                case 1:
                  return const Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.redAccent,
                  );
                case 2:
                  return const Icon(
                    Icons.sentiment_neutral,
                    color: Colors.amber,
                  );
                case 3:
                  return const Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.lightGreen,
                  );
                case 4:
                  return const Icon(
                    Icons.sentiment_very_satisfied,
                    color: Colors.green,
                  );
                default:
                  return const Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.green,
                  );
              }
            },
            onRatingUpdate: (rating) {
              BetterFeedback.of(context).show((UserFeedback feedback) {
                print(feedback);
                // Do something with the feedback
              });
            },
          ),
          PsTextFieldWidgetV2(
            titleText: "Feedback",
            hintText: "Feedback",
            textAboutMe: false,
            phoneInputType: false,
            isMandatory: false,
            showTitle: true,
            keyboardType: TextInputType.emailAddress, //Added keyboard type
            // textEditingController: emailController,
            // readOnly: emailController.text != null && emailController.text != ''
            //     ? true
            //     : false,
            onFieldSubmitted: () {
              // FocusScope.of(context).requestFocus(username);
            },
          ),
        ],
      ),
    ));
  }
}

class PsTextFieldWidgetV2 extends StatelessWidget {
  const PsTextFieldWidgetV2(
      {this.textEditingController,
      this.titleText = '',
      this.hintText,
      this.textAboutMe = false,
      this.height = 44,
      this.showTitle = true,
      this.keyboardType = TextInputType.text,
      this.phoneInputType = false,
      this.isMandatory = false,
      this.inputFormatterList,
      this.readOnly = false,
      this.focusNode,
      this.obscureText = false,
      this.onFieldSubmitted});

  final TextEditingController? textEditingController;
  final String titleText;
  final String? hintText;
  final double height;
  final bool textAboutMe;
  final TextInputType keyboardType;
  final bool showTitle;
  final bool phoneInputType;
  final bool isMandatory;
  final List<TextInputFormatter>? inputFormatterList;
  final bool readOnly;
  final FocusNode? focusNode;
  final bool obscureText;
  final Function? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    final Widget _productTextWidget = Text(titleText,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: PsColors.grey));

    return Column(
      children: <Widget>[
        if (showTitle)
          Container(
            decoration: BoxDecoration(
              color: PsColors.backgroundColor,
              // borderRadius: BorderRadius.circular(PsDimens.space4),
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            // margin:
            //     const EdgeInsets.only(left: 0, top: PsDimens.space12, right: 0),
            child: Row(
              children: <Widget>[
                _productTextWidget,
                Expanded(
                  child: Container(

                      // width: double.infinity,
                      height: height,
                      margin: const EdgeInsets.all(12),
                      child: TextField(
                          keyboardType: keyboardType, //Changed keyboard type
                          // maxLines: null,
                          controller: textEditingController,
                          style: Theme.of(context).textTheme.bodyText2,
                          readOnly: readOnly,
                          obscureText: obscureText,
                          //Added Input Formatter
                          inputFormatters:
                              (inputFormatterList ?? <TextInputFormatter>[]),
                          focusNode: focusNode, //Added FocusNode
                          onEditingComplete:
                              onFieldSubmitted as void Function()?,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              left: -10,
                              right: 10,
                              // bottom: PsDimens.space8,
                            ),
                            border: InputBorder.none,
                            hintText: hintText,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: PsColors.textPrimaryLightColor),
                          ))),
                ),
              ],
            ),
          )
        else
          Container(
            height: 0,
          ),
      ],
    );
  }
}
