import dotenv from 'dotenv';
dotenv.config();

process.env.NODE_ENV = process.env.NODE_ENV || 'development';

export default {
  /**
   * Port the app should run on
   */
  port: parseInt(process.env.PORT) || 5050,

  /**
   * Database the app should connect to
   */
  databaseURL: process.env.MONGODB_URI,

  /**
   * The secret sauce to validate JWT
   */
  jwtSecret: process.env.JWT_SECRET,

  /**
   * Used by Winston logger
   */
  logs: {
    level: process.env.LOG_LEVEL || 'silly',
  },

  /**
   * Twilio SID
   */
  sid: process.env.TWILIO_SID,

  /**
   * Twilio Auth
   */
  authToken: process.env.TWILIO_AUTH,

  /**
   * Twilio Phone Number
   */
  phoneNumber: process.env.PHONE_NUMBER,
 
  /**
   * The secret sauce to validate FCM
   */
  fcmsecret: process.env.FCM_SECRET,


  api: {
    prefix: '/api',
  },
};
