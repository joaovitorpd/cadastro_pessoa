import 'package:cadastro_pessoa/models/people.dart';
import 'package:cadastro_pessoa/people_api_client.dart';
import 'package:mobx/mobx.dart';
part 'people_api_controller.g.dart';

class PeopleApiController = _PeopleApiControllerBase with _$PeopleApiController;

abstract class _PeopleApiControllerBase with Store {
  final PeopleApiClient pessoaApiClient = PeopleApiClient();

  @observable
  People people = People.empty();

  @action
  selectedPeople(People selectecPeople) => people = selectecPeople;

  @observable
  late ObservableList<People> peopleList =
      ObservableList<People>.of([]).asObservable();

  @observable
  late ObservableFuture<List<People>> peopleFutureList =
      ObservableFuture(pessoaApiClient.fetchPessoas());

  @action
  Future<People> createPeople(People selectedPeople) {
    var newPeople = pessoaApiClient.createPessoa(pessoa: selectedPeople);
    newPeople.then((x) {
      peopleList.add(x);
    });
    return newPeople;
  }

  @action
  Future<People> updatePeople(People selectedPeople) {
    var updatedPeople = pessoaApiClient.updatePessoa(pessoa: selectedPeople);
    peopleList[peopleList.indexWhere((x) => x.id == selectedPeople.id)] =
        selectedPeople;
    return updatedPeople;
  }

  @action
  Future deletePeople(People selectedPeople) {
    var deletePeople = pessoaApiClient.deletePessoa(pessoa: selectedPeople);
    peopleList.removeWhere((x) => x.id == selectedPeople.id);
    return deletePeople;
  }

  @action
  void getPeople() {
    peopleFutureList.then((value) {
      peopleList = ObservableList.of(value);
    });
  }

  dispose() {}
}
