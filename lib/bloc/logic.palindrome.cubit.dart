import 'package:flutter_bloc/flutter_bloc.dart';

class PalindromeState {
  final bool isChecking;
  final bool? isPalindrome;
  final String msg;

  PalindromeState({this.isChecking = false, this.isPalindrome, this.msg = ''});
  PalindromeState copyCheckFrom({
    bool? isChecking,
    bool? isPalindrome,
    String? msg,
  }) {
    return PalindromeState(
      isChecking: isChecking ?? this.isChecking,
      isPalindrome: isPalindrome ?? this.isPalindrome,
      msg: msg ?? this.msg,
    );
  }
}

class PalindromeCubit extends Cubit<PalindromeState> {
  PalindromeCubit() : super(PalindromeState());

  void checkDataInput(String input) {
    emit(state.copyCheckFrom(isChecking: true, msg: ''));
    final normalisasi = input.toLowerCase().replaceAll(
      RegExp(r'[^a-z0-9]'),
      '',
    );
    final reverse = normalisasi.split('').reversed.join('');
    final palindrome = normalisasi.isNotEmpty && normalisasi == reverse;
    emit(
      state.copyCheckFrom(
        isChecking: false,
        isPalindrome: palindrome,
        msg: palindrome ? 'Data is Palindrome' : 'Data Not Palindrome',
      ),
    );
  }

  void resetState() => emit(PalindromeState());
}
