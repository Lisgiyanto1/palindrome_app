import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:palindrome_app/bloc/logic.palindrome.cubit.dart';
import 'package:palindrome_app/bloc/manage.selected.user.cubit.dart';
import 'package:palindrome_app/bloc/users/user.bloc.dart';
import 'package:palindrome_app/core/dio.client.dart';
import 'package:palindrome_app/repository/user.repository.dart';
import 'package:palindrome_app/screen/screenOneInput.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final apiKey = dotenv.env['API_KEY'] ?? '';
  final dioClient = DioClient(apiKey);

  final userRepository = UserRepository(dioClient: dioClient);
  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({required this.userRepository, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(repository: userRepository),
        ),
        BlocProvider<ManageSelectedUserCubit>(
          create: (_) => ManageSelectedUserCubit(),
        ),
        BlocProvider<PalindromeCubit>(create: (_) => PalindromeCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Palindrome App",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ScreenOneInput(),
      ),
    );
  }
}
