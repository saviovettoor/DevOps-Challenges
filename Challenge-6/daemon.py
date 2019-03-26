import datetime
import sys
import os
import threading
import psutil
import sh 

not_running_count = 0
give_up_count = 0

#Function to check number of arguments passed
def checking_number_of_arguments():
	if len(sys.argv) != 5:
                print ("\n----------------------------------------\n")
                print ("## \t Error: Invalid number of arguments ##")
                print ("\n----------------------------------------\n")
                print ("## Usage: \n \t python " + sys.argv[0]  + " <process_name> <check_interval_in_seconds> <number_of_attempts_bfr_give_up> <attemps_to_wait_before_restart>")
                print ("\n----------------------------------------\n")
                print("#------ Execution Completed at %s ------#" % (datetime.datetime.now()))
                sys.exit(1)

#Function to check argument type
def arg_data_type_validation():
        if sys.argv[1].isdigit():
                print ("\n----------------------------------------\n")
                print ("## \t Error: Invalid argument type for process name. Should be a String##")
                print ("\n ---------------------------------------- \n ")
                print("\n#------ Execution Completed at %s ------#" % (datetime.datetime.now()))
                sys.exit(1)
        arg=all([arg.isdigit() for arg in sys.argv[2:]])
        if not arg:
                print ("\n ----------------------------------------\n")
                print ("## \t Error: Invalid argument type for the variable: check_interval/number_of_attempt/wait_interval. which Should be an Integer ##")
                print ("\n ----------------------------------------")
                print("\n #------ Execution Completed at %s ------#" % (datetime.datetime.now()))
                sys.exit(1)
        global attempts_number
        attempts_number = int(sys.argv[3])
        
#Function to check for init script
def checking_init_file_exist():
        process_name = sys.argv[1]
        file_name=("/usr/lib/systemd/system/" + process_name + ".service")
        if not os.path.exists(file_name):
                print ("\n ----------------------------------------\n")
                print ("## \t Error: Init Script for the service \"%s\" is not found in /usr/lib/systemd/system/." % (process_name))
                print ("\n ----------------------------------------")
                print("\n #------ Execution Completed at %s ------#" % (datetime.datetime.now()))
                sys.exit(1)

#Get list of all running  process
def get_list_of_running_process():
        process_name = sys.argv[1]
        list_of_process=sh.grep(sh.ps('-aux', _piped=True),  '-v' ,'python')
        return list_of_process;

def monitor_process():
	process_name = sys.argv[1]
	check_interval = int(sys.argv[2])
	wait_interval = int(sys.argv[4])
	scheduler = threading.Timer(check_interval, monitor_process)
	scheduler.start()                       #Timers are started
	process_list=get_list_of_running_process()
	if process_name not in process_list:
		global not_running_count
		if not_running_count < wait_interval:
			not_running_count = not_running_count + 1
			print ("\n ----------------------------------------")
			print ("## INFO: Attempt %s : %s Service is NOT RUNNING" % (not_running_count, process_name))
			print ("----------------------------------------")
		else:
			newprocess = "systemctl restart %s.service >/dev/null 2>&1" % (process_name)
			exit_code = os.system(newprocess)
			if exit_code != 0:
				global give_up_count
				if give_up_count < attempts_number:
					give_up_count = give_up_count + 1
					print ("\n ----------------------------------------")
					print ("## \t INFO: Attpemts Threshold Limit Crossed. Restarting the process")
					print ("## \t INFO: Attempt %s to restart %s service failed. Maximum attempt count is %s, will give up once attempt reached threshold." % (give_up_count, process_name, attempts_number))
					print ("----------------------------------------\n")
				else:
					print ("\n ----------------------------------------")
					print("## \t ERROR: Giving up as the process is not starting even after multiple attempts.")
					file_name=("/var/log/" + process_name + "_" + str(datetime.datetime.now().strftime('%Y-%m-%d-%H:%M:%S')) + ".log")
					os.system("systemctl status %s.service >> %s 2>&1" % (process_name, file_name))	
					print("## \t INFO: To view more detail about the status of process %s look into the file %s" % (process_name, file_name))
					print ("----------------------------------------")
					scheduler.cancel()
					print("\n #------ Execution Completed at %s ------#" % (datetime.datetime.now()))
					sys.exit(1)	
			else:
				not_running_count = 0
				give_up_count = 0
				print ("\n ----------------------------------------\n")
				print("## \t SUCCESS: %s Service Restarted Successfully" % (process_name))
				print ("\n ----------------------------------------\n")
				sys.exit(1)
	else:
		give_up_count = 0
		not_running_count = 0
		print("%s Service is RUNNING..." % (process_name))			
		sys.exit(1)
		
if __name__ == '__main__':
        print("#------ Execution Started at %s ------#" % (datetime.datetime.now()))
        checking_number_of_arguments()
        arg_data_type_validation()
        checking_init_file_exist()
        monitor_process()
