// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:nuncare_mobile_firebase/models/message_model.dart';
// import 'package:nuncare_mobile_firebase/screens/message/chat_page_screen.dart';
// import 'package:nuncare_mobile_firebase/services/auth_service.dart';

// class MyChatTile extends StatelessWidget {
//   const MyChatTile({super.key, required this.message});

//   final Message message;

//   @override
//   Widget build(BuildContext context) {
//     final AuthService _auth = AuthService();
//     String currentUserId = _auth.getCurrentUser()!.uid;

//     DateTime inputDate = DateTime.parse(message.messageTime!);

//     String formattedDate = DateFormat('dd-MM-yyyy - HH:mm').format(inputDate);

//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (ctx) => ChatPageScreen(
//               receiverId: message.receiverId,
//               receiverName: message.receiverName,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.background,
//           borderRadius: BorderRadius.circular(10.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 const Icon(Icons.person),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   currentUserId == message.receiverId
//                       ? message.receiverName
//                       : message.senderEmail,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   message.message,
//                   style: const TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.w300,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   formattedDate,
//                   style: const TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.w300,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
