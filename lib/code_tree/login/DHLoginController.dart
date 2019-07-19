import 'package:flutter/material.dart';
import 'package:bmprogresshud/bmprogresshud.dart';
import 'dart:async';

class DHLoginController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "地厚云图登录",
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            // 背景图片
            Center(
              child: Image.asset(
                "assets/images/login/login_backgroud.png",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            LoginSafeAreaContent(),
          ],
        ),
      ),
    );
  }
}

class LoginSafeAreaContent extends StatelessWidget {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // 预约按钮
              Container(
                alignment: Alignment.topRight,
                height: 50,
                child: FlatButton.icon(
                  onPressed: () {},
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Image.asset("assets/images/icon/icon_reservation.png"),
                  label: Text(
                    "发起预约",
                    style: TextStyle(color: Color(0xFFE16036), fontSize: 14),
                  ),
                ),
              ),

              // logo
              Container(
                padding: EdgeInsets.only(top: 60),
                child: Image.asset("assets/images/login/login_logo.png"),
              ),

              // 账号密码
              ProgressHud(
                child: LoginEditCenterView(
                  paddingTop: 80,
                  usernameTextController: usernameTextController,
                  passwordTextController: passwordTextController,
                  loginCallback: (centerContext) {

                  },
                  forgetCallback: (centerContext) {},
                ),
              ),
            ],
          ),
          LoginBottomRegisteredView(),
        ],
      ),
    );
  }
}

class LoginEditCenterView extends StatelessWidget {
  double paddingTop = 0;

  final TextEditingController usernameTextController;
  final TextEditingController passwordTextController;

  final void Function(BuildContext centerContext) loginCallback;
  final void Function(BuildContext centerContext) forgetCallback;

  LoginEditCenterView(
      {Key key,
      @required this.paddingTop,
      @required this.usernameTextController,
      @required this.passwordTextController,
      @required this.loginCallback,
      @required this.forgetCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: this.paddingTop),
      width: 266,
      child: Column(
        children: <Widget>[
          LoginEditTextField(
            textController: this.usernameTextController,
            leftIconImageName: "assets/images/login/login_icon_username.png",
            hitText: "手机号/身份证号",
            obscureText: false,
          ),
          // 账号

          Padding(
            padding: EdgeInsets.only(top: 14),
          ),

          LoginEditTextField(
            textController: this.passwordTextController,
            leftIconImageName: "assets/images/login/login_icon_password.png",
            hitText: "密码",
            obscureText: true,
          ),

          // 忘记密码

          Container(
            height: 40,
            child: FlatButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed:(){
                  this.loginCallback(context);
                },
                child: Text(
                  "忘记密码",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w300),
                )),
            alignment: Alignment.topRight,
          ),

          // 登录按钮
          Container(
            height: 48,
            padding: EdgeInsets.only(top: 4),
            width: double.infinity,
            child: Material(
              borderRadius: BorderRadius.circular(4),
              child: FlatButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  color: Color(0xFFE16036),
                  onPressed: (){
                    this.forgetCallback(context);
                  },
                  child: Text(
                    "登录",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginEditTextField extends StatelessWidget {
  final TextEditingController textController;
  final String leftIconImageName;
  final String hitText;
  final bool obscureText;

  LoginEditTextField(
      {Key key,
      @required this.textController,
      @required this.leftIconImageName,
      @required this.hitText,
      @required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset("assets/images/login/login_textbg.png"),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: TextField(
                style: TextStyle(fontSize: 13),
                textDirection: TextDirection.ltr,
                controller: this.textController,
                obscureText: this.obscureText,
                decoration: InputDecoration(
                  icon: Image.asset(this.leftIconImageName),
                  hintText: this.hitText,
                  hintStyle: TextStyle(fontSize: 13),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginBottomRegisteredView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.bottomCenter,
      child: FlatButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () {},
        child: RichText(
          text: TextSpan(
            text: "还没有账号？",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
            children: <TextSpan>[
              TextSpan(
                text: "注册",
                style: TextStyle(
                    color: Color(0xFFE16036), fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
