import '../../domain/Entity/user_entiry.dart';
import '../model/user_model.dart';

abstract class RemoteUserDataSource {
  Future<Map<String, dynamic>> signIn(
    String email,
    String password
    );
  Future<UserModel> signUp(String email, String password , String name);
  Future<void> signOut();
  Future<String> getCurrentUserId();
}
