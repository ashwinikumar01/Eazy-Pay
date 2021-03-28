import { ObjectId } from "bson";
import database from "../../loaders/database";

export async function sendMoney(phoneNumber: string, amount: number, fromId: string, transactionId: string){
    const user = await (await database()).collection('users').findOne({
        _id: new ObjectId(fromId)
    })
    if(user != undefined && amount > user.balance){
        throw 'Insufficient Funds'
    }
    else{
        const toUser = await (await database()).collection('users').findOne({
            phoneNumber: phoneNumber
        })
        await (await database()).collection('users').updateOne(
            {
                _id: new ObjectId(toUser._id),
            },
            {
                $inc: {balance: amount},
                $currentDate: { lastModified: true }
            }
        );
        await (await database()).collection('users').updateOne(
            {
                _id: new ObjectId(fromId),
            },
            {
                $inc: {balance: -amount},
                $currentDate: { lastModified: true }
            }
        );
    }
}