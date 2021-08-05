import 'package:flutter/material.dart';


class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  initState() {
    super.initState();
    Future.delayed(Duration(seconds:4), () {
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => true);
    });
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "images/logooo.jpg",
            fit: BoxFit.cover,
            height: double.infinity,

          ),
          Positioned(
            left: 180,
            bottom: 100,
            child: CircularProgressIndicator(
              //  backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 5,

              //  semanticsLabel: "loading.." ,
            ),
          ),
          Positioned(
            bottom: 40,
            left: 10,
            right: 10,
            child: Text(
              'NIKE - 2021',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 4,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
