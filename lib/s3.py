from minio import Minio
from minio.error import S3Error


def connect_to_s3(host,port,access,secret,secure="true"):
    sec= (secure.lower() in ['true','1','yes','on'])

    client = Minio(
        host+":"+port,
        access_key=access,
        secret_key=secret,
        secure=sec
    )

    return client

def create_bucket(client,name):
    client.make_bucket(name)

def does_bucket_exist(client,name):
    return client.bucket_exists(name)

def remove_empty_bucket(client,name):
    client.remove_bucket(name)