import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frotalog_gestor_v2/app/features/login/presenter/bloc/login_controller.dart';
import 'package:frotalog_gestor_v2/app/features/login/presenter/bloc/login_state.dart';
import 'package:frotalog_gestor_v2/app/shared/components/custom_error_popup.dart';
import 'package:frotalog_gestor_v2/app/shared/components/custom_load_overlay.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isChecked = false;
  bool isUserFieldFocused = false;
  bool isPasswordFieldFocused = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginController, LoginState>(
      builder: (context, state) {
        // Layout padrão da tela de login
        final loginScreen = Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                top: 24.0,
                bottom: MediaQuery.of(context).viewInsets.bottom, // Ajusta o espaçamento inferior com base no teclado
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  Center(
                    child: Image.asset(
                      'assets/frotalog_logo_1.png',
                      width: 150,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Focus(
                    onFocusChange: (hasFocus) {
                      setState(() {
                        isUserFieldFocused = hasFocus;
                      });
                    },
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Usuário',
                        prefixIcon: Icon(
                          Icons.person,
                          color: isUserFieldFocused ? Colors.blue : Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        floatingLabelStyle: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Focus(
                    onFocusChange: (hasFocus) {
                      setState(() {
                        isPasswordFieldFocused = hasFocus;
                      });
                    },
                    child: TextField(
                      controller: _passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: isPasswordFieldFocused ? Colors.blue : Colors.grey,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: isPasswordVisible
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        floatingLabelStyle: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                        activeColor: isChecked ? const Color(0xFF333333) : Colors.grey,
                        checkColor: Colors.white,
                        side: BorderSide(
                          color: isChecked ? Colors.black : Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      Text(
                        'Lembrar informações',
                        style: TextStyle(
                            color: isChecked ? Colors.black : Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final username = _usernameController.text;
                        final password = _passwordController.text;
                        context.read<LoginController>().login(username, password);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Acessar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // TO DO: Navegar para a tela de recuperação de senha
                    },
                    child: const Text(
                      'Recuperar minha senha',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        // Exibe o indicador de carregamento sobre a tela de login
        if (state is LoginLoading) {
          return Stack(
            children: [
              loginScreen, // Tela de login no fundo
              CustomLoadingOverlay()
            ],
          );
        }

        if (state is LoginErrorState) {
          final loginController = context.read<LoginController>();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomErrorPopup(
                title: "Erro de Login", 
                content: "Usuário ou senha inválidos", 
                buttonText: "Tentar novamente", 
                onPressed: () {
                  Navigator.of(context).pop();
                  loginController.handleErrorAcknowledged();                
                  }
                );
              },
            );
          });
        }

        if (state is LoginSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/home');
          });
        }

        return loginScreen;
      },
    );
  }
}