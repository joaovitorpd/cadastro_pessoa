import 'package:cadastro_pessoa/core/usecase/usecase.dart';
import 'package:cadastro_pessoa/core/utils/typedef.dart';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';
import 'package:cadastro_pessoa/src/people/domain/repositories/people_repository.dart';
import 'package:equatable/equatable.dart';

class CreatePeopleUsecase
    extends UsecaseWithParams<People, CreatePeopleParams> {
  CreatePeopleUsecase(this._repository);

  final PeopleRepository _repository;

  @override
  ResultFuture<PeopleModel> call(params) async => _repository.createPeople(
        people: params.people,
      );
}

class CreatePeopleParams extends Equatable {
  const CreatePeopleParams({
    required this.people,
  });

  const CreatePeopleParams.empty() : this(people: const PeopleModel.empty());

  final PeopleModel people;

  @override
  List<Object?> get props => [people];
}
