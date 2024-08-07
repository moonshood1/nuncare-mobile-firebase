String generateChatID({required String uid1, required String uid2}) {
  List uids = [uid1, uid2];

  String chatID = uids.fold("", (id, uid) => "$id$uid");
  return chatID;
}
