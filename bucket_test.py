import boto3
from botocore.client import Config
from botocore.exceptions import ClientError

def test_bucket(bucket):
    print 'testing bucket: ' + bucket
    try:
        s3 = boto3.resource('s3', config=Config(signature_version='s3v4'))
        b = s3.Bucket(bucket)
        objects = b.objects.all()

        for obj in objects:
            print obj.key
        print 'bucket test SUCCESS'
    except ClientError as e:
        print 'Client Error'
        print e
        print 'bucket test FAIL'
