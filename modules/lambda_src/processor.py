import boto3
import json
import os

s3 = boto3.client('s3')

def lambda_handler(event, context):
    try:
        # Log the event for debugging
        print("Event received:", json.dumps(event))
        
        # Example processing logic
        for record in event['Records']:
            bucket_name = record['s3']['bucket']['name']
            object_key = record['s3']['object']['key']
            print(f"Processing file: {object_key} from bucket: {bucket_name}")

            # Processing logic goes here...
        
        return {
            "statusCode": 200,
            "body": json.dumps("Processing complete")
        }
    
    except Exception as e:
        print(f"Error encountered: {e}")
        
        # Move the file to the quarantine bucket
        quarantine_bucket = os.environ['QUARANTINE_BUCKET']
        original_bucket = record['s3']['bucket']['name']
        object_key = record['s3']['object']['key']
        
        copy_source = {'Bucket': original_bucket, 'Key': object_key}
        s3.copy_object(Bucket=quarantine_bucket, CopySource=copy_source, Key=object_key)
        s3.delete_object(Bucket=original_bucket, Key=object_key)
        
        return {
            "statusCode": 500,
            "body": json.dumps("Error occurred. File moved to quarantine.")
        }
