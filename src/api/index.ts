import { Router } from 'express';
import authRouter from './auth/auth.router';
import profileRouter from './profile/profile.router';
import transactionRouter from './transactions/transaction.router';

export default (): Router => {
  const app = Router();

  app.use('/auth', authRouter())
  app.use('/transaction', transactionRouter())
  app.use('/profile', profileRouter())
  return app;
};
