#!/usr/bin/python3

import os
import matplotlib.pyplot as plt
import numpy as np

folders = ["native", "flutter", "rn"]

cpu_average_lists = {}
ram_average_lists = {}
rss_average_lists = {}

if os.path.isfile(f'perf-average-list.csv'):
    os.remove(f'perf-average-list.csv')

for folder in folders:
    if os.path.isfile(f'{folder}/perf-average-list.csv'):
        os.remove(f'{folder}/perf-average-list.csv')

    cpu_average_list = []
    ram_average_list = []
    rss_average_list = []

    for i in range(1, 11):
        f = open(f'{folder}/results{i}/stats', "r")
        for line in f:
            if "CPU" in line:
                list = cpu_average_list
            if "MEM" in line:
                list = ram_average_list
            if "RSS" in line:
                list = rss_average_list
            if "Average" in line:
                words = line.split(" ")
                rss = float(words[1])
                list.append(rss)

    f.close()

    cpu_average_lists[folder] = cpu_average_list
    ram_average_lists[folder] = ram_average_list
    rss_average_lists[folder] = rss_average_list

    f = open(f'{folder}/perf-average-list.csv', "w")

    f.write("Number,CPU usage percentage average,RAM usage percentage average,RSS occupancy average\n")

    for i in range(10):
        cpu = str(cpu_average_list[i])
        ram = str(ram_average_list[i])
        rss = str(rss_average_list[i])
        f.write(f'{str(i+1)},{cpu},{ram},{rss}\n')

    f.close()

sd_cpu = {}
min_values_cpu = {}
max_values_cpu = {}
average_cpu = {}

# get sd, min and max
for framework in folders:
    list = cpu_average_lists[framework]
    min_values_cpu[framework] = min(list)
    max_values_cpu[framework] = max(list)
    average_cpu[framework] = sum(list) / len(list)
    sd_cpu[framework] = np.std(list)

sd_rss = {}
min_values_rss = {}
max_values_rss = {}
average_rss = {}

# get sd, min and max
for framework in folders:
    list = rss_average_lists[framework]
    min_values_rss[framework] = min(list)
    max_values_rss[framework] = max(list)
    average_rss[framework] = sum(list) / len(list)
    sd_rss[framework] = np.std(list)

sd_ram = {}
min_values_ram = {}
max_values_ram = {}
average_ram = {}

# get sd, min and max
for framework in folders:
    list = ram_average_lists[framework]
    min_values_ram[framework] = min(list)
    max_values_ram[framework] = max(list)
    average_ram[framework] = sum(list) / len(list)
    sd_ram[framework] = np.std(list)

f = open(f'perf-average-list.csv', "w")

f.write("CPU,Native,Flutter,React Native")
f.write(",,")
f.write("RAM,Native,Flutter,React Native")
f.write(",,")
f.write("RSS,Native,Flutter,React Native")
f.write("\n")

for i in range(10):
    native = "{: .3f}".format(cpu_average_lists["native"][i])
    flutter = "{: .3f}".format(cpu_average_lists["flutter"][i])
    rn = "{: .3f}".format(cpu_average_lists["rn"][i])
    f.write(f'{str(i+1)},{native},{flutter},{rn}')

    f.write(",,")

    native = "{: .3f}".format(ram_average_lists["native"][i])
    flutter = "{: .3f}".format(ram_average_lists["flutter"][i])
    rn = "{: .3f}".format(ram_average_lists["rn"][i])
    f.write(f'{str(i+1)},{native},{flutter},{rn}')

    f.write(",,")

    native = "{: .3f}".format(rss_average_lists["native"][i])
    flutter = "{: .3f}".format(rss_average_lists["flutter"][i])
    rn = "{: .3f}".format(rss_average_lists["rn"][i])
    f.write(f'{str(i+1)},{native},{flutter},{rn}\n')

f.write(
    f'"Average",{str(average_cpu["native"])},{str(average_cpu["flutter"])},{str(average_cpu["rn"])}')
f.write(",,")
f.write(
    f'"Average",{str(average_ram["native"])},{str(average_ram["flutter"])},{str(average_ram["rn"])}')
f.write(",,")
f.write(
    f'"Average",{str(average_rss["native"])},{str(average_rss["flutter"])},{str(average_rss["rn"])}')
f.write("\n")

f.write(
    f'"Max",{str(max_values_cpu["native"])},{str(max_values_cpu["flutter"])},{str(max_values_cpu["rn"])}')
f.write(",,")
f.write(
    f'"Max",{str(max_values_ram["native"])},{str(max_values_ram["flutter"])},{str(max_values_ram["rn"])}')
f.write(",,")
f.write(
    f'"Max",{str(max_values_rss["native"])},{str(max_values_rss["flutter"])},{str(max_values_rss["rn"])}')
f.write("\n")

f.write(
    f'"Min",{str(min_values_cpu["native"])},{str(min_values_cpu["flutter"])},{str(min_values_cpu["rn"])}')
f.write(",,")
f.write(
    f'"Min",{str(min_values_ram["native"])},{str(min_values_ram["flutter"])},{str(min_values_ram["rn"])}')
f.write(",,")
f.write(
    f'"Min",{str(min_values_rss["native"])},{str(min_values_rss["flutter"])},{str(min_values_rss["rn"])}')
f.write("\n")

f.write(
    f'"SD",{sd_cpu["native"]:.2f},{sd_cpu["flutter"]:.2f},{sd_cpu["rn"]:.2f}')
f.write(",,")
f.write(
    f'"SD",{sd_ram["native"]:.2f},{sd_ram["flutter"]:.2f},{sd_ram["rn"]:.2f}')
f.write(",,")
f.write(
    f'"SD",{sd_rss["native"]:.2f},{sd_rss["flutter"]:.2f},{sd_rss["rn"]:.2f}')
f.write("\n")


f.close()

# draw plotbox
data = [cpu_average_lists["native"],
        cpu_average_lists["flutter"], cpu_average_lists["rn"]]
fig1, ax1 = plt.subplots(figsize=(4, 3))
ax1.boxplot(data, widths=[0.5]*3)
plt.grid(axis='y')
plt.xticks([1, 2, 3], ["Native", "Flutter", "React Native"])
plt.tight_layout()

plt.savefig("cpu-average-boxplot")

# data = [ram_average_lists["native"],
#         ram_average_lists["flutter"], ram_average_lists["rn"]]
# fig1, ax1 = plt.subplots()
# ax1.boxplot(data)
# plt.grid(axis='y')
# plt.xticks([1, 2, 3], ["Native", "Flutter", "React Native"])
# plt.savefig("ram-average-boxplot")

data = [rss_average_lists["native"],
        rss_average_lists["flutter"], rss_average_lists["rn"]]
fig1, ax1 = plt.subplots(figsize=(4, 3))
plt.grid(axis='y')
ax1.boxplot(data, widths=[0.5]*3)
plt.xticks([1, 2, 3], ["Native", "Flutter", "React Native"])
plt.tight_layout()

plt.savefig("rss-average-boxplot")
