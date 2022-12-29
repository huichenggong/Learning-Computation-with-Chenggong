# https://hockygroup.hosting.nyu.edu/exercise/langevin-dynamics.html
import numpy as np
import pandas as pd


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
    kinetic_energies = []
    total_energies = []
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
            kinetic_energies.append(kinetic)
            total_energies.append(e_total)
            save_times.append(t)

        t = t + dt
        step_number = step_number + 1

    save_times = np.array(save_times, dtype=np.single)
    positions = np.array(positions, dtype=np.single)
    velocities = np.array(velocities, dtype=np.single)
    total_energies = np.array(total_energies, dtype=np.single)
    kinetic_energies = np.array(kinetic_energies, dtype=np.single)
    potential_energies = np.array(potential_energies, dtype=np.single)

    return save_times, positions, velocities, total_energies, kinetic_energies, potential_energies
