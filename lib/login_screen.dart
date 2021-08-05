import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'controller/auth.dart';
import 'controller/user.dart';
import 'controller/user_data.dart';

class LoginScreen extends StatefulWidget {
  final String title;

  const LoginScreen({ this.title});


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  TextEditingController _emailControllerRegister     = TextEditingController();
  TextEditingController _passwordControllerRegister    = TextEditingController();
  TextEditingController _mobileControllerRegister     = TextEditingController();


  UserData userData = UserData();
  AuthMode _authMode = AuthMode.Login;









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [

          Image.asset("images/login2.jpg",
             fit: BoxFit.cover,
             height: double.infinity,
             width: double.infinity,
           ),

             Container(
               color: Colors.white.withOpacity(0.6),
             ),

          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[


                Padding(
                  padding: const EdgeInsets.only(left: 100 , bottom: 100),
                  child: Text(_authMode == AuthMode.Login ? 'LOGIN' : "SIGNUP",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,

                    ),
                  ),
                ),


                _authMode == AuthMode.Signup ?
                Column(
                  children: [
                    TextField(
                      controller: _emailControllerRegister,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _mobileControllerRegister,
                      decoration: InputDecoration(
                        hintText: 'Mobile',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _passwordControllerRegister,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ) : Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),


                _authMode == AuthMode.Signup ?
                FlatButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/register');
                    setState(() {
                      _authMode = _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;

                    } );
                    register();
                  },
                  child: Text('Register'),
                ) : FlatButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/register');
                    setState(() {
                      _authMode = _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;

                    } );

                  },
                  child: Text('Create new account'),
                ),

                RaisedButton(
                  onPressed: () {
                    login();
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue.shade300,
                ),






              ],
            ),
          ),



        ],
      ),
    );
  }



  void login() async {
    if (checkData()) {
      User user = User.login(_emailController.text, _passwordController.text);
      User loggedInUser = await userData.login(user);
      if (loggedInUser != null) {
        userData.setLogin(true);
        Navigator.pushNamedAndRemoveUntil(context, '/Home', (route) => true);
//        Navigator.pushAndRemoveUntil(
//            context, MaterialPageRoute(builder: (context) => HomeScreen(user: loggedInUser,),), (
//            route) => false);
      } else {
        print('FAILED');
      }
    } else {
      print('ERROR DATA');
    }
  }

  bool checkData() {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }



  void register() {
    if (_emailControllerRegister.text.isNotEmpty &&
        _mobileControllerRegister.text.isNotEmpty&&
        _passwordControllerRegister.text.isNotEmpty) {
      print('REGISTER');
      User user = User(_emailControllerRegister.text, _mobileControllerRegister.text,_passwordControllerRegister.text);
      UserData userData = UserData();
      userData.save(user);
    } else {
      print('ERROR DATA');
    }
  }








}
