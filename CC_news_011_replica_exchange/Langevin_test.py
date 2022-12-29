import unittest
from Langevin import *


def double_well_energy_force(x, k, a, k2):
    # calculate the energy and force

    energy = 0.25 * k * ((x - a) ** 2) * ((x + a) ** 2) + k2 * x
    force = -k * x * (x - a) * (x + a) - k2
    return energy, force


class MyTestCase(unittest.TestCase):

    def test_baoab(self):
        kBT = 0.6
        initial_position = 2
        initial_velocity = 0.2
        gamma = 0.1
        dt = 0.05
        max_step = 50
        save_frequency = 10

        save_times, positions, velocities, total_energies, kinetic_energies, potential_energies = baoab(
            potential=double_well_energy_force,
            max_steps=max_step,
            dt=dt,
            gamma=gamma,
            kBT=kBT,
            initial_position=initial_position,
            initial_velocity=initial_velocity,
            save_frequency=save_frequency,
            k=1.2, a=2, k2=0.2
        )
        np.testing.assert_array_almost_equal(np.arange(0.5, 2.6, 0.5), save_times)
        energy, force = double_well_energy_force(positions, k=1.2, a=2, k2=0.2)
        np.testing.assert_array_almost_equal(energy, potential_energies)
        np.testing.assert_array_almost_equal(kinetic_energies, 0.5 * velocities ** 2)


if __name__ == '__main__':
    unittest.main()
