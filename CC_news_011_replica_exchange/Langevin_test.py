import unittest

import numpy as np
import matplotlib.pyplot as plt
from Langevin import *
from matplotlib.image import NonUniformImage




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
        kBT = 1.0
        initial_position = 2
        initial_velocity = 0.2
        gamma = 0.1
        dt = 0.05
        max_step = 10000000
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
                          np.floor(np.max(positions))+1,
                          0.05
                          )
        yedge = np.arange(np.floor(np.min(velocities)),
                          np.floor(np.max(velocities)) + 1,
                          0.05
                          )
        H, xedges, yedges = np.histogram2d(positions, velocities, bins=(xedge, yedge))
        H = H.T
        fig = plt.figure(1, dpi=300, figsize=(4, 5))
        #ax = fig.add_subplot(121, title='imshow: square bins')
        #plt.imshow(H, interpolation='nearest', origin='lower',
        #           extent=[xedges[0], xedges[-1], yedges[0], yedges[-1]])
        ax = fig.add_subplot(111, title='Distribution on Phase Space',
                             aspect='equal')
        X, Y = np.meshgrid(xedges, yedges)
        ax.pcolormesh(X, Y, H)
        plt.savefig("001_phase_space.png")


        # distribution on potential energy axis

        # distribution on total energy axis




if __name__ == '__main__':
    unittest.main()
