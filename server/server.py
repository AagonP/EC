import os
import threading
import braintree
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

import keys
import model

# Braintree set up
gateway = braintree.BraintreeGateway(
    braintree.Configuration(
        braintree.Environment.Sandbox,
        merchant_id=keys.merchant_id,
        public_key=keys.public_key,
        private_key=keys.private_key
    )
)

# Firestore setup
# Use a service account
dir_path = os.path.dirname(os.path.realpath(__file__))
fire_store_key_path = dir_path + "\\eatify_firestore_key.json"
cred = credentials.Certificate(fire_store_key_path)
firebase_admin.initialize_app(cred)
db = firestore.client()

def process_transaction(amount,nonce,device_data):
    # Send transaction to Braintree
    gateway.transaction.sale({
    "amount": amount,
    "payment_method_nonce": nonce,
    "device_data": device_data,
    "options": {
      "submit_for_settlement": True
    }
    })

def print_transaction_info(amount,nonce,device_data):
    print('Amount of transaction:',amount)
    print('Nonce:',nonce)
    print('Device data:',device_data)

def update_document(id):
    # Update an document after processing
    db.collection(u'receipts').document(id).update({u'is_processed': True})

def main():
    # Create an Event for notifying main thread.
    callback_done = threading.Event()

    # Create a callback on_snapshot function to capture changes
    def on_snapshot(col_snapshot, changes, read_time):
        print(u'Callback received query snapshot.')
        for doc in col_snapshot:  
            # parsing
            amount = doc.get('amount')
            nonce = doc.get('nonce')
            device_data = doc.get('device_data')
            print('Receipt documentID:',doc.id)
            print_transaction_info(amount,nonce,device_data)
            process_transaction(amount,nonce,device_data)
        # Update is_processed field
        for doc in col_snapshot:
            update_document(doc.id)
        callback_done.set()

    col_query = db.collection(u'receipts').where(u'is_processed', u'==', False)

    # Watch the collection query
    col_query.on_snapshot(on_snapshot)

    # Keep the program running
    while True:
        pass

main()

