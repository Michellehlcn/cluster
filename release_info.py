#Python Script for MongoDB Interaction
from pymongo import MongoClient
from bson import ObjectId, timestamp
import time
import argparse

    
parser = argparse.ArgumentParser()
parser.add_argument('-u', '--username', action="store", type=str, dest="username", required=True, help="DB username")
parser.add_argument('-p', '--password', action="store", type=str, dest="password", required=True, help="DB password")
parser.add_argument('-s', '--service', action="store", type=str, dest="servicename",  required=True, help="Service name")
parser.add_argument('-t', '--tag', action="store", type=str, dest="releasetag",  required=True, help="Release Tag")
args = parser.parse_args()
print(args.username)
print(args.releasetag)


user = args.username
password = args.password
release_tag = args.releasetag
service_name = args.servicename

# Connect to DB
client = MongoClient(f'mongodb://{user}:{password}@localhost:28015')
db = client["test"]
collection = db["sj_release.audit_log"]

def generate_document():
    global user, service_name, release_tag
    current_time = time.time()
    print(current_time)
    document = {
        "_id": ObjectId(),
        "message": f"{user} deployed service {service_name}:{release_tag}",
        "t": current_time
    }
    return document

def insert_or_update_document(document):
    query = {"name": document["t"]}
    existing_doc = collection.find_one(query)

    if existing_doc:
        collection.update_one(query, {"$set": {"mod_timestamp": document["msg"]}})
    else:
        collection.insert_one(document)

def main():
    global client
    document = generate_document()
    insert_or_update_document(document)
    print(f"Inserted/Updated document: {document}")
    client.close()
if __name__ == "__main__":
    main()