import LoggerInstance from '../../loaders/logger';
import database from '../../loaders/database';
import { ObjectId } from 'bson';

export async function loginController(phoneNumber: string): Promise<any> {
  const doc = await (await database()).collection('users').findOne({
    phoneNumber: phoneNumber,
  });
  LoggerInstance.info(`User : ${doc}`);
  return doc;
}

export async function signupController(phoneNumber: string): Promise<any> {
    const banks = [];
  await (await database()).collection('banks').find({
    phoneNumber: `${phoneNumber}`,
  }).forEach((doc) => {
    LoggerInstance.info(`Doc Data : ${doc.toString()}`);
    banks.push({
      name: doc.name,
      id: doc._id.toString(),
    });
  });
  return banks;
}

export async function completeRegistrationController(id: string, email: string){
    const doc = await (await database()).collection('banks').findOne({
        _id: new ObjectId(`${id}`)
    })
    if(doc === null){
      throw "No Such Bank Exists"
    }
    let idInserted;
    const user = await (await database()).collection('users').findOne({
      phoneNumber: doc.phoneNumber
  })
  if(user != null){
    throw "User Exists"
  }
    await (await database()).collection('users').insertOne({
        email:email,
        phoneNumber: doc.phoneNumber,
        bankId: id,
        balance: 0.0
    }).then(result => {
        idInserted = result.insertedId
    })
    return idInserted;
}
