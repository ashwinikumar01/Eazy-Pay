import database from "../../loaders/database";

export async function sendMoney(id: string, amount: number, fromId: string){
    const user = await (await database()).collection('users').findOne({
        _id: fromId
    })
    if(user != null && amount > user.balance){
        throw 'Insufficient Funds'
    }
}