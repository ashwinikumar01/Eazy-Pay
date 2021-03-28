import { ObjectId } from "bson";
import database from "../../loaders/database";

export async function getProfileData(id: string){
    const user = await (await database()).collection('users').findOne({
        _id: new ObjectId(id)
    })
    return user;
}