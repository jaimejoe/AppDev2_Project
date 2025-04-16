import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {

    @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context,'/register');
      }
    );
    
  }
  
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue,Colors.black ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit,color: Colors.white,size: 70,
            ),
            SizedBox(
              child: Text("Welcome User",style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 30,
                color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
