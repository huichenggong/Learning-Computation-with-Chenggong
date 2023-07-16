#include <cmath>
#include <iostream>
#include "gromacs/fileio/xtcio.h"

// Include the necessary headers for your XTC reading functions here

// A function to calculate the Euclidean distance between two 3D points
double distance(const rvec& a, const rvec& b) {
    double dx = a[0] - b[0];
    double dy = a[1] - b[1];
    double dz = a[2] - b[2];
    return std::sqrt(dx*dx + dy*dy + dz*dz);
}

int main() {
    const char* filename = "../../data/fix_atom_c_40ps.xtc";
    struct t_fileio* fio = open_xtc(filename, "r");

    if (fio == nullptr) {
        std::cerr << "Failed to open file: " << filename << std::endl;
        return 1;
    }

    int natoms;
    int64_t step;
    real time;
    matrix box;
    rvec* x;
    real prec;
    gmx_bool bOK;

    std::cout << "Step, " << "CYS159-CYS284_A,CYS159-CYS284_B,PRO155-GLY280_A,PRO155-GLY280_B" << std::endl;

    if (!read_first_xtc(fio, &natoms, &step, &time, box, &x, &prec, &bOK)) {
        std::cerr << "Failed to read first frame from file: " << filename << std::endl;
        close_xtc(fio);
        return 1;
    }

    do {
        // Calculate and print the distance between the first two atoms
        // in the frame. Adjust these indices as necessary for your use case.
        // 2002 8029 6040 3991
        // 1944 7965 5982 3927
        std::cout << step << 
        ", " <<distance(x[2002], x[8029]) << ", "<< distance(x[6040], x[3991]) <<
        ", " <<distance(x[1944], x[7965]) << ", "<< distance(x[5982], x[3927]) <<
        std::endl;
    } while (read_next_xtc(fio, natoms, &step, &time, box, x, &prec, &bOK));

    close_xtc(fio);
    return 0;
}
