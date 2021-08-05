import 'package:flutter/cupertino.dart';

class User{

  String email;
  String mobile;
  String password;

  User(this.email,this.mobile, this.password);

  User.login(this.email, this.password);

//  User(this.email, this.password, {@required this.mobile});
}