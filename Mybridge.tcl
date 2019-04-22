wipe 					                                                      
model BasicBuilder -ndm 3 -ndf 6;

source LibUnits.tcl;
# -----------------����ڵ�-----------------------------
#Beam Node ����
source NodeBeam.tcl;

#Pier Node �Ŷ�
source NodePier.tcl;

# Node ����
source NodeSpring.tcl

# -----------------����Լ������-----------------------------
fix 94 1 1 1 1 1 1
fix 104 1 1 1 1 1 1
fix 112 1 1 1 1 1 1
fix 126 1 1 1 1 1 1
# -----------------�����������-----------------------------
source EqualSpring.tcl
# -----------------��������ת��-----------------------------
# ����ת��
geomTransf Linear 1 0 0 1
geomTransf Linear 2 0 1 0 
geomTransf Linear 3 1 0 0 
# -----------------�������----------------------
source SectionElastic.tcl
# -----------------����ģ�� ����ģ��--------------
set poisson 0.20
set E0 [expr 34.5*$GPa]
set G0 [expr $E0/(2*(1+$poisson))]
set E1 [expr 34.5*$GPa]
set G1 [expr $E1/(2*(1+$poisson))]
set E2 [expr 32.5*$GPa]
set G2 [expr $E2/(2*(1+$poisson))]
set E3 [expr 31.5*$GPa]
set G3 [expr $E3/(2*(1+$poisson))]
# -----------------���嵥Ԫ--------------------
source EleBeam.tcl
source ElePier.tcl
source Elerigid.tcl
# -----------------��������--------------------
source MassBeam.tcl
source MassPier.tcl
# -----------------�����㳤�ȵ�Ԫ----------------

uniaxialMaterial Steel01 1 10000000 1000000 0
uniaxialMaterial Steel01 2 10000000 1000000 0
uniaxialMaterial Steel01 3 10000000 1000000 0
uniaxialMaterial Steel01 4 10000000 1000000 0

# ��Ԫ����	EleNumber	Inode	Jnode		-mat1	-mat2		dir1	dir2
equalDOF	127	128	3	4	5	6
equalDOF	129	130	3	4	5	6
equalDOF	131	132	3	4	5	6
equalDOF	133	134	3	4	5	6
equalDOF	135	136	3	4	5	6
equalDOF	137	138	3	4	5	6
equalDOF	139	140	3	4	5	6
equalDOF	141	142	3	4	5	6

element zeroLength	1000	127	128	-mat	1	1	-dir	1	2
element zeroLength	1001	129	130	-mat	1	1	-dir	1	2
element zeroLength	1002	131	132	-mat	2	2	-dir	1	2
element zeroLength	1003	133	134	-mat	2	2	-dir	1	2
element zeroLength	1004	135	136	-mat	3	3	-dir	1	2
element zeroLength	1005	137	138	-mat	3	3	-dir	1	2
element zeroLength	1006	139	140	-mat	4	4	-dir	1	2
element zeroLength	1007	141	142	-mat	4	4	-dir	1	2












puts "[eigen 10]"










