import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp()

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

export const sendNotifications = functions.pubsub.schedule('every 1 hours').onRun(async (context) => {
    const tokens: IToken[] = []
    const prefs: IPref[] = []

    await db.collection('tokens').get().then((snapshot) => {
        snapshot.forEach(document => {
            tokens.push({
                uid: document.id,
                token: document.get('token')
            })
        })
    })

    await db.collection('preferences').get().then((snapshot) => {
        snapshot.forEach(document => {
            prefs.push({
                uid: document.id,
                start: document.get('start')?.toDate(),
                end: document.get('end')?.toDate(),
            })
        })
    })

    tokens.forEach((token) => {
        prefs.forEach((pref) => {
            if (token.uid === pref.uid) {
                const currentHour = (new Date).getHours()
                const start = (new Date(pref.start)).getHours()
                const end = (new Date(pref.end)).getHours()

                let payload: admin.messaging.MessagingPayload | undefined = undefined;

                if(start === currentHour) {
                    payload = {
                        notification: {
                            title: "Good Morning!",
                            body: "Drink 2 glasses of water"
                        }
                    }
                } else if (start < currentHour && currentHour < end) {
                    payload = {
                        notification: {
                            body: "Drink 1 glass of water"
                        }
                    }
                } else if (end === currentHour) {
                    payload = {
                        notification: {
                            title: "Good Evening!",
                            body: "Drink 1 glass of water"
                        }
                    }
                }

                if (payload) {
                    fcm.sendToDevice(token.token, payload);
                }
            }
        })
    })
})