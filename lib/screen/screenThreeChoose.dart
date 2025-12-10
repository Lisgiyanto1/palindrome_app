import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palindrome_app/bloc/manage.selected.user.cubit.dart';
import 'package:palindrome_app/bloc/users/user.bloc.dart';
import 'package:palindrome_app/bloc/users/user.event.dart';
import 'package:palindrome_app/bloc/users/user.state.dart';

class ScreenThreeChoose extends StatefulWidget {
  const ScreenThreeChoose({super.key});

  @override
  State<ScreenThreeChoose> createState() => _ScreenThreeChooseState();
}

class _ScreenThreeChooseState extends State<ScreenThreeChoose> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Third Screen",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.chevron_left, color: Colors.black),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: Colors.grey),
        ),
      ),

      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserError) {
            return Center(child: Text(state.message));
          }

          if (state is UserLoaded) {
            final users = state.users;

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: users.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: Color(0xFFE5E5E5)),
              itemBuilder: (context, index) {
                final user = users[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ), 
                  child: GestureDetector(
                    onTap: () {
                      context.read<ManageSelectedUserCubit>().setUser(user);
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 27,
                          backgroundImage: NetworkImage(user.avatar),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.fullName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF121212),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              user.email.toLowerCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF838383),
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
