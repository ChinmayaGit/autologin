import 'dart:async';
import 'package:autologin/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    title: "Auth Demo",
    home: Home(),
  ));
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController createEmailController = new TextEditingController();
  TextEditingController createPasswordController = new TextEditingController();
  bool setTime=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: setTime==true?Center(child: CircularProgressIndicator()):

      SingleChildScrollView(
        child: Column(
          children: [

        SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Text("Create your Account"),),
            ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            autofocus: true,
            controller: createEmailController,
            validator: (value) {
              if (value!.isEmpty) return 'This field cannot be empty';
              return null;
            },
// onSaved: (value) => url = value,
            decoration: InputDecoration(
              hintText: 'Gmail',
              labelText: 'Gmail',
              errorText: 'Error message',
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.add_link,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            autofocus: true,
            controller: createPasswordController,
            validator: (value) {
              if (value!.isEmpty) return 'This field cannot be empty';
              return null;
            },
// onSaved: (value) => url = value,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              errorText: 'Error message',
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.add_link,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // signUpWithEmail();
            signUpWithEmail();
          },
          child: Container(
            height: 60,
            width: 150,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(50.0),
                  bottomRight: const Radius.circular(50.0),
                ),
              ),
              color: Colors.deepOrangeAccent,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SignUp",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.send,
                    color: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ),
        ),

            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Text("Login Account"),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autofocus: true,
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty)
                    return 'This field cannot be empty';
                  return null;
                },
// onSaved: (value) => url = value,
                decoration: InputDecoration(
                  hintText: 'Gmail',
                  labelText: 'Gmail',
                  errorText: 'Error message',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.add_link,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autofocus: true,
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty) return 'This field cannot be empty';
                  return null;
                },
// onSaved: (value) => url = value,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  errorText: 'Error message',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.add_link,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // signUpWithEmail();
                signInWithEmail();
              },
              child: Container(
                height: 60,
                width: 150,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(50.0),
                      bottomRight: const Radius.circular(50.0),
                    ),
                  ),
                  color: Colors.deepOrangeAccent,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        setTime=false;
      });

    });
    Timer(Duration(seconds: 1), () {
      getUser().then((user) {
        if (user != null) {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
        }
      });
    });

  }

  Future<User?> getUser() async {
    return _auth.currentUser;
  }

  void signUpWithEmail() async {
    // marked async
    UserCredential user;
    try {
      user = await _auth.createUserWithEmailAndPassword(
        email: createEmailController.text,
        password: createPasswordController.text,
      );
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    } catch (e) {
      print(e.toString());
    } finally {
      // if (user != null) {
      //   // sign in successful!
      //   // ex: bring the user to the home page
      // } else {
      //   // sign in unsuccessful
      //   // ex: prompt the user to try again
      // }
    }
  }

  void signInWithEmail() async {
    // marked async
    UserCredential user;
    try {
      user = (await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text));
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    } catch (e) {
      print(e.toString());
    } finally {
      // if (user != null) {
      //   // sign in successful!
      //   // ex: bring the user to the home page
      //   print("chinuin");
      // } else {
      //   print("chinuout");
      //   // sign in unsuccessful
      //   // ex: prompt the user to try again
      // }
    }
  }
}
