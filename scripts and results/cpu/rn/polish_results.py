#!/usr/bin/python3

# import matplotlib.pyplot as plt
import numpy
import sys
import os

experiment_number = sys.argv[1]

print(f'Cycle # {experiment_number}')


f = open("batt1.txt", "r")

start_battery = None
end_battery = None

start_bat_temperature = None
end_bat_temperature = None

duration = None

cpu_usage_list = []
rss_occupancy_list = []
mem_percentarge_list = []

for line in f:
    if "charge" in line:
        words = line.split(" ")
        start_battery = int(words[3])
    elif "temperature" in line:
        words = line.split(" ")
        start_bat_temperature = int(words[3])

f.close()
f = open("batt3.txt", "r")

for line in f:
    if "charge" in line:
        words = line.split(" ")
        end_battery = int(words[3])
    elif "temperature" in line:
        words = line.split(" ")
        end_bat_temperature = int(words[3])

f.close()
f = open("measures1.txt", "r")

for line in f:
    words = line.split(" ")
    words = [w for w in words if w != ""]
    cpu_usage_list.append(float(words[1]))
    rss_occupancy_list.append(float(words[0][:-1]))
    mem_percentarge_list.append(float(words[2]))

f.close()
f = open("time", "r")

for line in f:
    duration = int(line)

cpu_usage_list = [i/8 for i in cpu_usage_list]

os.mkdir(f'results{experiment_number}')

f = open(f'results{experiment_number}/cpu', "w")
for i in cpu_usage_list:
    f.write(str(i))
    f.write('\n')

f = open(f'results{experiment_number}/rss', "w")
for i in rss_occupancy_list:
    f.write(str(i))
    f.write('\n')

f = open(f'results{experiment_number}/mem', "w")
for i in mem_percentarge_list:
    f.write(str(i))
    f.write('\n')

f = open(f'results{experiment_number}/stats', "w")
f.write(f'Start charge counter: {start_battery}\n')
f.write(f'End charge counter: {end_battery}\n')
f.write(f'Delta charge counter: {end_battery-start_battery}\n\n')

f.write(f'Start battery temperature: {start_bat_temperature}\n')
f.write(f'End battery temperature: {end_bat_temperature}\n')
f.write(
    f'Delta battery temperature: {end_bat_temperature-start_bat_temperature}\n\n')

f.write(f'Duration: {duration}\n\n')
lists = [cpu_usage_list, mem_percentarge_list, rss_occupancy_list]
names = ["CPU", "MEM", "RSS"]
for i, list in enumerate(lists):
    average = sum(list) / len(list)
    minimum = min(list)
    maximum = max(list)
    std = numpy.std(list)
    f.write(names[i] + '\n')
    f.write(f'Max: {maximum}\n')
    f.write(f'Min: {minimum}\n')
    f.write(f'Std: {std}\n')
    f.write(f'Average: {average}\n')

os.remove('batt1.txt')
os.remove('batt3.txt')
os.remove('measures1.txt')
os.remove('time')
os.remove('image.png')

# fig = plt.figure("CPU")
# plt.plot(cpu_usage_list)
# ax = plt.gca()
# ax.set_ylim([0, 100])
# plt.ylabel('CPU Usage Percentage')
# plt.savefig('results/cpu.png')

# fig = plt.figure("RSS")
# plt.plot(rss_occupancy_list)
# ax = plt.gca()
# plt.ylabel('RSS Occupancy in MB')
# plt.savefig('results/rss.png')

# fig = plt.figure("MEM")
# plt.plot(mem_percentarge_list)
# ax = plt.gca()
# ax.set_ylim([0, 100])
# plt.ylabel('RAM occupancy percentage')
# plt.savefig('results/mem.png')
