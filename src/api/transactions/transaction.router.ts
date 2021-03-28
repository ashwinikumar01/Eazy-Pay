import { Router , Request , Response } from 'express';
import jsonwebtoken from 'jsonwebtoken';
import config from '../../config';
import LoggerInstance from '../../loaders/logger';
import { sendMoney } from './transaction.controller';

export default (): Router => {
    const router =  Router();
    router.post('/send', handleSending)
    return router;
}

async function handleSending(req: Request,res: Response){
    try{
        if(req.headers.authorization.length === 0){
            throw "Auth Failed"
        }
        LoggerInstance.info(`TOKEN : ${req.headers.authorization}`);
        const token = req.headers.authorization.split(' ')[1]
        const decoded: any = jsonwebtoken.verify(`${token}`, config.jwtSecret)
        if(req.body.phoneNumber.length === 0){
            throw "Invalid Fields"
        }
        await sendMoney(req.body.phoneNumber, req.body.amount, decoded.id, 'SAMPLE');
        res.status(200).json({
            message: 'Transaction Initiated',
            status: 'OK'
        })
    }
    catch(e){
        LoggerInstance.error(e);
        res.status(200).json({
            message: 'Bad Request',
            status: 'FAILED',
            error: e
        })
    }
}