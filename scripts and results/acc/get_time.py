#!/usr/bin/python3

import os
import matplotlib.pyplot as plt
import numpy as np

folders = ["native", "flutter", "rn"]

time_lists = {}

if os.path.isfile(f'time-list.csv'):
    os.remove(f'time-list.csv')

for folder in folders:
    if os.path.isfile(f'{folder}/time-list.csv'):
        os.remove(f'{folder}/time-list.csv')

    time_lists[folder] = []

    for i in range(1, 11):
        f = open(f'{folder}/results{i}/stats', "r")
        for line in f:
            if "Duration" in line:
                words = line.split(" ")
                time = float(words[1])
                time_lists[folder].append(time)

    f.close()

    f = open(f'{folder}/time-list.csv', "w")

    f.write("Number,Time\n")

    for i in range(10):
        time = str(time_lists[folder][i])
        f.write(f'{str(i+1)},{time}\n')

    f.close()

sd = {}
_min = {}
_max = {}
average = {}

# get sd, min and max
for framework in folders:
    list = time_lists[framework]
    _min[framework] = min(list)
    _max[framework] = max(list)
    average[framework] = sum(list) / len(list)
    sd[framework] = np.std(list)

f = open(f'time.csv', "w")

f.write("Time,Native,Flutter,React Native")
f.write("\n")

for i in range(10):
    native = "{: .3f}".format(time_lists["native"][i])
    flutter = "{: .3f}".format(time_lists["flutter"][i])
    rn = "{: .3f}".format(time_lists["rn"][i])
    f.write(f'{str(i+1)},{native},{flutter},{rn}')

    f.write("\n")

f.write(
    f'"Average",{str(average["native"])},{str(average["flutter"])},{str(average["rn"])}')
f.write("\n")

f.write(
    f'"Max",{str(_max["native"])},{str(_max["flutter"])},{str(_max["rn"])}')
f.write("\n")

f.write(
    f'"Min",{str(_min["native"])},{str(_min["flutter"])},{str(_min["rn"])}')
f.write("\n")

f.write(
    f'"SD",{sd["native"]:.2f},{sd["flutter"]:.2f},{sd["rn"]:.2f}')
f.write("\n")


f.close()

# draw plotbox
data = [time_lists["native"],
        time_lists["flutter"], time_lists["rn"]]
fig1, ax1 = plt.subplots(figsize=(4, 3))
ax1.boxplot(data, widths=[0.5]*3)
plt.grid(axis='y')
plt.xticks([1, 2, 3], ["Native", "Flutter", "React Native"])
plt.tight_layout()

plt.savefig("time-boxplot")
