import 'package:cadastro_pessoa/src/people/data/datasources/people_remote_data_source.dart';
import 'package:cadastro_pessoa/src/people/data/datasources/people_remote_data_source_implementation.dart';
import 'package:cadastro_pessoa/src/people/data/repositories/people_repository_implementation.dart';
import 'package:cadastro_pessoa/src/people/domain/repositories/people_repository.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/create_people_usecase.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/delete_people_usecase.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/get_people_usecase.dart';
import 'package:cadastro_pessoa/src/people/domain/usecases/update_people_usecase.dart';
import 'package:cadastro_pessoa/src/people/presentation/cubit/people_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    //App Logic
    ..registerFactory(() => PeopleCubit(
          createPeople: sl(),
          updatedPeople: sl(),
          deletePeople: sl(),
          getPeople: sl(),
        ))

    //Use cases
    ..registerLazySingleton(() => CreatePeopleUsecase(sl()))
    ..registerLazySingleton(() => UpdatePeopleUsecase(sl()))
    ..registerLazySingleton(() => DeletePeopleUsecase(sl()))
    ..registerLazySingleton(() => GetPeopleUsecase(sl()))

    //Repositores
    ..registerLazySingleton<PeopleRepository>(
        () => PeopleRepositoryImplementation(sl()))

    //Data Sources
    ..registerLazySingleton<PeopleRemoteDataSource>(
        () => PeopleRemoteDataSourceImplementation(sl()))

    //External Dependencies
    ..registerLazySingleton(Client.new);
}
