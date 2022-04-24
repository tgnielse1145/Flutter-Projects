/* eslint-disable max-len */
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);
admin.firestore().settings({ignoreUndefinedProperties: true});

exports.helloWorld = functions.database.ref("notification/status").onUpdate(async (evt) => {
  const payload = {
    notification: {
      title: "VISITOR ALERT",
      body: "Someone is standing infront of your door",
      badge: "1",
      sound: "default",
    },
  };

  const allToken = await admin.database().ref("fcm-token").once("value");
  if (allToken.val() && evt.after.val() == "yes") {
    console.log("token available");
    const token = Object.keys(allToken.val());
    return admin.messaging().sendToDevice(token, payload);
  } else {
    console.log("No token available");
  }
});
// exports.myFunction=functions.firestore.document("messages/{message}").onCreate((snapshot, context)=>{
//   return admin.messaging().sendToTopic("chat", {
//     notification: {
//       title: snapshot.data().username,
//       body: snapshot.data().text,
//       clickAction: "FLUTTER_NOTIFICATION_CLICK",
//     },
//   });
// });

