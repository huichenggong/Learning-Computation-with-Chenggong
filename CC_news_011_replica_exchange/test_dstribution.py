from Langevin import *
import pandas as pd
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-fname",
                    dest="fname",
                    required=True,
                    type=int)
args = parser.parse_args()

initial_position = random.uniform(-2, 2)
initial_velocity = random.uniform(-0.2, 0.2)
print("x", initial_position)
print("v", initial_velocity)
gamma = 0.1
dt = 0.05
max_step = 2000000
save_frequency = 20
k = 1.2
a = 2
k2 = 0.2


step = 0.01
x_axis = np.arange(-3.5, 3.5001, step)
x_inti = (x_axis[:-1] + x_axis[1:]) / 2

# low temperature un-bias
save_times, positions, velocities, potential_energies = baoab(
    potential=double_well_energy_force,
    max_steps=max_step,
    dt=dt,
    gamma=gamma,
    kBT=0.6,
    initial_position=initial_position,
    initial_velocity=initial_velocity,
    save_frequency=save_frequency,
    k=k, a=a, k2=k2
)
density_sim, y = np.histogram(positions, bins=x_axis)
density_sim = density_sim / np.sum(density_sim * step)
density_sim1 = density_sim

# high temperature un bias
save_times, positions, velocities, potential_energies = baoab(
    potential=double_well_energy_force,
    max_steps=max_step,
    dt=dt,
    gamma=gamma,
    kBT=2.0,
    initial_position=initial_position,
    initial_velocity=initial_velocity,
    save_frequency=save_frequency,
    k=k, a=a, k2=k2
)
density_sim, y = np.histogram(positions, bins=x_axis)
density_sim = density_sim / np.sum(density_sim * step)
density_sim2 = density_sim


max_steps = (1000, 1000)  # (steps, RE attempts)
kBT = (0.6, 2.0)
times_1, position_1, vel_1, potential_E_1, position_2, vel_2, potential_E_2, exchange_result = replica_exchange(
            double_well_energy_force, max_steps, dt, gamma, kBT, initial_position, initial_velocity,
            save_frequency=10, k=k, a=a, k2=k2)
print("Exchange success rate : ", exchange_result.sum() / exchange_result.shape[0])

density_RE1, y = np.histogram(position_1, bins=x_axis)
density_RE1 = density_RE1 / np.sum(density_RE1 * step)
density_RE2, y = np.histogram(position_2, bins=x_axis)
density_RE2 = density_RE1 / np.sum(density_RE2 * step)

df = pd.DataFrame({"x1":x_inti,
                   "Dist1": density_sim1,
                   "Dist2": density_sim2,
                   "Re1": density_RE1,
                   "Re2": density_RE2,
                   })

df.to_csv("traj02/traj_%03d.csv"%args.fname)
