import unittest

import numpy as np
import matplotlib.pyplot as plt
from Langevin import *
from matplotlib.image import NonUniformImage
import pandas as pd


class MyTestCase(unittest.TestCase):

    def test_baoab(self):
        # assume mass = 1
        kBT = 0.6
        initial_position = 2
        initial_velocity = 0.2
        gamma = 0.1
        dt = 0.05
        max_step = 50
        save_frequency = 10
        k = 1.2
        a = 2
        k2 = 0.2

        save_times, positions, velocities, potential_energies = baoab(
            potential=double_well_energy_force,
            max_steps=max_step,
            dt=dt,
            gamma=gamma,
            kBT=kBT,
            initial_position=initial_position,
            initial_velocity=initial_velocity,
            save_frequency=save_frequency,
            k=k, a=a, k2=k2
        )
        np.testing.assert_array_almost_equal(np.arange(0.5, 2.6, 0.5), save_times)
        energy, force = double_well_energy_force(positions, k=1.2, a=2, k2=0.2)
        np.testing.assert_array_almost_equal(energy, potential_energies)

    def test_plot_phase_space(self):
        """
        plot the distribution in (x,p) phase space
        """
        kBT = 1.2
        initial_position = 2
        initial_velocity = 0.2
        gamma = 0.1
        dt = 0.05
        max_step = 1000000
        save_frequency = 10
        k = 1.2
        a = 2
        k2 = 0.2

        save_times, positions, velocities, potential_energies = baoab(
            potential=double_well_energy_force,
            max_steps=max_step,
            dt=dt,
            gamma=gamma,
            kBT=kBT,
            initial_position=initial_position,
            initial_velocity=initial_velocity,
            save_frequency=save_frequency,
            k=k, a=a, k2=k2
        )
        # 2D histogram using position and velocities
        xedge = np.arange(np.floor(np.min(positions)),
                          np.floor(np.max(positions)) + 1,
                          0.05
                          )
        yedge = np.arange(np.floor(np.min(velocities)),
                          np.floor(np.max(velocities)) + 1,
                          0.05
                          )
        H, xedges, yedges = np.histogram2d(positions, velocities, bins=(xedge, yedge))
        H = H.T
        fig = plt.figure(1, dpi=900, figsize=(4, 5))
        # ax = fig.add_subplot(121, title='imshow: square bins')
        # plt.imshow(H, interpolation='nearest', origin='lower',
        #           extent=[xedges[0], xedges[-1], yedges[0], yedges[-1]])
        ax = fig.add_subplot(111, title='Distribution on Phase Space',
                             aspect='equal')
        X, Y = np.meshgrid(xedges, yedges)
        ax.pcolormesh(X, Y, H)
        plt.savefig("001_phase_space.png")

        # distribution on potential energy axis
        step = 0.01
        x_axis = np.arange(-3.1, 3.0001, step)
        x_inti = (x_axis[:-1] + x_axis[1:]) / 2

        energy, f = double_well_energy_force(x_inti, k=k, a=a, k2=k2)
        _, density = theoretical_distribution(double_well_energy_force, x_axis, kBT, k=k, a=a, k2=k2)

        density_sim, y = np.histogram(positions, bins=x_axis)
        density_sim = density_sim / np.sum(density_sim * step)
        plt.figure(2, dpi=900)
        plt.plot(x_inti, density, label="theory")
        plt.plot(x_inti, density_sim, label="simulation")
        plt.legend()
        plt.grid()
        plt.savefig("002_distribution.png")

    def test_plot_distribution_RE(self):
        kBT = (0.7, 1.3)
        initial_position = 2
        initial_velocity = 0.2
        gamma = 0.1
        dt = 0.05
        max_steps = (100, 5000)  # (steps, RE attempts)
        save_frequency = 10
        k = 1.2
        a = 2
        k2 = 0.2
        times_1, position_1, vel_1, potential_E_1, position_2, vel_2, potential_E_2, exchange_result = replica_exchange(
            double_well_energy_force, max_steps, dt, gamma, kBT, initial_position, initial_velocity,
            save_frequency=10, k=k, a=a, k2=k2)
        print("Exchange success rate : ", exchange_result.sum() / exchange_result.shape[0])

        plt.figure(3, dpi=900, figsize=(8, 9))
        step = 0.01
        x_axis = np.arange(-3.5, 3.5001, step)
        x_inti, density_kBT0 = theoretical_distribution(double_well_energy_force, x_axis, kBT[0], k=k, a=a, k2=k2)
        x_inti, density_kBT1 = theoretical_distribution(double_well_energy_force, x_axis, kBT[1], k=k, a=a, k2=k2)

        plt.subplot(2, 1, 1)
        plt.plot(x_inti, density_kBT0, label="kBT=%.1f theoretical"%kBT[0])
        plt.plot(x_inti, density_kBT1, label="kBT=%.1f theoretical"%kBT[1])
        density_sim, y = np.histogram(position_1, bins=x_axis)
        density_sim = density_sim / np.sum(density_sim * step)
        plt.plot(x_inti, density_sim, label="kBT=0.8 simulated")
        plt.legend()

        plt.subplot(2, 1, 2)
        plt.plot(x_inti, density_kBT0, label="kBT=%.1f theoretical"%kBT[0])
        plt.plot(x_inti, density_kBT1, label="kBT=%.1f theoretical"%kBT[1])
        density_sim, y = np.histogram(position_2, bins=x_axis)
        density_sim = density_sim / np.sum(density_sim * step)
        plt.plot(x_inti, density_sim, label="kBT=1.2 simulated")
        plt.legend()

        plt.savefig("003_RE_distribution.png")
        df = pd.DataFrame({"x1":x_inti,
                           "Dist1": density_kBT0,
                           "Dist2": density_kBT1,
                           })
        df.to_csv("003_RE_distribution.csv")


    def test_plot_distribution_theoretical(self):
        k = 1.2
        a = 2
        k2 = 0.2
        step = 0.01
        x_axis = np.arange(-3.5, 3.5001, step)
        x_inti, density_kBT0 = theoretical_distribution(double_well_energy_force, x_axis, 0.8, k=k, a=a, k2=k2)
        x_inti, density_kBT1 = theoretical_distribution(double_well_energy_force, x_axis, 1.2, k=k, a=a, k2=k2)
        x_inti, density_kBT2 = theoretical_distribution(double_well_energy_force, x_axis, 1.7, k=k, a=a, k2=k2)

        plt.figure(4, dpi=900)
        plt.plot(x_inti, density_kBT0, label=" kBT=0.8")
        self.assertAlmostEqual(np.sum(step * density_kBT0), 1)
        plt.plot(x_inti, density_kBT1, label=" kBT=1.2")
        self.assertAlmostEqual(np.sum(step * density_kBT1), 1)
        plt.plot(x_inti, density_kBT2, label=" kBT=1.7")
        self.assertAlmostEqual(np.sum(step * density_kBT2), 1)

        plt.legend()
        plt.savefig("004_distribution_theoretical.png")


if __name__ == '__main__':
    unittest.main()
