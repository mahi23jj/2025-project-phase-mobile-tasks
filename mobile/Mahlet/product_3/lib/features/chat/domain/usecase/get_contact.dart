// domain/usecases/get_contacts_usecase.dart
import 'package:dartz/dartz.dart';

import '../../../../core/Error/failure.dart';
import '../Entity/chat_users.dart';

import '../repository/chat_repo.dart';

class GetContactsUseCase {
  final ChatRepository repository;
  GetContactsUseCase(this.repository);

  Future<Either<Failure,List<ContactEntity>>> call() async {
    return await repository.getContacts();
  }
}
