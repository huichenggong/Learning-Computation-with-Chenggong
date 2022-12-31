cd ../
for i in {12..23}
do
  echo $i
  python test_dstribution.py -fname $i &
done