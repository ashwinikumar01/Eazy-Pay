import admin from 'firebase-admin';
import config from '../config';

let serviceAccount: any = config.fcmsecret

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "config.databaseURL"
});

let registrationToken: any = "<registration token goes here>";
let payload : any = {
    notification: {
      title: "Account Deposit",
      body: "A deposit to your savings account has just cleared."
    }
  };

 let options:any = {
    priority: "normal",
    timeToLive: 60 * 60
  };

 admin.messaging().sendToDevice(registrationToken, payload, options)
  .then(function(response) {
    console.log("Successfully sent message:", response);
  })
  .catch(function(error) {
    console.log("Error sending message:", error);
  });
