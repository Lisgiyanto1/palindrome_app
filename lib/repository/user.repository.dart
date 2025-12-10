import 'package:palindrome_app/core/dio.client.dart';
import 'package:palindrome_app/model/user.model.dart';

class UserRepository {
  final DioClient dioClient;

  UserRepository({required this.dioClient});

  Future<List<UserModel>> fetchUsers() async {
    final response = await dioClient.dio.get("/users?page=1");

    final List data = response.data["data"];

    return data.map((e) => UserModel.fromJson(e)).toList();
  }
}
