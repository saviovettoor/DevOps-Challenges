DevOps Challenge
================
```
Create an API to download and store
images given a URL, and to list all the images it has stored. This application doesn't need a GUI;
it only needs to be able to accept requests to save and to list the images. The infrastructure to
host this application must be created in AWS.
Details
	The API will have two functionalities:
	1. The first functionality is to save images in S3 given a URL:
		a. The application will have an endpoint that can receive an HTTP request with a link to an image and a name for the image;
		b. The application will download the image and store it in S3;
	2. List all the images stored in S3:
		a. The application will have an endpoint that will return all the images it has

stored in S3;
Some information about the images must be stored in a database table. The data that
needs to be stored are:
	1. Name of the image (the name received in the request)
	2. Original link of the image (the link received in the request)
	3. Path to the image in S3 (bucket + key name)
	4. Timestamp of when the image was stored in S3

The solution needs to meet at least these criterias in order to be evaluated:
The infrastructure must be in AWS
	AWS resources must be created with CloudFormation only
	There must have instructions on how to deploy the infrastructure
Although not mandatory, it's encouraged that:
	The API is written in Python
	The API use JSON as data format for request and response
```