import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palindrome_app/model/user.model.dart';

class SelectedUserState extends Equatable {
  final UserModel? user;

  const SelectedUserState({this.user});

  SelectedUserState copyWith({UserModel? user}) {
    return SelectedUserState(user: user ?? this.user);
  }

  @override
  List<Object?> get props => [user];
}

class ManageSelectedUserCubit extends Cubit<SelectedUserState> {
  ManageSelectedUserCubit() : super(const SelectedUserState());

  void setUser(UserModel user) {
    emit(state.copyWith(user: user));
  }

  void clear() {
    emit(const SelectedUserState());
  }
}
