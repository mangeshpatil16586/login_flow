import 'package:flutter/material.dart';
import '../../../repositry/repositry_imp.dart';
import '../../login/login_page.dart';
import '../../resources/font_manager.dart';
import '../../resources/strings.dart';
import '../../resources/value_manager.dart';
import '../../user_info/user_page.dart';
import 'homepage_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _viewModel=HomePageViewModel();

  TextEditingController _nameTextEditingController=TextEditingController();
  TextEditingController _emailTextEditingController=TextEditingController();
  TextEditingController _passwordTextEditingController=TextEditingController();
  TextEditingController _addressTextEditingController=TextEditingController();
  TextEditingController _phonenoTextEditingController=TextEditingController();


  @override
  void initState() {

    initDatabase();
    _nameTextEditingController.addListener(() {
       _viewModel.userName.add(_nameTextEditingController.text);
    });
    _emailTextEditingController.addListener(() {
      _viewModel.inputEmail.add(_emailTextEditingController.text);
    });
    _passwordTextEditingController.addListener(() {
      _viewModel.inputPassword.add(_passwordTextEditingController.text);
    });
    _addressTextEditingController.addListener(() {
      _viewModel.inputAddress.add(_addressTextEditingController.text);
    });
    _phonenoTextEditingController.addListener(() {
      _viewModel.inputPhoneNo.add(_phonenoTextEditingController.text);
    });
    super.initState();
  }

  initDatabase() async{
    await Repository().intiDB();
  }

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _addressTextEditingController.dispose();
    _phonenoTextEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                     Strings.alreadyUser,
                     style: TextStyle(
                         fontSize: FontManager.f_15,

                     ),
                   ),
                   TextButton(
                       onPressed: (){
                         Navigator.push(context,
                             MaterialPageRoute(builder: (context)=>LoginPage())
                         );
                       }, child: Text(
                        Strings.login,
                     style: TextStyle(
                       fontSize: FontManager.f_15,
                       fontWeight: FontWeight.bold
                     ),
                   ))
                 ],
                ),
                Text('Or'),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppSize.s_20,
                      ),
                   StreamBuilder(
                       stream: _viewModel.name,
                       builder: (context,snapshot){
                         return TextFormField(
                           controller: _nameTextEditingController,
                           decoration: const InputDecoration(
                             hintText: Strings.enterName,
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
                          stream: _viewModel.outputEmail,

                          builder: (context,snapshot){

                            return TextFormField(
                              controller: _emailTextEditingController,
                              decoration: const InputDecoration(
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
                          stream: _viewModel.outputPassword,
                          builder: (context,snapshot){

                            return TextFormField(
                              controller: _passwordTextEditingController,
                              decoration: const InputDecoration(
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
                      StreamBuilder(
                          stream: _viewModel.outputAddress,
                          builder: (context,snapshot){

                            return TextFormField(
                              controller: _addressTextEditingController,
                              decoration: const InputDecoration(
                                  hintText: Strings.enteraddress,
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
                          stream: _viewModel.outputPhoneNo,
                          builder: (context,snapshot){

                            return TextFormField(
                              controller: _phonenoTextEditingController,
                              decoration: const InputDecoration(
                                  hintText: Strings.enterPhoneNo,
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
                          stream: _viewModel.checkAllOutput,
                          builder: (context,snapshot){
                            print(_viewModel.isAllInputValid());
                        return OutlinedButton(
                            onPressed: () async{
                              try {
                                bool userAddedSucessfuly = await _viewModel.insertUsers();
                                if (userAddedSucessfuly) {
                                  _nameTextEditingController.clear();
                                  _emailTextEditingController.clear();
                                  _passwordTextEditingController.clear();
                                  _addressTextEditingController.clear();
                                  _phonenoTextEditingController.clear();

                                 Navigator.push(context,
                                     MaterialPageRoute(builder: (context)=>UserInfo()));
                                }else{
                                  print('user already exits');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.orange,
                                          content: Text('Email Already exits'))
                                  );
                                }
                              }catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.orange,
                                        content: Text('Something Went wrong'))
                                );
                              }
                              },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                              fixedSize: MaterialStateProperty.all<Size>(Size(200.0, 20.0)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)
                              )),

                            ),
                            child: Text('Sign In',style: TextStyle(
                              fontSize: FontManager.f_15,
                              color: Colors.white
                            ),));
                      }),


                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
