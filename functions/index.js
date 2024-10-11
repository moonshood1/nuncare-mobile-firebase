const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendNotificationmessage = functions.firestore
  .document("/Chat_rooms/{chatRoomId}/messages/{messageId}")
  .onCreate(async (snapshot, context) => {
    const message = snapshot.data();

    try {
      const receiverDoc = await admin
        .firestore()
        .collection("Users")
        .doc(message.receiverId)
        .get();

      const receiverData = receiverDoc.data();
      const token = receiverData.fcmToken;

      if (!token) {
        console.log("No token for user, cannor send notification");
        return;
      }

      const messagePayload = {
        token: token,
        notification: {
          title: message.senderEmail,
          body: message.message,
        },
        android: {
          notification: {
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
          },
        },
        apns: {
          payload: {
            aps: {
              category: "FLUTTER_NOTIFICATION_CLICK",
            },
          },
        },
      };

      const response = await admin.messaging().send(messagePayload);
      console.log("Notification sent successfully :", response);

      return response;
    } catch (error) {
      console.error("Detailed error : ", error);

      if (error.code && error.message) {
        console.log("Error code : ", error.code);
        console.log("Error message : ", error.message);
      }

      throw new Error("Failed to send notification");
    }
  });
