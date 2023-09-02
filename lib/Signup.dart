import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:news_app/interest.dart";

import "constants.dart";


class Signup extends StatefulWidget{

  @override
  
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup>{
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
   
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController usernamecontroller=TextEditingController();
  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: kBackgroundcolor,
      body: SingleChildScrollView(
        
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            
            Container(
            height:450,
            decoration: BoxDecoration(
              color: kContainercolor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50))
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text("Sign up",style:TextStyle(color: Colors.white,fontSize: 55,fontFamily: "Pacifico")),
                ),
                entrytext(controller: usernamecontroller,hint:"UserName",secure:false),
                entrytext(controller: emailcontroller,hint:"Email",secure:false),
                entrytext(controller: passwordcontroller,hint:"Password",secure:true),
              ],
            ),
            
            ),
      
            Padding(
              padding: const EdgeInsets.only(top:60,bottom: 60),
              child: CustomButton(onPressed: ()async{
                
                
                
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text);

                  if (newUser != null) {
                    print("Registered correctly");
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Interest()));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ErrorDialog(title: "Congraluation", content: " You Successfully Signed up")));
                  
                  }else{
                    print("this is else part");
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ErrorDialog(title: "Error", content: "There is a Error")));
                  }
                } catch (e) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ErrorDialog(title: "Error", content: "$e ")));
                  print("there is a error ==================================$e");
  }
                
                      
                    
                
              },
              colours: kWelcompagebutton,
              text: "Sign up"),
            ),
          
      
            Padding(
              padding: const EdgeInsets.only(bottom: 30,top:80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Already have an account?",style:TextStyle(color: const Color.fromARGB(255, 198, 198, 198))),
      
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                  },
                  child: Text("Login",style: TextStyle(color:Colors.blue),))
                ],
              ),
            ),
          
          
          ]
        ),
      ),

    );
  }
}
class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;

  const ErrorDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        ElevatedButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}