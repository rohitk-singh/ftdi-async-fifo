#! /usr/bin/python

import sys, os
import time
import random

from pylibftdi import Driver, Device

dev_list  = Driver().list_devices()
if len(dev_list) != 0:
    print "Following devices found:"
for device_ in dev_list:
    print device_

dev = Device(device_id="FTZ17IRO", mode='b', interface_select=2)
dev.open()


epochs = 1024*10
BLOCK_LEN = 2048
tx_data = bytearray([ random.randrange(0, 256) for i in range(BLOCK_LEN)])
ts = time.time()
while epochs:
    
    dev.write(tx_data)
    rx_data = bytearray(dev.read(BLOCK_LEN))
    
    #print "Epoch: {}".format(epochs) 
    failed = False
    for i in range(BLOCK_LEN):
      if ((tx_data[i]+1)%256) != rx_data[i]:
        print "Epoch: {}".format(epochs) 
        print "[Test] Test 2: Data verification failed! , tx_data : ", tx_data[i], " =/= rx_data : ", rx_data[i]
        failed = True
        print "Breaking..."
        break
    if failed:
        break
    
    epochs -= 1

dev.close()
te = time.time()
print "Time {}".format(str(te-ts))
