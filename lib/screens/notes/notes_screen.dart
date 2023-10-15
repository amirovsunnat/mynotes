import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/screens/notes/notes_list.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/bloc/auht_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/cloud/cloud_note.dart';
import 'package:mynotes/services/cloud/firebase_cloud_storage.dart';

import '../../utilities/dialogs/sign_out_dialog.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        backgroundColor: const Color.fromRGBO(43, 79, 121, 1),
        actions: [
          PopupMenuButton<MenuActions>(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuActions>(
                  value: MenuActions.signout,
                  child: Text("Logout"),
                ),
              ];
            },
            onSelected: (value) async {
              switch (value) {
                case (MenuActions.signout):
                  final isSigningOut = await showSignOutDialog(context);
                  if (isSigningOut) {
                    // ignore: use_build_context_synchronously
                    context.read<AuthBloc>().add(
                          const AuthEventLogOut(),
                        );
                  }
              }
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _notesService.allNotes(ownerUserId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allNotes = snapshot.data as Iterable<CloudNote>;
                return Column(
                  children: [
                    Expanded(
                      child: NotesListView(
                        onTap: (note) {
                          Navigator.of(context).pushNamed(
                              createOrUpdateNoteRoute,
                              arguments: note);
                        },
                        notes: allNotes,
                        onDeleteNote: (note) async {
                          await _notesService.deleteNote(
                              documentId: note.documentId);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
      begin: AlignmentDirectional.centerStart,
      end: Alignment.centerRight,
      colors: [
        Color.fromRGBO(29, 45, 68, 1), 
        Color.fromRGBO(43, 79, 121, 1), 
        Color.fromRGBO(86, 132, 186, 1), 
        Color.fromRGBO(43, 79, 121, 1), 
        Color.fromRGBO(29, 45, 68, 1),  
      ],
    ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                createOrUpdateNoteRoute,
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
