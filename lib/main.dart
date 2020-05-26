import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/filteredTodo/bloc/filteredtodo_bloc.dart';
import 'package:todo/blocs/todobloc/bloc/todobloc_bloc.dart';
import 'package:todo/data_provider/user_repository.dart';
import 'package:todo/screens/edit_todo.dart';
import 'package:todo/screens/homescreen.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(BlocProvider(
    create: (context) =>
        TodoblocBloc(userRepository: UserRepository())..add(AppStarted()),
    child: TodosApp()
  ));
}

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.red,
        ),
        darkTheme: ThemeData(
          
            snackBarTheme: SnackBarThemeData(
                backgroundColor: Colors.red,
                actionTextColor: Colors.white,
                contentTextStyle: TextStyle(color: Colors.white)),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
            brightness: Brightness.dark,
            primaryColor: Colors.red,
            accentColor: Colors.red,
            toggleableActiveColor: Colors.red),
        routes: {'edit_todo': (context) => EditTodo()},
        home: BlocProvider(
          create: (context) =>
              FilteredtodoBloc(BlocProvider.of<TodoblocBloc>(context)),
          child: HomeScreen(),
        ));
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
