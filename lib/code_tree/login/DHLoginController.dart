import 'package:flutter/material.dart';
import 'package:flutter_dhyt/Helper/ProgressHud/SJProgressHud.dart';
import 'package:dio/dio.dart';

import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';




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
      child: ProgressHud(
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
                    icon:
                        Image.asset("assets/images/icon/icon_reservation.png"),
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

                Builder(builder: (context) {
                  return LoginEditCenterView(
                    paddingTop: 80,
                    usernameTextController: usernameTextController,
                    passwordTextController: passwordTextController,
                    loginCallback: (){_chickLoginItem(context);},
                    forgetCallback: () {_chickForgetItem(context);},
                  );
                }),
              ],
            ),
            LoginBottomRegisteredView(),
          ],
        ),
      ),
    );
  }

  void _chickLoginItem(BuildContext context){

    if (this.usernameTextController.text.length == 0){
      ProgressHud.of(context).showErrorAndDismiss(text: "请输入用户名");
      return;
    }

    if (this.passwordTextController.text.length == 0){
      ProgressHud.of(context).showErrorAndDismiss(text: "请输入密码");
      return;
    }

    if (this.passwordTextController.text.length < 6){
      ProgressHud.of(context).showErrorAndDismiss(text: "密码应大于6位");
      return;
    }

    _requestLoginData(context, this.usernameTextController.text, this.passwordTextController.text);

  }

  void _chickForgetItem(BuildContext context){

  }

  void _requestLoginData(BuildContext context, String username, String password) async {

    ProgressHud.of(context).showLoading(text: "登录中...");

    BaseOptions dioOptions = BaseOptions(
      baseUrl: "http://192.168.1.233/dhyt/api/",
    );

    final parames = {"loginid" : username, "password" : _generateMd5(password)};

    Dio dio = new Dio(dioOptions);
    final response = await dio.post("login", queryParameters: parames);
    print(response.data.toString());

    ProgressHud.of(context).dismiss();
  }

  String _generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

}

class LoginEditCenterView extends StatelessWidget {
  double paddingTop = 0;

  final TextEditingController usernameTextController;
  final TextEditingController passwordTextController;

  final VoidCallback loginCallback;
  final VoidCallback forgetCallback;

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
                onPressed: this.forgetCallback,
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
                  onPressed: this.loginCallback,
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
