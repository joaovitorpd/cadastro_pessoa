import 'package:cadastro_pessoa/core/usecase/usecase.dart';
import 'package:cadastro_pessoa/core/utils/typedef.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';
import 'package:cadastro_pessoa/src/people/domain/repositories/people_repository.dart';

class GetPeopleUsecase extends UsecaseWithoutParams<List<People>> {
  const GetPeopleUsecase(this._repository);

  final PeopleRepository _repository;

  @override
  ResultFuture<List<People>> call() async => _repository.getPeople();
}
