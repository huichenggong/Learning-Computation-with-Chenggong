# 1. Register on chemshell wesite  
# 2. Download the package
# 3. Extract (unzip) .tar.gz
```bash
tar -xvzf chemsh-py-21.0.1.tar_0.gz
```
# 4. install dependency (ubuntu)
```bash
sudo apt install gfortran build-essential cmake
sudo apt install libblas-dev liblapack-dev python3-dev python3-pip
```
# 5. Compile
```bash
./setup --fc gfortran --cc gcc
```
