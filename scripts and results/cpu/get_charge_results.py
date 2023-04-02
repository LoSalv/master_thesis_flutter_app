#!/usr/bin/python3

import os
import matplotlib.pyplot as plt
import numpy as np

folders = ["native", "flutter", "rn"]

delta_charge_lists = {}
start_charge_lists = {}
end_charge_lists = {}

if os.path.isfile(f'delta-charge-plotbox.csv'):
    os.remove(f'delta-charge-plotbox.csv')

for folder in folders:
    if os.path.isfile(f'{folder}/delta-charge-list.csv'):
        os.remove(f'{folder}/delta-charge-list.csv')

    delta_charge_list = []
    start_charge_list = []
    end_charge_list = []

    for i in range(1, 11):
        f = open(f'{folder}/results{i}/stats', "r")
        for line in f:
            if "Delta charge" in line:
                words = line.split(" ")
                delta = int(words[3])
                delta_charge_list.append(delta)
            if "Start charge" in line:
                words = line.split(" ")
                delta = int(words[3])
                start_charge_list.append(delta)
            if "End charge" in line:
                words = line.split(" ")
                delta = int(words[3])
                end_charge_list.append(delta)

    f.close()

    delta_charge_lists[folder] = delta_charge_list
    start_charge_lists[folder] = start_charge_list
    end_charge_lists[folder] = end_charge_list

    f = open(f'{folder}/delta-charge-list.csv', "w")

    f.write("Number,Start charge counter,End charge counter,Delta charge counter\n")

    for i in range(10):
        start = str(start_charge_list[i])
        end = str(end_charge_list[i])
        delta = str(delta_charge_list[i])
        f.write(f'{str(i+1)},{start},{end},{delta}\n')

    f.close()

sd = {}
min_values = {}
max_values = {}
average = {}

# get sd, min and max
for framework in folders:
    list = delta_charge_lists[framework]
    min_values[framework] = min(list)
    max_values[framework] = max(list)
    average[framework] = sum(list) / len(list)
    sd[framework] = np.std(list)


f = open(f'delta-charge-list.csv', "w")

f.write("UI,Native,Flutter,React Native\n")
for i in range(10):
    delta_native = str(delta_charge_lists["native"][i])
    delta_flutter = str(delta_charge_lists["flutter"][i])
    delta_rn = str(delta_charge_lists["rn"][i])
    f.write(f'{str(i+1)},{delta_native},{delta_flutter},{delta_rn}\n')


f.write(
    f'"Average",{str(average["native"])},{str(average["flutter"])},{str(average["rn"])}\n')
f.write(
    f'"Max",{str(max_values["native"])},{str(max_values["flutter"])},{str(max_values["rn"])}\n')
f.write(
    f'"Min",{str(min_values["native"])},{str(min_values["flutter"])},{str(min_values["rn"])}\n')
f.write(
    f'"SD",{sd["native"]:.2f},{sd["flutter"]:.2f},{sd["rn"]:.2f}\n')

f.close()

# draw plotbox
data = [delta_charge_lists["native"],
        delta_charge_lists["flutter"], delta_charge_lists["rn"]]

fig1, ax1 = plt.subplots(figsize=(4, 3))
ax1.boxplot(data, widths=[0.5]*3)
plt.xticks([1, 2, 3], ["Native", "Flutter", "React Native"])
plt.grid(axis='y')
plt.tight_layout()

# plt.show()
plt.savefig("delta-charge-boxplot")
