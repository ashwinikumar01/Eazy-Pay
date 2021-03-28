import database from '../../loaders/database';

export async function paymentController(balance:String){
    const cursor = await (await database()).collection("users").find({
        balance:balance
    })
   }