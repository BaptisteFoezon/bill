import 'package:bill/Models/user_app.dart';
import 'package:bill/Views/widgets/loading.dart';
import 'package:bill/Views/widgets/responsive.dart';
import 'package:bill/services/database.dart';
import 'package:bill/services/service.dart';
import 'package:flutter/material.dart';

import 'commons/inputstyle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool _passwordVisible = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool showSignIn = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      error = '';
      _formKey.currentState!.reset();
      emailController.text = '';
      passwordController.text = '';
      nameController.text = '';
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Row(
          children: [
            isDesktop
                ? SizedBox(
                    width: (MediaQuery.of(context).size.width - 600) / 2,
                    height: 10,
                  )
                : const SizedBox.shrink(),
            SizedBox(
              width: isDesktop ? 600 : MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: showSignIn
                        ? MediaQuery.of(context).size.height * 0.40
                        : MediaQuery.of(context).size.height * 0.40,
                    width: 600,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                  ),
                  Text(
                    showSignIn
                        ? "Bonjour ravis de vous revoir "
                        : "Bonjour, nous smme heureux de vous compter bientot parmis nous",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          showSignIn
                              ? const SizedBox.shrink()
                              : TextFormField(
                                  controller: nameController,
                                  validator: (value) => value!.isEmpty
                                      ? "Entrer votre nom "
                                      : null,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: textinputdecoration.copyWith(
                                      hintText: 'Nom'),
                                ),
                          showSignIn
                              ? const SizedBox.shrink()
                              : TextFormField(
                                  controller: phoneController,
                                  validator: (value) =>
                                      value!.isEmpty ? "Numero" : null,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: textinputdecoration.copyWith(
                                      hintText: 'numéro de tel'),
                                ),
                          TextFormField(
                            controller: emailController,
                            validator: (value) =>
                                value!.isEmpty ? "Entrer votre email" : null,
                            style: const TextStyle(color: Colors.white),
                            decoration:
                                textinputdecoration.copyWith(hintText: 'email'),
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: _passwordVisible,
                            validator: (value) => value!.length < 6
                                ? "Entrer votre mot de passe"
                                : null,
                            style: const TextStyle(color: Colors.white),
                            decoration: textinputdecoration.copyWith(
                              hintText: 'mot de passe',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() == true) {
                                setState(() {
                                  loading = true;
                                });
                                var password = passwordController.value.text;
                                var email = emailController.value.text;
                                var name = nameController.value.text;
                                var phone = phoneController.value.text;

                                showSignIn
                                    ? signIn(email, password, context)
                                    : register(email, password, name, phone);
                              }
                            },
                            child:
                                Text(showSignIn ? 'Connection' : 'Inscription'),
                          ),
                          TextButton(
                              onPressed: () => toggleView(),
                              child: Text(showSignIn
                                  ? 'Pas encore inscrit ? cliquez ici'
                                  : 'connexion'))
                        ],
                      ),
                    ),
                  ),
                  Text(error),
                ],
              ),
            ),
            isDesktop
                ? SizedBox(
                    width: (MediaQuery.of(context).size.width - 600) / 2,
                    height: 10,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
