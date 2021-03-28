import { Router } from 'express';
import authRouter from './auth/auth.router';
import transactionRouter from './transactions/transaction.router';

export default (): Router => {
  const app = Router();

  app.use('/auth', authRouter())
  app.use('/transaction', transactionRouter())

  return app;
};
