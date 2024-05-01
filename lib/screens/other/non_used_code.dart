// Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
//   if (userData["email"] != _authService.getCurrentUser()!.email) {
//     return MyUserTile(
//       text: "${userData["firstName"]} ${userData["lastName"]}",
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (ctx) => ChatPageScreen(
//             receiverName: "${userData["firstName"]} ${userData["lastName"]}",
//             receiverId: userData['uid'],
//             receiverEmail: userData["email"],
//           ),
//         ),
//       ),
//     );
//   } else {
//     return Container();
//   }
// }

// Widget _buildChatList() {
//   return StreamBuilder(
//     stream: _chatService.getUserStream(),
//     builder: (ctx, snapshot) {
//       // error
//       if (snapshot.hasError) {
//         return const Text("Erreur au chargement des utilisateurs");
//       }

//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const MyLoadingCirle();
//       }

//       if (snapshot.data!.isEmpty) {
//         return const Center(
//           child: Text(
//             "Aucun utilisateur pour l'instant",
//             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
//           ),
//         );
//       }

//       return ListView(
//         children: snapshot.data!
//             .map(
//               (userData) => _buildUserListItem(userData, ctx),
//             )
//             .toList(),
//       );
//     },
//   );
// }
