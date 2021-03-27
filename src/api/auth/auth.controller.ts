import jwt from 'jsonwebtoken';
import {Request , Response} from 'express';
import twilio from 'twilio';
import config from '../../config';
import LoggerInstance from '../../loaders/logger';
import database from '../../loaders/database';

export async function loginController(phoneNumber: string): Promise<any> {
    const doc = await (await database()).collection('users').findOne({
        phoneNumber: phoneNumber
    });
    LoggerInstance.info(`User : ${doc}`);
    return doc;
}