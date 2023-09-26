// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:mynotes/services/crud/notes_service.dart';

// import '../../utilities/dialogs/delete_dialog.dart';

// typedef NoteCallBack = void Function(DatabaseNote note);
// final currentTime = DateTime.now();
// final formattedDate = DateFormat('MMMM dd, yyyy').format(currentTime);

// class NotesListView extends StatelessWidget {
//   final List<DatabaseNote> notes;
//   final NoteCallBack onDeleteNote;
//   final NoteCallBack onTap;

//   const NotesListView(
//       {super.key,
//       required this.notes,
//       required this.onDeleteNote,
//       required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: notes.length,
//       itemBuilder: (context, index) {
//         final note = notes[index];
//         return Card(
//           elevation: 2,
//           margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           child: ListTile(
//             onTap: () {
//               onTap(note);
//             },
//             contentPadding: const EdgeInsets.all(16),
//             title: Text(
//               note.text,
//               maxLines: 1,
//               softWrap: true,
//               overflow: TextOverflow.ellipsis,
//               style: GoogleFonts.poppins(
//                   fontSize: 14, fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(
//               'Created at: $formattedDate', // Format the current time
//               style: GoogleFonts.poppins(fontSize: 10),
//             ),
//             trailing: IconButton(
//               icon: const Icon(
//                 Icons.delete,
//                 color: Colors.indigo,
//               ),
//               onPressed: () async {
//                 final shouldDelete = await showDeleteDialog(context);
//                 if (shouldDelete) {
//                   onDeleteNote(note);
//                 }
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mynotes/services/crud/notes_service.dart';

import '../../utilities/dialogs/delete_dialog.dart';

typedef NoteCallBack = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  final List<DatabaseNote> notes;
  final NoteCallBack onDeleteNote;
  final NoteCallBack onTap;

  const NotesListView({
    Key? key,
    required this.notes,
    required this.onDeleteNote,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        final createdDateTime = DateTime.fromMillisecondsSinceEpoch(
            note.createdAt); // Convert to DateTime

        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            onTap: () {
              onTap(note);
            },
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              note.text,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              DateFormat('MMMM d hh:mm a').format(
                DateTime.fromMillisecondsSinceEpoch(note.createdAt),
              ),
              style: GoogleFonts.poppins(
                fontSize: 10,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.indigo,
              ),
              onPressed: () async {
                final shouldDelete = await showDeleteDialog(context);
                if (shouldDelete) {
                  onDeleteNote(note);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
