# MaCMoC
MaCMoC (Marcov-Chain Monte Carlo calculator) is coded with Matlab, simulating annealing Metropolis Monte Carlo and predict Tc of 2D (3D possible) magnets, including cubic / triangular / hexagonal (honeycomb) lattices. It's models include Ising / Heisenberg + single ion ansitropy (SIA) / Heisenberg + SIA + anisotropic exchange.

## Usage:
1. Please modify the parameters in the header of mc.m, and run it with 'mc' in Matlab (current folder).  
   "parameters" should be obtained by first principles, and some suggestions are provided in Equations.pdf.
2. A timebar appears showing how much time left.
3. Four summarizing figures appear. They and the data will be saved in a new folder.

## Efficiency:
Version: Please use the newest version of Matlab, they may be much faster than old ones.  
Parralel: In principle you can modify the code to a parallel version if following the prompt comments (parfor, just for fun).

## Validation:
1. With parameters obtained from hybrid functional + SOC crazy calculations, MaCMoC predicts precisely the T<sub>C</sub> = 60 K  
   of monolayer VI<sub>3</sub> [10.1103/PhysRevB.103.014438], which is latter observed in an experiment [10.1021/acs.nanolett.1c03027].  
2. Reproduces the result of T<sub>C</sub> = 50 K with GGA_PBE + U calculations in monolayer CrI<sub>3</sub> [10.1021/jacs.8b07879].

## Publications:
-  G.-D. Zhao, X. Liu, T. Hu, F. Jia, Y. Cui, W. Wu, M.-H. Whangbo, and W. Ren, ***Phys. Rev. B*** 103, 014438 (2021).  
   https://doi.org/10.1103/PhysRevB.103.014438
-  X. Cheng, S. Xu, F. Jia, G. Zhao, M. Hu, W. Wu, and W. Ren, ***Phys. Rev. B*** 104, 104417 (2021).  
   https://doi.org/10.1103/PhysRevB.104.104417
-  T. Jiang, T. Hu, G.-D. Zhao, Y. Li, S. Xu, C. Liu, Y. Cui, and W. Ren, ***Phys. Rev. B*** 104, 075147 (2021).  
   https://doi.org/10.1103/PhysRevB.104.075147
-  Y. Li, C. Liu, G.-D. Zhao, T. Hu, and W. Ren, ***Phys. Rev. B*** 104, L060405 (2021).  
   https://doi.org/10.1103/PhysRevB.104.L060405
-  C. Liu, G. Zhao, T. Hu, L. Bellaiche, and W. Ren, ***Phys. Rev. B*** 103, L081403 (2021).  
   https://doi.org/10.1103/PhysRevB.103.L081403
-  C. Liu, G. Zhao, T. Hu, Y. Chen, S. Cao, L. Bellaiche, and W. Ren, ***Phys. Rev. B*** 104, L241105 (2021).  
   https://doi.org/10.1103/PhysRevB.104.L241105
-  S. Xu, F. Jia, G. Zhao, T. Hu, S. Hu, and W. Ren, ***J. Phys. Chem. C*** 125, 6157 (2021).  
   https://doi.org/10.1021/acs.jpcc.0c08989
-  S. Xu, F. Jia, G. Zhao, W. Wu, and W. Ren, ***J. Mater. Chem. C*** 9, 9130 (2021).  
   https://doi.org/10.1039/D1TC02238E
-  M. Hu, S. Xu, C. Liu, G. Zhao, J. Yu, and W. Ren, ***Nanoscale*** 12, 24237 (2020).  
   https://doi.org/10.1039/D0NR06268E  
...

## Acknowlegement:
If you publish a work with MaCMoC's help, please cite our original paper:  
G.-D. Zhao, X. Liu, T. Hu, F. Jia, Y. Cui, W. Wu, M.-H. Whangbo, and W. Ren, ***Phys. Rev. B*** 103, 014438 (2021).  
https://doi.org/10.1103/PhysRevB.103.014438

## Contribution:
Guo-Dong Zhao, zzhaoguodong@163.com  
This code is under GPL-v3.0 license, and welcome promotions made by others.
