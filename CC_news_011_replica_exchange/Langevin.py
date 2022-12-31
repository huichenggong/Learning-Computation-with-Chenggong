# https://hockygroup.hosting.nyu.edu/exercise/langevin-dynamics.html
import numpy as np
import pandas as pd
import random


def double_well_energy_force(x, k, a, k2):
    # calculate the energy and force

    energy = 0.25 * k * ((x - a) ** 2) * ((x + a) ** 2) + k2 * x
    force = -k * x * (x - a) * (x + a) - k2  # -dE/dx
    return energy, force


# this is step A
def position_update(x, v, dt):
    x_new = x + v * dt / 2.
    return x_new


# this is step B
def velocity_update(v, F, dt):
    v_new = v + F * dt / 2.
    return v_new


def random_velocity_update(v, gamma, kBT, dt):
    R = np.random.normal()
    c1 = np.exp(-gamma * dt)
    c2 = np.sqrt(1 - c1 * c1) * np.sqrt(kBT)
    v_new = c1 * v + R * c2
    return v_new


def baoab(potential, max_steps, dt, gamma, kBT, initial_position, initial_velocity,
          save_frequency=100, **kwargs):
    x = initial_position
    v = initial_velocity
    t = 0
    step_number = 0
    positions = []
    velocities = []
    potential_energies = []
    save_times = []

    while (step_number <= max_steps):

        # B
        potential_E, force = potential(x, **kwargs)
        v = velocity_update(v, force, dt)

        # A
        x = position_update(x, v, dt)

        # O
        v = random_velocity_update(v, gamma, kBT, dt)

        # A
        x = position_update(x, v, dt)

        # B
        potential_E, force = potential(x, **kwargs)
        v = velocity_update(v, force, dt)

        if step_number % save_frequency == 0 and step_number > 0:
            kinetic = .5 * v * v
            e_total = kinetic + potential_E

            positions.append(x)
            velocities.append(v)
            potential_energies.append(potential_E)
            save_times.append(t)

        t = t + dt
        step_number = step_number + 1

    save_times = np.array(save_times, dtype=np.single)
    positions = np.array(positions, dtype=np.single)
    velocities = np.array(velocities, dtype=np.single)
    potential_energies = np.array(potential_energies, dtype=np.single)

    return save_times, positions, velocities, potential_energies


def exchange(kbT1, kbT2, E1, E2):
    p = np.exp((1 / kbT1 - 1 / kbT2) * (E1 - E2))
    p = min([p, 1])
    if random.uniform(0, 1) < p:
        return True
    else:
        return False


def replica_exchange(potential, max_steps, dt, gamma, kBT, initial_position, initial_velocity,
                     save_frequency=100, **kwargs):
    steps, re_attempt = max_steps
    kBT1, kBT2 = kBT
    times_1 = []
    position_1 = []
    vel_1 = []
    potential_E_1 = []
    position_2 = []
    vel_2 = []
    potential_E_2 = []
    exchange_result = []
    initial_position1 = initial_position
    initial_velocity1 = initial_velocity
    initial_position2 = initial_position
    initial_velocity2 = initial_velocity
    for i in range(re_attempt):
        times_1tmp, position_1tmp, vel_1tmp, potential_E_1tmp = baoab(
            potential, steps, dt, gamma, kBT1, initial_position1, initial_velocity1,
            save_frequency=save_frequency, **kwargs)
        initial_position1 = position_1tmp[-1]
        initial_velocity1 = vel_1tmp[-1]

        times_2tmp, position_2tmp, vel_2tmp, potential_E_2tmp = baoab(
            potential, steps, dt, gamma, kBT2, initial_position2, initial_velocity2,
            save_frequency=save_frequency, **kwargs)
        initial_position2 = position_2tmp[-1]
        initial_velocity2 = vel_2tmp[-1]

        # exchange?
        if exchange(kBT1, kBT2, potential_E_1tmp[-1], potential_E_2tmp[-2]):
            exchange_result.append(True)
            initial_velocity1, initial_velocity2 = initial_velocity2 / (kBT2/kBT1)**0.5, initial_velocity1 * (kBT2/kBT1)**0.5
            initial_position1, initial_position2 = initial_position2, initial_position1
        else:
            exchange_result.append(False)

        times_1tmp += i * dt * steps
        times_1 = np.concatenate((times_1, times_1tmp))
        position_1 = np.concatenate((position_1, position_1tmp))
        vel_1 = np.concatenate((vel_1, vel_1tmp))
        potential_E_1 = np.concatenate((potential_E_1, potential_E_1tmp))
        position_2 = np.concatenate((position_2, position_2tmp))
        vel_2 = np.concatenate((vel_2, vel_2tmp))
        potential_E_2 = np.concatenate((potential_E_2, potential_E_2tmp))

    return times_1, position_1, vel_1, potential_E_1, position_2, vel_2, potential_E_2, np.array(exchange_result)


def theoretical_distribution(potential, bins, kBT, **kwargs):
    x_axis = bins
    x_inti = (x_axis[:-1] + x_axis[1:]) / 2
    energy, f = potential(x_inti, **kwargs)
    density = np.exp(-1/kBT * energy)
    density = density / np.sum(density * (x_axis[1:] - x_axis[:-1]))
    return x_inti, density
