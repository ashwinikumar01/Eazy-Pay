import { Request, Response, Router } from "express";
import { loginController, signupController } from "./auth.controller";
import {jwt} from "jsonwebtoken"
import config from '../../config';
import database from '../../loaders/database';
import { createRequire } from "node:module";
export default (): Router => {
    const router = Router();
    router.post('/signup',signupHandler)
    router.post('/login', loginHandler);
    return router;
}
async function signupHandler(req:Request,res:Response){
    try{
               if(req.body.email.length>=1){
            return res.status(409).json({
                message:'User already exists'
            })
        }
    const banks = await signupController(req.body.phoneNumber,req.body.email);
        //     const token= jwt.sign({
        //       email:req.body.email,
        //     },
        //       config.jwtSecret,
        //   {
        //       expiresIn: "10000000020000h"
        //   })
              res.status(200).json({
              status:"Ok",
              message: "User Details being Sent",
                banks: banks,
          });
        }
    catch(e){
        res.status(400).json({
            status: 'Failed',
            message: e,
        })
    }
}

async function loginHandler(req: Request,res: Response) {
    
}