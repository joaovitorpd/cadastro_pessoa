import 'package:cadastro_pessoa/core/usecase/usecase.dart';
import 'package:cadastro_pessoa/core/utils/typedef.dart';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';
import 'package:cadastro_pessoa/src/people/domain/repositories/people_repository.dart';
import 'package:equatable/equatable.dart';

class UpdatePeopleUsecase
    extends UsecaseWithParams<People, UpdatePeopleParams> {
  UpdatePeopleUsecase(this._repository);

  final PeopleRepository _repository;

  @override
  ResultFuture<PeopleModel> call(UpdatePeopleParams params) async =>
      _repository.updatePeople(
        people: params.people,
      );
}

class UpdatePeopleParams extends Equatable {
  const UpdatePeopleParams({
    required this.people,
  });

  const UpdatePeopleParams.empty() : this(people: const PeopleModel.empty());

  final PeopleModel people;

  @override
  List<Object?> get props => [people];
}
