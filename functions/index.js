const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

var database = admin.firestore();

 // Create and Deploy Your First Cloud Functions
 // https://firebase.google.com/docs/functions/write-firebase-functions



exports.scheduledFunction = functions.pubsub.schedule('every 1 minutes').onRun((context) => {

  database.collection("tecnico2").get().then((querySnapshot) => {
      querySnapshot.forEach((doc) => {
          // doc.data() is never undefined for query doc snapshots
          for (var room in doc.data()["rooms"]) {
            for (var table in room["tables"]) {
                if (table["reservation"]["duration"] === null
                    || table["reservation"]["endTime"] < Date.now())
                    continue;
                table["reservation"].update({
                    duration: null,
                    endTime: null,
                    initTime: null,
                    istID: null
                });
                table.update({
                   state: 0
                })
            }
          }
      });
      return null;
  }).catch(error => { console.log(error.toString())});
  return null;
});