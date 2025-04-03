import 'package:cadastro_pessoa/core/utils/typedef.dart';
import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';

abstract class PeopleRepository {
  const PeopleRepository();

  ResultFuture<PeopleModel> createPeople({
    required PeopleModel people,
  });

  ResultFuture<PeopleModel> updatePeople({
    required PeopleModel people,
  });

  ResultVoid deletePeople({
    required PeopleModel people,
  });

  ResultFuture<List<People>> getPeople();
}
