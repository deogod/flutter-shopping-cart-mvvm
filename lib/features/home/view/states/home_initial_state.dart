import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/features/home/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../architecture/achitecture.dart';

class HomeInitialState extends StatelessWidget {
  const HomeInitialState({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nomeController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: nomeController,
            decoration: const InputDecoration(labelText: 'Nome'),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<HomeViewModel>().saveUser(User(
                    name: nomeController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  ));
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
