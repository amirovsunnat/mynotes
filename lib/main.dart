import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/screens/notes/create_update_note.dart';
import 'package:mynotes/services/auth/auth_service.dart';

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/screens/auth_screen.dart';
import 'package:mynotes/screens/email_verification_screen.dart';
import 'package:mynotes/screens/notes/notes_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyNotesApp(),
  );
}

class MyNotesApp extends StatelessWidget {
  const MyNotesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: Colors.green,
            ),
      ),
      routes: {
        authenticationRoute: (context) => const AuthenticationScreen(),
        emailVerificationRoute: (context) => const EmailVerificationScreen(),
        notesRoute: (context) => const NotesScreen(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteScreen(),
      },
      // home: FutureBuilder(
      //   future: AuthService.firebase().initialize(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       final user = AuthService.firebase().currentUser;
      //       if (user != null) {
      //         if (user.isEmailVerified) {
      //           return const NotesScreen();
      //         }
      //       }
      //       return const AuthenticationScreen();
      //     } else {
      //       return Container(
      //         width: double.infinity,
      //         height: double.infinity,
      //         decoration: const BoxDecoration(color: Colors.white),
      //         child: const Center(
      //           child: CircularProgressIndicator(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      home: CounterApp(),
    );
  }
}

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Bloc test"),
        ),
        body: BlocConsumer<CounterBloc, CounterState>(
          listener: (context, state) {
            _controller.clear();
          },
          builder: (context, state) {
            final inValidValue =
                (state is CounterStateInValidNumber) ? state.invalidInput : "";
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Current value: ${state.value}",
                    style: const TextStyle(fontSize: 30),
                  ),
                  Visibility(
                    visible: state is CounterStateInValidNumber,
                    child: Text(
                      "Invalid value: $inValidValue",
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Enter a number here",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.read<CounterBloc>().add(
                                DecrementCounterEvent(_controller.text),
                              );
                        },
                        child: const Text(
                          "-",
                          style: TextStyle(fontSize: 100),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<CounterBloc>().add(
                                IncrementCounterEvent(_controller.text),
                              );
                        },
                        child: const Text(
                          "+",
                          style: TextStyle(fontSize: 70),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

abstract class CounterState {
  final int value;

  CounterState(this.value);
}

class CounterStateValidNumber extends CounterState {
  CounterStateValidNumber(int value) : super(value);
}

class CounterStateInValidNumber extends CounterState {
  final String invalidInput;

  CounterStateInValidNumber(
      {required this.invalidInput, required int previousValue})
      : super(previousValue);
}

abstract class CounterEvent {
  final String value;
  const CounterEvent(this.value);
}

class IncrementCounterEvent extends CounterEvent {
  const IncrementCounterEvent(String value) : super(value);
}

class DecrementCounterEvent extends CounterEvent {
  const DecrementCounterEvent(String value) : super(value);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterStateValidNumber(0)) {
    on<IncrementCounterEvent>(
      (event, emit) {
        final integer = int.tryParse(event.value);
        if (integer == null) {
          emit(
            CounterStateInValidNumber(
                invalidInput: event.value, previousValue: state.value),
          );
        } else {
          emit(
            CounterStateValidNumber(state.value + integer),
          );
        }
      },
    );
    on<DecrementCounterEvent>(
      (event, emit) {
        final integer = int.tryParse(event.value);
        if (integer == null) {
          emit(
            CounterStateInValidNumber(
                invalidInput: event.value, previousValue: state.value),
          );
        } else {
          emit(
            CounterStateValidNumber(state.value - integer),
          );
        }
      },
    );
  }
}
