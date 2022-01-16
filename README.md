# MaCMoC
MatMoc is coded with Matlab, simulating annealing Metropolis Monte-Carlo and predict Tc of 2D (3D possible) magnets. 

Usage:
please modify the parameters in the header of mc.m, and run it with 'mc' in Matlab.
"parameters" should be obtained by first principles, and some suggestions are provided in Equations.pdf.

Efficiency:
Version: Please use the newest version of Matlab, they may be much faster than old ones.
Parralel: In principle you can modify the code to a parallel version following the prompt comments.

Validation:
1. With parameters obtained from hybrid functional + SOC crazy calculations, MaCMoC predicts precisely the Tc = 60 K 
   of monolayer VI3 [10.1103/PhysRevB.103.014438], which is latter observed in an experiment [10.1021/acs.nanolett.1c03027].
2. Reproduces the result of Tc = 50 K with GGA_PBE + U calculations in monolayer CrI3 [doi.org/10.1021/jacs.8b07879].

Publications:
1. G.-D. Zhao, X. Liu, T. Hu, F. Jia, Y. Cui, W. Wu, M.-H. Whangbo, and W. Ren, Phys. Rev. B 103, 014438 (2021).
   https://doi.org/10.1103/PhysRevB.103.014438
2. 

Acknowlegement:
If you publish a work with MaCMoC's help, please cite our original paper:
G.-D. Zhao, X. Liu, T. Hu, F. Jia, Y. Cui, W. Wu, M.-H. Whangbo, and W. Ren, Phys. Rev. B 103, 014438 (2021).
https://doi.org/10.1103/PhysRevB.103.014438

