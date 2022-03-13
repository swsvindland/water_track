import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as moment from 'moment';
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

interface IToken {
    uid: string
    token: string
}

interface IPref {
    uid: string
    start: number
    end: number
}

export const sendNotificationsHttp = functions.https.onRequest(async (req, res) => {
    await sendNotifications();

    res.end();
});


export const sendNotificationsScheduler = functions.pubsub.schedule('0 * * * *').onRun(async () => {
    await sendNotifications();

    return null;
});

const sendNotifications = async () => {
    const tokens: IToken[] = [];
    const prefs: IPref[] = [];

    await db.collection('tokens').get().then((snapshot) => {
        snapshot.forEach((document) => {
            tokens.push({
                uid: document.id,
                token: document.get('token'),
            });
        });
    });

    await db.collection('preferences').get().then((snapshot) => {
        snapshot.forEach((document) => {
            prefs.push({
                uid: document.id,
                start: document.get('start')?.toDate(),
                end: document.get('end')?.toDate(),
            });
        });
    });

    tokens.forEach((token) => {
        prefs.forEach((pref) => {
            if (token.uid === pref.uid) {
                const current = moment(`2000 1 1 ${(new Date).getHours()}:00:00`);
                const start = (new Date(pref.start));
                const end = (new Date(pref.end));
                let payload: admin.messaging.MessagingPayload | undefined = undefined;

                console.log(start, end, current);

                if (start.getHours() === current.hour()) {
                    payload = {
                        notification: {
                            title: 'Good Morning!',
                            body: 'Drink 2 glasses of water',
                        },
                    };
                } else if (moment(start, 'h').isBefore(moment(current, 'h')) && moment(current, 'h').isBefore(moment(end, 'h')) ) {
                    payload = {
                        notification: {
                            title: 'Good Job, Keep Going!',
                            body: 'Drink 1 glass of water',
                        },
                    };
                } else if (end.getHours() === current.hour()) {
                    payload = {
                        notification: {
                            title: 'Good Evening!',
                            body: 'Drink 1 glass of water',
                        },
                    };
                }

                if (payload) {
                    fcm.sendToDevice(token.token, payload);
                }
            }
        });
    });
};
