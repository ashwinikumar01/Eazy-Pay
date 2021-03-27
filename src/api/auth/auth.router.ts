import { Request, Response, Router } from "express";
import { loginController } from "./auth.controller";

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
        await loginController(req.body.phoneNumber);
    res.status(200).json({
        status: 'OK',
        message: 'User Signed In',
        token: 'SAMPLE'
    })
    }
    catch(e){
        res.status(400).json({
            status: 'Failed',
            message: e,
        })
    }
}