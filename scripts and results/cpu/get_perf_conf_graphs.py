#!/usr/bin/python3
import seaborn as sns
import matplotlib.pyplot as plt
from IPython.display import display
import pandas as pd

folders = ["native", "flutter", "rn"]
frameworks = ["Native", "Flutter", "React Native"]

data_flutter = {"Time": [], "CPU Usage": [], "RAM": []}
data_react = {"Time": [], "CPU Usage": [], "RAM": []}
data_native = {"Time": [], "CPU Usage": [], "RAM": []}

data_fw = [data_native, data_flutter, data_react]

for i, folder in enumerate(folders):
    framework = frameworks[i]
    list_results = data_fw[i]

    for i in range(1, 11):
        f = open(f'{folder}/results{i}/cpu', "r")
        for j, line in enumerate(f):
            list_results["Time"].append(j)
            list_results["CPU Usage"].append(float(line))
        f.close()

        f = open(f'{folder}/results{i}/rss', "r")
        for j, line in enumerate(f):
            list_results["RAM"].append(float(line))
        f.close()

data_flutter = pd.DataFrame(data=data_flutter)
data_react = pd.DataFrame(data=data_react)
data_native = pd.DataFrame(data=data_native)

fig, axs = plt.subplots(3, sharex=True, sharey=True,
                        constrained_layout=True, dpi=200)

y_lim = 10

for i, ax in enumerate(axs):
    ax.grid(axis='y')
    # ax.set_ylim([0, y_lim])
    ax.set_ylabel(frameworks[i])
    ax.set_xlabel("Time (s)")

sns.lineplot(data=data_native, x="Time", y="CPU Usage", ax=axs[0])
sns.lineplot(data=data_flutter, x="Time", y="CPU Usage", ax=axs[1])
sns.lineplot(data=data_react, x="Time", y="CPU Usage",  ax=axs[2])

plt.savefig("confidence-cpu")

fig, axs = plt.subplots(3, sharex=True, sharey=True,
                        constrained_layout=True, dpi=200)
# fig.tight_layout()

y_lim = 10

for i, ax in enumerate(axs):
    ax.grid(axis='y')
    # ax.set_ylim([0, y_lim])
    ax.set_ylabel(frameworks[i])
    ax.set_xlabel("Time (s)")

sns.lineplot(data=data_native, x="Time", y="RAM", ax=axs[0])
sns.lineplot(data=data_flutter, x="Time", y="RAM", ax=axs[1])
sns.lineplot(data=data_react, x="Time", y="RAM",  ax=axs[2])

plt.savefig("confidence-ram")
