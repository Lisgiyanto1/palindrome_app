import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palindrome_app/bloc/logic.palindrome.cubit.dart';
import 'package:palindrome_app/screen/screenTwoDetail.dart';

class ScreenOneInput extends StatefulWidget {
  const ScreenOneInput({super.key});

  @override
  State<ScreenOneInput> createState() => _ScreenOneInputState();
}

class _ScreenOneInputState extends State<ScreenOneInput> {
  final _nameController = TextEditingController();
  final _palindromeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _palindromeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1B79B0),
                  Color(0xFF3DBFD5),
                  Color(0xFF6C9CD0),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  const Color.fromARGB(
                    255,
                    178,
                    235,
                    226,
                  ).withOpacity(0.60), // cyan kehijauan
                  const Color(0xFF7CA6D8).withOpacity(0.55),
                  const Color(0xFFB7AEE9).withOpacity(0.80),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  SizedBox(
                    width: 120,
                    height: 120,
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Add Image')),
                        );
                      },
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white.withOpacity(0.25),
                        child: const Icon(
                          Icons.person_add_alt_1,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  TextField(
                    controller: _nameController,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: "Name",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  TextField(
                    controller: _palindromeController,
                    decoration: InputDecoration(
                      hintText: "Palindrome",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25587E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        final text = _palindromeController.text;
                        context.read<PalindromeCubit>().checkDataInput(text);
                      },
                      child: const Text(
                        "CHECK",
                        style: TextStyle(
                          letterSpacing: 1.2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E4F6E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        final nameText = _nameController.text.trim();
                        if (nameText.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Name is required')),
                          );
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ScreenTwoDetail(),
                          ),
                        );
                      },
                      child: const Text(
                        "NEXT",
                        style: TextStyle(
                          letterSpacing: 1.2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  BlocBuilder<PalindromeCubit, PalindromeState>(
                    builder: (context, state) {
                      if (state.isChecking) {
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        );
                      }

                      if (state.isPalindrome == null) {
                        return const SizedBox.shrink();
                      }

                      return Text(
                        state.msg,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: state.isPalindrome!
                              ? Colors.green[900]
                              : Colors.red[900],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
