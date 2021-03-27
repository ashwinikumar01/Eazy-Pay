import jwt from 'jsonwebtoken';
import {Request , Response} from 'express';
import twilio from 'twilio';
import config from '../../config';
import LoggerInstance from '../../loaders/logger';
import database from '../../loaders/database';


export async function signupController(phoneNumber: string, email:String ){
 const cursor = await (await database()).collection("bank").find({
     phoneNumber:phoneNumber
 })
    const banks = [];
    await cursor.forEach((doc) => {
        banks.push({
            name: doc.name,
            id: doc._id.toString()
        });
    })
    return banks;
}

export async function loginController(phoneNumber: string) {
    const client = twilio(config.sid, config.authToken);
    client.messages.create({
        body: 'Login Attempt!!!',
        to: `${phoneNumber}`,
        from: `${config.phoneNumber}`
    }).then((message) => {
        LoggerInstance.info(`Login Attempt Message Sent!!! Message : ${message}`);
    }).catch((error) => {
        LoggerInstance.error(`Login Attempt Message Sent!!! Error : ${error}`)
    })
}
