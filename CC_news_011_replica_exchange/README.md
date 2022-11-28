# boltzmann distribution
$$p_i=\frac{exp(-\varepsilon^i/kT)}{\sum_{j=1} exp(-\varepsilon_j/kT)}
=\frac{exp(-\varepsilon^i/kT)}{Q_T}
$$

# Replica exchange under NVT
在T1中找到S1且在T2中找到S2的条件下在T1中找到S2,在T2中找到S1的概率  
The probability of finding S2 from T1 and S1 from T2 when finding S1 from T1 and S2 from T2.

$$
\frac{P(T_2S_1,T_1S_2)}{P(T_1S_1,F_2S_2)}
$$  

$$
=\frac{\frac{1}{Q_1Q_2} exp(-\frac{U_1}{kT_2}-\frac{U_2}{kT_2})}{\frac{1}{Q_1Q_2}exp(\frac{U_1}{kT_1}-\frac{U_2}{kT_2})}
$$  

$$
=exp(+\frac{U_1}{kT_1}+\frac{U_2}{kT_2}-\frac{U_1}{kT_2}-\frac{U_2}{kT_1})
$$  

$$
=exp[(\frac{1}{kT_1}-\frac{1}{kT_2})(U1-U2)]
$$  

$$
P(1 \leftrightarrow 2)=\min\left(1,\exp\left[\left(\frac{1}{k_B T_1} - \frac{1}{k_B T_2}\right)(U_1 - U_2)\right] \right)
$$  

[Gromacs Manual](https://manual.gromacs.org/current/reference-manual/algorithms/replica-exchange.html)
