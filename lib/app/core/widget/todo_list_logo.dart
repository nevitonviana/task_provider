import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../ui/theme_extensions.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/logo.png"),
        Text(
          "Todo List",
          style: context.textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          child: Form(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text("Esqueceu sua senha?"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Login"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xfff0f3f7),
              border: Border(
                top: BorderSide(
                  width: 2,
                  color: Colors.grey.withAlpha(50),
                ),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 30),
                SignInButton(
                  Buttons.Google,
                  text: "Continue com o Google",
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  onPressed: () {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Não tem Conta?"),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Cadastre-se"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
