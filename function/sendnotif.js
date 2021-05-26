var admin = require("firebase-admin");

var serviceAccount = require("C:/Users/hussain/AndroidStudioProjects/flutter_app_fyp/sendnotif.js/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://fyp4-9b1fc-default-rtdb.firebaseio.com"
});
// This registration token comes from the client FCM SDKs.
var registrationToken = 'cglpswIYT9KrMHrTISAywr:APA91bHCvy576Q0zdM-SlPGwktWWQlYixmgFP7-QtV6HdsGTlS1_uO4lSIdeUEkHseY4VS8efsA4PcYvChOQ5A7xGs-2LZMtkevR7WE2T1VkwPSyoIcS38G6yAkHZOcXrPHrLnSSWK7j';

var message = {
  data: {
    title: '850',
    body: '2:45'
  },
  // token: registrationToken
};

// Send a message to the device corresponding to the provided
// registration token.
admin.messaging().sendToTopic('Samsung',message)
  .then((response) => {
    // Response is a message ID string.
    console.log('Successfully sent message:', response);
  })
  .catch((error) => {
    console.log('Error sending message:', error);
  });