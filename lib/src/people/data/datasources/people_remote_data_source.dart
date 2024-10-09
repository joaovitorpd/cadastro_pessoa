import 'package:cadastro_pessoa/src/people/data/models/people_model.dart';
import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';

abstract class PeopleRemoteDataSource {
  Future<PeopleModel> createPeople({
    required PeopleModel people,
    /* required String? name,
    required String? email,
    required String? details, */
  });

  Future<PeopleModel> updatePeople({
    required PeopleModel people,
    /* required String? id,
    required String? name,
    required String? email,
    required String? details, */
  });

  Future<void> deletePeople({
    required People people,
    /* required String? id, */
  });

  //Never return Entities, in DataSources. Return Models.
  Future<List<PeopleModel>> getPeople();
}
