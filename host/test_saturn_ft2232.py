#! /usr/bin/python

import sys, os

#import pylibftdi
from pylibftdi import Driver, Device

try:
  dev_list  = Driver().list_devices()
  if len(dev_list) != 0:
    print "\n\nFollowing devices found: \n"
    for device_ in dev_list:
      print device_
    
    dev = Device(device_id="FTZ17IRO", mode='b', interface_select=2)
    
    dev.open()
    
    tx_data = bytearray(range(0, 256))
    dev.write(tx_data)
    
    rx_data = bytearray(dev.read(257))#, timeout = 0))
    
    if len(rx_data) == 256 :
      print "\n\n[Test] Test 1 Passed: Sent 256 bytes of data, received 256 bytes of data"
    
    failed = False
    for i in range(256):
      if ((tx_data[i]+1)%256) != rx_data[i]:
        print "[Test] Test 2: Data verification failed! , tx_data : ", tx_data[i], " =/= rx_data : ", rx_data[i]
        failed = True	
    
    if not(failed):
      print "[Test] Test 2 Successful: Data transmit and receive verified!"

    dev.close()

    opt = raw_input("\n\nWould you like to see transmitted and received data? [Y/n] : ")
    if opt.lower() == 'y':
      print "\n\nTransmitted data: "
      for i in tx_data:
        print i, 
      print "\n\n"
      print "Received data : "
      for i in rx_data:
        print i, 
      print "\n\n"
    
  else:
    print "\n\nERROR: No FTDI Devices found! \n"

except:
  print "\n\nSome error!"

print "Wow"


if __name__ == "__main__":

	print("Hello World!")

