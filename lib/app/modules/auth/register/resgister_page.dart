import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/theme_extensions.dart';
import '../../../core/validators/validators.dart';
import '../../../core/widget/todo_list_field.dart';
import '../../../core/widget/todo_list_logo.dart';
import 'register_controller.dart';

class ResgisterPage extends StatefulWidget {
  const ResgisterPage({super.key});

  @override
  State<ResgisterPage> createState() => _ResgisterPageState();
}

class _ResgisterPageState extends State<ResgisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmpasswordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmpasswordEC.dispose();
    // context.read()<RegisterController>().removeListener(({}));
    super.dispose();
  }

  v() {
    context.read()<RegisterController>().addListener(() {
      final controller = context.read<RegisterController>();
      var success = controller.success;
      var error = controller.error;
      if (success) {
        Navigator.of(context).pop();
      } else if (error != null && error.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    v();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Todo List",
              style: TextStyle(
                fontSize: 10,
                color: context.primaryColor,
              ),
            ),
            Text(
              "Cadastro",
              style: TextStyle(
                fontSize: 15,
                color: context.primaryColor,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.arrow_back_ios_outlined),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * .5,
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: TodoListLogo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TodoListField(
                      label: "E-mail",
                      controller: _emailEC,
                      validator: Validatorless.multiple([
                        Validatorless.required(
                          "E-mail obrigatorio",
                        ),
                        Validatorless.email("E-mail invalido"),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    TodoListField(
                      label: "Senha",
                      obscureText: true,
                      controller: _passwordEC,
                      validator: Validatorless.multiple([
                        Validatorless.required("Senha obrigatorio"),
                        Validatorless.min(
                            6, "Senha deve ter pelo menos 6 caracteres"),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    TodoListField(
                      label: "Confimar Senha",
                      obscureText: true,
                      controller: _confirmpasswordEC,
                      validator: Validatorless.multiple([
                        Validatorless.required("Senha obrigatorio"),
                        Validators.compare(
                            _passwordEC, "Senha diferente de confirma senha"),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          final formValid =
                              _formKey.currentState?.validate() ?? false;
                          if (formValid) {
                            context.read<RegisterController>().registerUser(
                                  _emailEC.text,
                                  _passwordEC.text,
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("salvar"),
                        ),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
