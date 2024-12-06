import 'package:cinerv/src/constants/style_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final String title;
  final bool passWordMode;
  final TextInputAction action;
  const LoginTextField({
    required this.title,
    this.passWordMode = false,
    this.action = TextInputAction.next,
    super.key,
  });

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  final _textController = TextEditingController(text: "");
  FocusNode _focusNode = FocusNode();
  bool _showPassword = false;
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      focusNode: _focusNode,
      obscureText: widget.passWordMode
          ? _showPassword
              ? true
              : false
          : false,
      enableSuggestions: false,
      textInputAction: widget.action,
      placeholder: widget.title,
      placeholderStyle: kStylePlaceHolderLogin,
      autocorrect: false,
      autofocus: false,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xffD1D1D1)),
        borderRadius: BorderRadius.circular(18),
      ),
      onTap: () {
        _focusNode.requestFocus();
      },
      suffix: widget.passWordMode
          ? _showPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _showPassword = false;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(
                      CupertinoIcons.eye_slash_fill,
                      color: Colors.black,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      _showPassword = true;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(
                      CupertinoIcons.eye_fill,
                      color: Colors.black,
                    ),
                  ),
                )
          : const SizedBox(),
    );
  }
}
