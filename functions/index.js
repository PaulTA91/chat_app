const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.myfunction = functions.firestore
  .document("chat/{message}")
  .onCreate((change, context) => {
    return admin.messaging().sendToTopic("chat", {
      notification: {
        title: change.data().username,
        body: change.data().text,
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    });
  });
