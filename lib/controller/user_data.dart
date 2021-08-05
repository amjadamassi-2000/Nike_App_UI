import 'package:nike_app/controller/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {

  static const LOGIN_KEY = 'login';
  static const EMAIL_KEY = 'email';
  static const MOBILE_KEY = 'mobile';
  static const PASSWORD_KEY = 'password';

//  final String EMAIL_KEY = 'email';
//  final String MOBILE_KEY = 'mobile';
//  final String PASSWORD_KEY = 'password';

  void save(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(EMAIL_KEY, user.email);
    await prefs.setString(MOBILE_KEY, user.mobile);
    await prefs.setString(PASSWORD_KEY, user.password);
  }

  void setLogin(bool isLoggedIn)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(LOGIN_KEY, isLoggedIn);
  }

  Future<bool> isLoggedIn() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(LOGIN_KEY);
    return isLoggedIn == null ? false : isLoggedIn ;
  }

  Future<User> getLoggedInUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString(EMAIL_KEY);
    String password = prefs.getString(PASSWORD_KEY);
    String mobile = prefs.getString(MOBILE_KEY);
    return User(email, mobile, password);
  }

  Future<User> login(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString(EMAIL_KEY);
    String password = prefs.getString(PASSWORD_KEY);
    String mobile = prefs.getString(MOBILE_KEY);
    if (user.email == email && user.password == password) {
      User user = User(email, mobile, password);
      return user;
    } else {
      return null;
    }
  }
}
