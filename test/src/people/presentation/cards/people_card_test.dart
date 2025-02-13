import 'package:cadastro_pessoa/src/people/domain/entities/people.dart';
import 'package:cadastro_pessoa/src/people/presentation/cards/people_card.dart';
import 'package:cadastro_pessoa/src/people/presentation/cubit/people_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPeopleCubit extends MockCubit<PeopleState> implements PeopleCubit {}

void main() {
  late People person;
  late MockPeopleCubit mockPeopleCubit;

  setUp(() {
    person = const People(
      id: '1',
      name: 'João Vitor',
      email: 'joao@example.com',
      details: 'Detalhes sobre João Vitor',
    );
    mockPeopleCubit = MockPeopleCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<PeopleCubit>.value(
          value: mockPeopleCubit,
          child: PeopleCard(person: person),
        ),
      ),
    );
  }

  testWidgets('Exibe indicador de progresso quando estado é LoadingState',
      (WidgetTester tester) async {
    when(() => mockPeopleCubit.state).thenReturn(LoadingState());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Exibe informações da pessoa quando estado é PeopleListState',
      (WidgetTester tester) async {
    when(() => mockPeopleCubit.state).thenReturn(PeopleListState([person]));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('João Vitor'), findsOneWidget);
    expect(find.text('Detalhes sobre João Vitor'), findsOneWidget);
  });

  testWidgets('Exibe mensagem de erro quando estado é PeopleError',
      (WidgetTester tester) async {
    when(() => mockPeopleCubit.state)
        .thenReturn(PeopleError(message: 'Erro ao carregar dados'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Pessoa não encontrada'), findsOneWidget);
  });

  testWidgets('Exibe mensagem "Sem nome registrado" quando nome é nulo',
      (WidgetTester tester) async {
    person = const People(
      id: '1',
      name: null,
      email: 'joao@example.com',
      details: 'Detalhes sobre João Vitor',
    );
    when(() => mockPeopleCubit.state).thenReturn(PeopleListState([person]));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Sem nome registrado'), findsOneWidget);
  });

  testWidgets(
      'Exibe mensagem "Sem detalhe registrado" quando detalhes são nulos',
      (WidgetTester tester) async {
    person = const People(
      id: '1',
      name: 'João Vitor',
      email: 'joao@example.com',
      details: null,
    );
    when(() => mockPeopleCubit.state).thenReturn(PeopleListState([person]));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Sem detalhe registrado'), findsOneWidget);
  });

  testWidgets(
      'Muda de LoadingState para PeopleListState e exibe informações da pessoa',
      (WidgetTester tester) async {
    whenListen(
      mockPeopleCubit,
      Stream.fromIterable([
        LoadingState(),
        PeopleListState([person])
      ]),
      initialState: LoadingState(),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Rebuilds the widget after the state change

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('João Vitor'), findsOneWidget);
    expect(find.text('Detalhes sobre João Vitor'), findsOneWidget);
  });
}
