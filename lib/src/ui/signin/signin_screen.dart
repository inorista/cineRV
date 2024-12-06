import 'package:cinerv/src/commons/common_button.dart';
import 'package:cinerv/src/constants/style_constants.dart';
import 'package:cinerv/src/ui/signin/widgets/login_text_field.dart';
import 'package:cinerv/src/utils/platform_scroll_behavior_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: SingleChildScrollView(
              physics: PlatformScrollBehaviorUtils.getPlatformScrollBehavior(),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0.1.sh),
                    Center(child: SvgPicture.asset("assets/images/cuate.svg")),
                    const SizedBox(height: 50),
                    const Text(
                      "Nhập tên tài khoản",
                      style: kStyleItemLogin,
                    ),
                    const SizedBox(height: 14),
                    const LoginTextField(title: "Tên tài khoản..."),
                    const SizedBox(height: 20),
                    const Text(
                      "Nhập mật khẩu",
                      style: kStyleItemLogin,
                    ),
                    const SizedBox(height: 14),
                    const LoginTextField(
                      title: "Mật khẩu...",
                      passWordMode: true,
                      action: TextInputAction.done,
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Quên mật khẩu ?",
                        style: kStylePlaceHolderLogin,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const CommonButton(
                      title: "Đăng Nhập",
                      useFullWidth: true,
                      buttonColor: Colors.black,
                      buttonHeight: 17,
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Chưa có tài khoản?",
                          style: kStylePlaceHolderLogin,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Đăng ký ngay",
                          style: kStyleSignIn,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
