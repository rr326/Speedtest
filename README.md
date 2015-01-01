# Speedtest

Test the network connection speed by reading and writing a file over the network.

Intended to be run as a simple linux command line script that takes cl options and writes to stdout.

LOCALTIME TYPE SPEED(MB/s)  UNIXTIME SIZE(MB) FILE

1998-12-31T23:59:60 DOWNLOAD 0.25 1419086327 1.0 http://aws.amazon.com/k2company/files/1mbfile.txt

Note - the stuff on the left makes it easy to read without processing. the stuff on the right is for debugging / processing.



* speedtest module
    * Options
    * Utils
        * create_file(size)
        * copy to aws
    * ST
        * download
        * upload
        * to_s
    * Runner
* bin
    * speedtest