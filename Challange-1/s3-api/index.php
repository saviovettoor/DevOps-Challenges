<?php
        # Read the JSON Data
        $data = json_decode(file_get_contents('php://input'), true);
        $parameter1_value = $data['parameter1'];
        $parameter2_value = $data['parameter2'];
        if (!empty($parameter1_value) || !empty($parameter2_value))
        {
                $message = shell_exec("/bin/bash /opt/api/s3-api.sh $parameter1_value $parameter2_value");
                #$message = shell_exec("/usr/bin/python /var/www/s3-api/s3-api.py $parameter1_value $parameter2_value");
                $success_string = 'SUCCESS';
                $is_success = strpos($message, $success_string);
                if ($is_success === false)
                {
                        header_remove();
                        http_response_code(500);
                        header('Content-Type: application/json');
                        echo json_encode(array('message' => $message));
                }
                else
                {
                        header_remove();
                        http_response_code(200);
                        header('Content-Type: application/json');
                        echo json_encode(array('message' => $message));
                }
        }
        else
        {
                header_remove();
                http_response_code(500);
                header('Content-Type: application/json');
                $message = 'Fail to process the request.';
                echo json_encode(array('message' => $message));
        }
?>
