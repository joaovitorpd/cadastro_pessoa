import 'package:cadastro_pessoa/core/usecase/usecase.dart';
import 'package:cadastro_pessoa/core/utils/typedef.dart';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/domain/repositories/people_repository.dart';
import 'package:equatable/equatable.dart';

class DeletePeopleUsecase extends UsecaseWithParams<void, DeletePeopleParams> {
  DeletePeopleUsecase(this._repository);

  final PeopleRepository _repository;

  @override
  ResultFuture<void> call(params) async => _repository.deletePeople(
        people: params.people,
      );
}

class DeletePeopleParams extends Equatable {
  const DeletePeopleParams({
    required this.people,
  });

  const DeletePeopleParams.empty() : this(people: const PeopleModel.empty());

  final PeopleModel people;

  @override
  List<Object?> get props => [people];
}
