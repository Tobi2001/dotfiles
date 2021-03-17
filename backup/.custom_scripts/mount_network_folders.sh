#!/usr/bin/expect
 
set timeout 20
 
stty -echo
send_user -- "Password to mount all network drives: "
expect_user -re "(.*)\n"
send_user "\n"
set password $expect_out(1,string)
 
log_user 0
spawn -noecho mount /media/network_denso/projects 
expect "*"
send "$password\r";
expect eof
 
spawn -noecho mount /media/network_denso/hardware_and_sensors
expect "*"
send "$password\r";
expect eof
 
spawn -noecho mount /media/network_denso/sensor_data
expect "*"
send "$password\r";
expect eof
 
spawn -noecho mount /media/network_denso/sensor_data_transfer
expect "*"
send "$password\r";
expect eof
 
spawn -noecho mount /media/network_denso/public_data
expect "*"
send "$password\r";
expect eof
 
spawn -noecho mount /media/network_denso/transfer
expect "*"
send "$password\r";
expect eof
 
spawn -noecho mount /media/network_denso/home
expect "*"
send "$password\r";
expect eof
 
spawn -noecho mount /media/network_denso/literature
expect "*"
send "$password\r";
expect eof

spawn -noecho mount /media/network_denso/software
expect "*"
send "$password\r";
expect eof

spawn -noecho mount /media/network_denso/temporary_data
expect "*"
send "$password\r";
expect eof
