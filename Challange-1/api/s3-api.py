import boto3
import urllib.request
import sys
import os

s3 = boto3.resource('s3')
bucket_name = s3.Bucket('friendsurance-test')

#Checking Number of arguments
def check_number_of_argument(num_arg):
    if num_arg != 2:
        print("Enter the file url and file name(Number of argument is wrong)")
        print("python <script.py> <URL/List> <IMAGE_NAME>")
        exit(1)

#Downloading images to local
def download_image_to_local(arg):
    URL = arg[0]
    image_name= arg[1]
    #downloading image
    urllib.request.urlretrieve(URL, image_name)
    name, ext = os.path.splitext(URL)
    #Checking URL end with image file extension
    if ( '.png' or '.jpg' or '.jpeg' ) not in ext :
        print("Wrong file extension")
        ext(1)
    else:
        print("Correct ext")

#Uploading Images to s3
def upload_image_to_s3(arg):
    bucket_name = 'friendsurance-test'
    URL = arg[0]
    name, ext = os.path.splitext(URL)
    image = arg[1]
    if image.lower().endswith(('.png', '.jpg', '.jpeg')):
        #Uploading to s3
        content = open(image, 'rb')
        s3 = boto3.client('s3')
        s3.put_object(Bucket=bucket_name, Key=image, Body=content)
        content.close()
        #Removing the file from local after uploading to s3
        os.remove(image)
    else:
        with_out_extension_image = arg[1]
        #Renaming file with exact extension which is in URL
        os.rename(with_out_extension_image, with_out_extension_image+ext)
        image = with_out_extension_image+ext
        content = open(image, 'rb')
        s3 = boto3.client('s3')
        s3.put_object(Bucket=bucket_name, Key=image, Body=content)
        content.close()
        # Removing the file from local after uploading to s3
        os.remove(image)

#Function to list images from S3		
def list_images_in_s3():
    s3 = boto3.resource('s3')
    bucket_name = s3.Bucket('friendsurance-test')
    for object in bucket_name.objects.all():
        print(object.key)

#Function to remove images from S3
def remove_image_from_s3(num_arg,file_name):
    if num_arg != 2:
        print("Number of argument is wrong")
        print("python <script>.py delete <image.ext>")
    else:
        s3 = boto3.resource('s3')
        bucket_name = 'friendsurance-test'
        print(file_name)
        s3.Object(bucket_name, file_name ).delete()

#Inserting details to db
def insert_into_db():
    pass

arguments = sys.argv[1:]
count = len(arguments)
if arguments[0] == 'list':
    print("list")
    list_images_in_s3()
elif arguments[0] == 'delete':
    file_name = arguments[1]
    remove_image_from_s3(count,file_name)
else:
    check_number_of_argument(count)
    download_image_to_local(arguments)
    upload_image_to_s3(arguments)
    insert_into_db()