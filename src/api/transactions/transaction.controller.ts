import { ObjectId } from 'bson';
import database from '../../loaders/database';

export async function sendMoney(phoneNumber: string, amount: number, fromId: string) {
  const user = await (await database()).collection('users').findOne({
    _id: new ObjectId(fromId),
  });
  if (user != undefined && amount > user.balance) {
    throw 'Insufficient Funds';
  } else {
    const toUser = await (await database()).collection('users').findOne({
      phoneNumber: phoneNumber,
    });
    await (await database()).collection('users').updateOne(
      {
        _id: new ObjectId(toUser._id),
      },
      {
        $inc: { balance: amount },
        $currentDate: { lastModified: true },
      },
    );
    await (await database()).collection('users').updateOne(
      {
        _id: new ObjectId(fromId),
      },
      {
        $inc: { balance: -amount },
        $currentDate: { lastModified: true },
      },
    );
  }
}

export async function stageTransaction(phoneNumber: string, amount: number, fromId: string, transactionId: string) {
  const user = await (await database()).collection('users').findOne({
    _id: new ObjectId(fromId),
  });
  if (user != undefined && amount > user.balance) {
    throw 'Insufficient Funds';
  } else {
    const toUser = await (await database()).collection('users').findOne({
      phoneNumber: phoneNumber,
    });
    const transaction = await (await database()).collection('stage').findOne({
      transactionId: transactionId,
    });
    if (transaction === null) {
      await (await database()).collection('stage').insertOne({
        transactionId: transactionId,
        toUserId: toUser._id.toString(),
        amount: amount,
        isReceived: false,
      });
      await (await database()).collection('users').updateOne(
        {
          _id: new ObjectId(fromId),
        },
        {
          $inc: { balance: -amount },
          $currentDate: { lastModified: true },
        },
      );
    } else {
      await (await database()).collection('stage').updateOne({
        transactionId: transactionId,
      },
      {
        $set: {isReceived: true}
      }
      );
    }
  }
}

export async function requestStagedTransaction(phoneNumber: string, amount: number, fromId: string, transactionId: string) {
  const user = await (await database()).collection('users').findOne({
    _id: new ObjectId(fromId),
  });
  if (user != undefined && amount > user.balance) {
    throw 'Insufficient Funds';
  } else {
    const toUser = await (await database()).collection('users').findOne({
      phoneNumber: phoneNumber,
    });
    const transaction = await (await database()).collection('stage').findOne({
      transactionId: transactionId,
    });
    if (transaction === null) {
      throw "No Such Staged Transaction Found"
    } else {
      await (await database()).collection('stage').updateOne({
        transactionId: transactionId,
      },
      {
        $set: {isReceived: true}
      });
      await (await database()).collection('users').updateOne(
        {
          _id: new ObjectId(toUser._id),
        },
        {
          $inc: { balance: amount },
          $currentDate: { lastModified: true },
        },
      );
    }
  }
}