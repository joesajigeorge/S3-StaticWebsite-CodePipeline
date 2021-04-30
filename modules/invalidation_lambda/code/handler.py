import boto3
import time
import os

def lambda_handler(event, context): 

    client = boto3.client('cloudfront')
    batch = {
        'Paths': {
            'Quantity': 1,
            'Items': [ '/' ]
        },
        'CallerReference': str(time.time())
    }
    invalidation = client.create_invalidation(                   
        DistributionId=os.environ['CLOUDFRONT_DISTRIBUTION_ID'], 
        InvalidationBatch=batch
    )
    print("Invalidation started")
    return batch