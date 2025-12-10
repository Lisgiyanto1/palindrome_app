import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palindrome_app/repository/user.repository.dart';

import 'user.event.dart';
import 'user.state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc({required this.repository}) : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await repository.fetchUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
