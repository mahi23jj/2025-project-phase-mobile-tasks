import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/Error/exception.dart';
import '../../../../core/Error/failure.dart';
import '../../domain/Entity/user_entiry.dart';
import '../model/user_model.dart';
import 'remote_data_source.dart';

class RemoteUserDataSourceImp extends RemoteUserDataSource {
  final http.Client client;

  RemoteUserDataSourceImp({required this.client});
  final baseUrl = 'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v2';

  @override
  Future<Map<String, dynamic>> signIn(
    String email,
    String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
     final userJson = jsonDecode(response.body);
    print('📦 Login response: $userJson');

    // Ensure token exists
    if (userJson['data']['access_token'] == null) {
      throw Exception('No token in login response');
    } else{
      print(userJson['data']['access_token']);
    }

    return userJson; // Return full decoded map
    } else {
      throw NetworkException(message: 'Login failed: ${response.body}');
    }
  }

  @override
  Future<UserModel> signUp(String name, String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    {
      throw NetworkException(message: 'Signup failed: ${response.body}');
    }
  }

  @override
  Future<void> signOut() async {
    final response = await client.post(
      Uri.parse('$baseUrl/logout'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw NetworkException(message: 'Sign out failed: ${response.body}');
    }
  }

  @override
  Future<String> getCurrentUserId() async {
    final response = await client.get(
      Uri.parse('$baseUrl/me'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['id'] ?? '';
    } else {
      throw NetworkException(
        message: 'Failed to get current user ID: ${response.body}',
      );
    }
  }
}


// check this and do local one 
