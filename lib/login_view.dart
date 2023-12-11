import 'package:flutter/material.dart';
import 'package:agilizadiarista/cadastro_page.dart';
import 'package:agilizadiarista/controller/login_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:agilizadiarista/homePage_Cliente.dart';
import 'package:agilizadiarista/homePage_Parceiro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agilizadiarista/controller/homeParceiro_controller.dart';
import 'package:agilizadiarista/Model/homeParceiro_model.dart';

class LoginView extends StatelessWidget {
  final LoginController _controller = LoginController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0), // Ajuste o raio aqui
                  image: const DecorationImage(
                    image: AssetImage('assets/imagens/logoNew.png'),
                    fit: BoxFit.cover, // Isto garante que a imagem cubra toda a área do Container
                  ),
                ),
                width: 100.0,
                height: 100.0,
              ),
              const SizedBox(height: 20.0),
              //LOGIN GOOGLE
              ElevatedButton.icon(
                icon: const FaIcon(FontAwesomeIcons.google, color: Colors.white),
                label: const Text('Login com Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Cor do Google
                  foregroundColor: Colors.white, //cor secundária
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onPressed: () async {
                  String? userType = await _controller.signInWithGoogle();
                  if (userType == 'first_time') {   //verifica tipo de usuario ou faz cadastro
                    User? currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => CadastroPage(currentUser: currentUser)),
                      );
                    }
                  } else if (userType == 'Parceiro') {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    HomeParceiroModel model = HomeParceiroModel(nomeParceiro: "Nome");
                    HomeParceiroController controller = HomeParceiroController(auth: auth, model: model);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ParceiroHomePage(controller: controller))
                    );
                        } else if (userType == 'Cliente') {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ClienteHomePage()));
                  } else {
                    // Tratar falha no login ou outros casos
                    print('ALOOU');
                    User? currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => CadastroPage(currentUser: currentUser)),
                      );
                    } else {
                      print("User is nil!");
                      print(userType ?? "nil");
                      print(FirebaseAuth.instance.currentUser);
                    }
                  }
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}