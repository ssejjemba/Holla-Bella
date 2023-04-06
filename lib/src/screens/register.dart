import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:holla_bella/injection.dart';
import 'package:holla_bella/src/application/auth/sign_up_form/sign_up_form_bloc.dart';
import 'package:holla_bella/src/screens/login.dart';
import 'package:holla_bella/src/widgets/bezier_container.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Widget _googleSignUpButton() {
    return BlocConsumer<SignUpFormBloc, SignUpFormState>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context
                .read<SignUpFormBloc>()
                .add(const SignUpFormEvent.signInWithGooglePressed());
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 13),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0xffeeeeee),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Wrap(
                children: <Widget>[
                  Image.asset(
                    'assets/images/google_logo.png',
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Continue with Google',
                    style: GoogleFonts.mulish(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xff1c2249),
                    ),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.visible,
                  ),
                ],
              )),
        );
      },
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xff1c2249),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return BlocConsumer<SignUpFormBloc, SignUpFormState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<SignUpFormBloc>().add(
                const SignUpFormEvent.registerWithEmailAndPasswordPressed());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xff1f264e), Color(0xff1c2249)])),
            child: const Text(
              'Register Now',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  Widget _entryField(String title, void Function(String) onChange,
      String? Function(String?) validator,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: isPassword,
            decoration: const InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
            validator: validator,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: BlocConsumer<SignUpFormBloc, SignUpFormState>(
        listener: (context, state) {
          state.authFailureOrSuccessOption.fold(
              () => null,
              (either) => either.fold(
                  (failure) => {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            /// need to set following properties for best effect of awesome_snackbar_content
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'On Snap!',
                              message: failure.map(
                                cancelledByUser: (_) =>
                                    'Cancelled google auth before completion',
                                serverError: (_) => 'Something went wrong',
                                emailAlreadyInUse: (_) =>
                                    'The Email is already registered',
                                invalidCredentials: (_) =>
                                    'Invalid Credentials',
                              ),

                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                              contentType: ContentType.failure,
                            ),
                          ))
                      },
                  (r) => {Navigator.pushNamed(context, '/home')}));
        },
        builder: (context, state) {
          void onEmailChange(String value) {
            context
                .read<SignUpFormBloc>()
                .add(SignUpFormEvent.emailChanged(value));
          }

          void onUsernameChange(String value) {
            context
                .read<SignUpFormBloc>()
                .add(SignUpFormEvent.usernameChanged(value));
          }

          void onPasswordChange(String value) {
            context
                .read<SignUpFormBloc>()
                .add(SignUpFormEvent.passwordChanged(value));
          }

          String? validateEmail(_) {
            return context.read<SignUpFormBloc>().state.emailAdress.value.fold(
                (f) => f.maybeMap(
                      invalidEmail: (_) => 'Invalid Email',
                      orElse: () => null,
                    ),
                (r) => null);
          }

          String? validateUsername(_) {
            return context.read<SignUpFormBloc>().state.username.value.fold(
                (f) => f.maybeMap(
                      shortUsername: (_) =>
                          'Username should be atleast 3 characters',
                      orElse: () => null,
                    ),
                (r) => null);
          }

          String? validatePassword(_) {
            return context.read<SignUpFormBloc>().state.password.value.fold(
                (f) => f.maybeMap(
                      shortPassword: (_) =>
                          'Password should be atleast 6 characters',
                      orElse: () => null,
                    ),
                (r) => null);
          }

          return Column(
            children: <Widget>[
              _entryField("Username", onUsernameChange, validateUsername),
              _entryField("Email id", onEmailChange, validateEmail),
              _entryField("Password", onPasswordChange, validatePassword,
                  isPassword: true),
            ],
          );
        },
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'Tr',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xff1c2249)),
          children: [
            TextSpan(
              text: 'ans',
              style: TextStyle(color: Color(0xffff7f50), fontSize: 30),
            ),
            TextSpan(
              text: 'parent',
              style: TextStyle(color: Color(0xff1c2249), fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer(),
            ),
            BlocProvider(
              create: (context) => getIt<SignUpFormBloc>(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: height * .2,
                    ),
                    _title(),
                    const SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    _divider(),
                    _googleSignUpButton(),
                    SizedBox(height: height * .055),
                    _loginAccountLabel(),
                  ],
                )),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
