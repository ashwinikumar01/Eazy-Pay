import { Request, Response, Router } from "express";

export default (): Router => {
    const router = Router();
    router.post('/login', loginHandler);
    return router;
}

async function loginHandler(req: Request,res: Response) {

}