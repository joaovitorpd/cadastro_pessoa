import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';

abstract class PeopleRemoteDataSource {
  Future<PeopleModel> createPeople({
    required PeopleModel people,
  });

  Future<PeopleModel> updatePeople({
    required PeopleModel people,
  });

  Future<void> deletePeople({
    required People people,
  });

  //Never return Entities, in DataSources. Return Models.
  Future<List<PeopleModel>> getPeople();
}
