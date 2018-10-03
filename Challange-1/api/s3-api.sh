#!/bin/bash
url_or_oprtn=$1
image_name=$2
current_time=$(date "+%Y.%m.%d-%H.%M.%S")
log_file="/tmp/s3-api_${current_time}.log"
s3_bucket_name=friendsurance-test


#listout the images the s3
list_images_in_s3()
{
        list_of_images=`aws s3 ls s3://${s3_bucket_name} | awk {'print $4'}`
        if [ -z $list_of_images ]; then
                echo "S3 bucket is empty"
        else
                echo "SUCCESS: $list_of_images"
        fi
}

#Upload image to s3
download_and_upload_image_to_s3()
{
        echo "inside Upload image to s3" >> $log_file
        regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

        #checking url is valid or not
        if [[ $url_or_oprtn =~ $regex ]]
        then
                echo "Link valid" >> $log_file
        else
                echo "Link not valid" >> $log_file
                exit 1
        fi

        download_image=`wget -O /tmp/myimage $url_or_oprtn`
        file_extn=`echo ${url_or_oprtn##*/} | awk -F . {'print $2'}`
        file_name_with_extn="$image_name.$file_extn"
        mv /tmp/myimage /tmp/$file_name_with_extn
        aws s3 cp /tmp/$file_name_with_extn s3://${s3_bucket_name}/
        aws s3 ls s3://${s3_bucket_name}/$file_name_with_extn
        if [ $? -eq 0 ]; then
                echo "SUCCESS: Successfully uploaded the image"
                rm -rf /tmp/$file_name_with_extn
                update_db
        fi
}

#database operations
update_db()
{
        DB_ENDPOINT=mydb.c8fwybn1odaz.ap-southeast-1.rds.amazonaws.com
        DB_USER=frndsuranceuser
        DB_PASSWD=password123
        DB_NAME=frndsurancedb
        TABLE=imageinfo

        db_image_name=$image_name
        db_url=$url_or_oprtn
        image_time_stamp=`aws s3 ls s3://${s3_bucket_name}/$file_name_with_extn | awk {'print $1 " " $2'}`
        s3_path="${s3_bucket_name}/$file_name_with_extn"


        #Inserting details to db
        /usr/bin/mysql --host $DB_ENDPOINT --user=$DB_USER --password=$DB_PASSWD $DB_NAME -e "  INSERT INTO $TABLE (db_image_name, db_url, s3_path, image_time_stamp ) VALUES (\"$db_image_name\", \"$db_url\", \"$s3_path\", \"$image_time_stamp\");"
		if [ $? -eq 0 ]; then
                echo "SUCCESS: Inserted info to DB"
        fi
}

#Checking number of arguments
if [ "$#" -eq 1 ] && [ $url_or_oprtn == "list" ]; then
        echo "List out the images in s3" > $log_file
        list_images_in_s3
elif [ "$#" -eq 2 ]; then
        echo "Operation is upload image" > $log_file
        download_and_upload_image_to_s3
else
        echo "Invalid Number of arguments" > $log_file
fi