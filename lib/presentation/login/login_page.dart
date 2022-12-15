import 'package:flutter/material.dart';
import '../resources/font_manager.dart';
import '../resources/strings.dart';
import '../resources/value_manager.dart';
import '../user_info/user_page.dart';
import 'login_viewmodel.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailTextEditingController=TextEditingController();
  TextEditingController _passwordTextEditingController=TextEditingController();
  var _viewmodel=LoginViewModel();


  @override
  void initState() {
    _emailTextEditingController.addListener(() {
      _viewmodel.emailInput.add(_emailTextEditingController.text);
    });
    _passwordTextEditingController.addListener(() {
      _viewmodel.passwordInput.add(_passwordTextEditingController.text);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: AppMargin.m_20,right: AppMargin.m_20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
           StreamBuilder(
               stream: _viewmodel.emailOutput,
               builder: (context,snapshot){
             return TextFormField(
               controller: _emailTextEditingController,
               decoration: InputDecoration(
                 hintText: Strings.enterEmail,
                   hintStyle: TextStyle(
                       color: Colors.black26
                   )
               ),
             );
           }),
              SizedBox(
                height: AppSize.s_20,
              ),
              StreamBuilder(
                  stream: _viewmodel.passwordOutput,
                  builder: (context,snapshot){
                return TextFormField(
                  controller: _passwordTextEditingController,
                  decoration: InputDecoration(
                      hintText: Strings.enterPassword,
                      hintStyle: TextStyle(
                          color: Colors.black26
                      )
                  ),
                );
              }),
              SizedBox(
                height: AppSize.s_20,
              ),
              OutlinedButton(
                  onPressed: () async{
                    try {
                      bool login = await _viewmodel.loginSuccesful();
                      if(login){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>UserInfo()));
                        _emailTextEditingController.clear();
                        _passwordTextEditingController.clear();
                      }

                    }catch(e){
                      print('User not found');
                      print('Please Check your email or password');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please Check your email or password'))
                      );
                    }
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(Size(200.0, 20.0)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    )),

                  ),
                  child: Text(Strings.login,
                  style:TextStyle(
                    fontSize: FontManager.f_15,
                    color: Colors.white
                  ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
