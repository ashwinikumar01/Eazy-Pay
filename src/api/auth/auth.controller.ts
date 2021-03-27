import jwt from 'jsonwebtoken';
import {Request , Response} from 'express';
import twilio from 'twilio';
import config from '../../config';
import LoggerInstance from '../../loaders/logger';

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