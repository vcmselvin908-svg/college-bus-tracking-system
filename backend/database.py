import firebase_admin
from firebase_admin import credentials, db

def init_firebase():
    cred = credentials.Certificate("serviceAccountKey.json")
    firebase_admin.initialize_app(cred, {
        'databaseURL': 'https://bus-tracking-system-xxxxx.firebaseio.com'
        # 👆 இங்க உங்க actual Firebase URL paste பண்ணுங்க
    })

def get_db():
    return db.reference('buses')