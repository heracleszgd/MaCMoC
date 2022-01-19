# MaCMoC
MaCMoC (Marcov-Chain Monte Carlo calculator) is coded with Matlab, simulating annealing Metropolis Monte Carlo and predict Tc of 2D (3D possible) magnets, including cubic / triangular / hexagonal (honeycomb) lattices. It's models include Ising / Planar / Heisenberg + single ion ansitropy (SIA) / Heisenberg + SIA + anisotropic exchange.  

This small but efficient & robust code is open-sourced to expread some coding tricks about Monte Carlo applications in phase change simulations. Let's endeavour for a free package coded by peers together, that could benefit youngs sailing in computational physics.

## Usage
1. Please modify the constants and parameters in the 1st block of mc.m, and run it with 'mc' in Matlab (current folder).  
   ("constants" should be obtained by first principles. Tutorials can be found in Equations.pdf. and the SuppMat in original paper)
2. A timebar appears showing how much time left.
3. Four summarizing figures appear (average magnetic moments, specific heat, magnetic susceptibility, average energy). They and the raw data will be saved in a new folder.
-  More tips are commented in mc.m

## Efficiency
-  Version: Please use the newest version of Matlab, they may be much faster than old ones. Ising model is super fast.
-  Parallel: In principle you can modify the code to a parallel version following the prompt comments (based on parfor, just for fun).

## Validation
-  With constants obtained from hybrid functional + SOC crazy calculations, MaCMoC precisely predicts the T<sub>C</sub> = 60 K of monolayer VI<sub>3</sub> [10.1103/PhysRevB.103.014438]. (experimentally observed by Prof. Xiaodong Xu [10.1021/acs.nanolett.1c03027]).  
-  Reproduces the result of T<sub>C</sub> = 50 K with GGA_PBE + U calculations in monolayer CrI<sub>3</sub> [10.1021/jacs.8b07879].
-  Concides well with the planar cubic lattice simulation [10.1103/PhysRevB.20.3761].

## Publications
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

## How to cite
If you publish a work with MaCMoC's help, please kindly cite the original paper:  
"Difference in magnetic anisotropy of the ferromagnetic monolayers VI<sub>3</sub> and CrI<sub>3</sub>",  
G.-D. Zhao, X. Liu, T. Hu, F. Jia, Y. Cui, W. Wu, M.-H. Whangbo, and W. Ren, ***Phys. Rev. B*** 103, 014438 (2021).  
https://doi.org/10.1103/PhysRevB.103.014438

## Contribution
Guo-Dong Zhao, zzhaoguodong@163.com  
GD gratefully thanks Dr. Musen Li for his precious suggestions.  
This code is under GPL-v3.0 license, and welcome promotions made by others.

PS: Extra-terms such as magnetic field and Dzyaloshinsky-Moriya interaction (DMI) should be very easy to be included, but I am too bazy to benchmark. Call for help.
