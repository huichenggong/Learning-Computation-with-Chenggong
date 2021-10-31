#Run this script like this
#
#./downloadGMX.sh 2021.3
#
version=$1
wget https://ftp.gromacs.org/gromacs/gromacs-$version.tar.gz \
&& tar -xzf gromacs-$version.tar.gz \
&& echo "Package download Success"

wget https://ftp.gromacs.org/regressiontests/regressiontests-$version.tar.gz \
&& tar -xzf regressiontests-$version.tar.gz \
&& echo "Regression Test download Success"
