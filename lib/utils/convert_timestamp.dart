import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String convertTimestamp(Timestamp timestamp) {
  // Convertir le Timestamp en DateTime
  DateTime date = timestamp.toDate();

  // Formater la DateTime en chaîne au format HH:mm
  String formattedTime = DateFormat('HH:mm').format(date);

  return formattedTime;
}
