// CONSTRSUCTION DES BULES D'UTILISATEURS POUR ENVOI DE MESSAGE
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


// RECUPERATION DE LA LISTE DES UTILISATEURS DEPUIS FIREBASE

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



// RECUPERATION INFORMATIONS PAGE PROFIL DEPUIS FIREBASE

        // StreamBuilder<DocumentSnapshot>(
        //   stream: _userService.getUserInformations(currentUser.uid),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       final userData = snapshot.data!.data() as Map<String, dynamic>;

        //       return 
            // } else if (snapshot.hasError) {
            //   return Center(
            //     child: Text(snapshot.error.toString()),
            //   );
            // } else {
            //   return const MyLoadingCirle();
            // }


// MODIFICATION DE PROFILE CHAMP PAR CHAMP
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child:
            //       ),
            //       IconButton(
            //         onPressed: () {
            //           editProfile(
            //             context,
            //             'firstName',
            //             _firstNameController.text.trim(),
            //           );
            //         },
            //         icon: Icon(
            //           Icons.edit,
            //           color: Theme.of(context).colorScheme.primary,
            //         ),
            //       )
            //     ],
            //   ),
            // ),

