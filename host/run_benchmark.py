import os
import sys
import subprocess

times = []
epochs = 10

while epochs:
    run = subprocess.Popen(["python", "benchmark.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    for line in run.stdout:
        if "Time" in line:
            times.append(float(line.split()[1]))
    
print times

