import { Router, Request , Response } from "express";
import jsonwebtoken from 'jsonwebtoken';
import config from "../../config";
import { getProfileData } from "./profile.controller";

export default (): Router => {
    const router = Router();
    router.get('/personalData', profileDataHandler)
    return router;
}

async function profileDataHandler(req:Request , res: Response) {
    try{
        if(req.headers.authorization.length === 0){
            throw "Auth Failed"
        }
        else{
            const token = req.headers.authorization.split(' ')[1]
            const decoded: any = jsonwebtoken.verify(`${token}`, config.jwtSecret)
            const user = await getProfileData(decoded.id);
            res.status(200).json({
                message: 'User Found!!!',
                status: 'OK',
                userData: user
            })
        }
    }
    catch(e){
        res.status(400).json({
            message: 'Bad Request',
            status: 'FAILED',
            error: `${e}`
        })
    }
}