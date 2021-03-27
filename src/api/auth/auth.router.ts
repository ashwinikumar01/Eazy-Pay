import { Request, Response, Router } from "express";
import { loginController } from "./auth.controller";
import jsonwebtoken from 'jsonwebtoken';
import config from "../../config";
import LoggerInstance from "../../loaders/logger";

export default (): Router => {
    const router = Router();
    router.post('/login', loginHandler);
    return router;
}

async function loginHandler(req: Request,res: Response) {
    try{
        if(req.body.phoneNumber.length === 0){
            throw "Invalid Fields!!!"
        }
        const user = await loginController(req.body.phoneNumber);
        LoggerInstance.info(`Found User : ${user}`)
        if(user === undefined || user === null) {
            res.status(404).json({
                status: 'OK',
                message: 'Not Found',
            })
        }
        else{
            LoggerInstance.info(`Found User : ${user}`)
            const token = jsonwebtoken.sign(user._id.toString(), config.jwtSecret);
            LoggerInstance.info(`Token : ${token}`)
            res.status(200).json({
                status: 'OK',
                message: 'User Signed In',
                token: token
            })
        }
    
    }
    catch(e){
        LoggerInstance.error(`${e}`);
        res.status(400).json({
            status: 'Failed',
            message: e,
        })
    }
}