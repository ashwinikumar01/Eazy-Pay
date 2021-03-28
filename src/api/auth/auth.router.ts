import { Request, Response, Router } from 'express';
import { completeRegistrationController, loginController, signupController } from './auth.controller';
import jsonwebtoken from 'jsonwebtoken';
import config from '../../config';
import LoggerInstance from '../../loaders/logger';

export default (): Router => {
  const router = Router();
  router.post('/signup', signupHandler);
  router.post('/login', loginHandler);
  router.post('/signup/complete', completeRegistration);
  return router;
};
async function signupHandler(req: Request, res: Response) {
  try {
    if (req.body.phoneNumber.length == 0) {
      throw 'Invalid Fields';
    }
    const banks = await signupController(req.body.phoneNumber);
    return res.status(200).json({
      status: 'Ok',
      message: 'User Details being Sent',
      banks: banks,
    });
  } catch (e) {
    LoggerInstance.error(`${e}`);
    res.status(400).json({
      status: 'Failed',
      message: e,
    });
  }
}

async function loginHandler(req: Request, res: Response) {
  try {
    const user = await loginController(req.body.phoneNumber);
    LoggerInstance.info(`Found User : ${user}`);
    if (user === undefined || user === null) {
      res.status(404).json({
        status: 'OK',
        message: 'Not Found',
      });
    } else {
      LoggerInstance.info(`Found User : ${user}`);
      const token = jsonwebtoken.sign({id: user._id.toString()}, config.jwtSecret, {expiresIn: "10000000020000h"});
      LoggerInstance.info(`Token : ${token}`);
      res.status(200).json({
        status: 'OK',
        message: 'User Signed In',
        token: token,
        id: user._id.toString()
      });
    }
  } catch (e) {
    LoggerInstance.error(`${e}`);
    res.status(400).json({
      status: 'Failed',
      message: e,
    });
  }
}

async function completeRegistration(req:Request, res:Response) {
    try{
        if(req.body.id.length === 0 || req.body.email.length === 0){
            throw "Invalid Fields"
        }
        const user = await completeRegistrationController(req.body.id, req.body.email);
        const token = jsonwebtoken.sign({id: user.toString()}, config.jwtSecret, {expiresIn: "10000000020000h"});
        res.status(201).json({
            status: 'OK',
            message: 'User Created',
            token: token
        })
    }
    catch(e){
        LoggerInstance.error(`${e}`)
        res.status(400).json({
            status: "FAILED",
            message: "Bad Request" 
        })
    }
}
