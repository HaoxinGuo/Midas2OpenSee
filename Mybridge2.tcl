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
# source EqualSpring.tcl
# -----------------��������ת��-----------------------------
# ����ת��
geomTransf Linear 1 0 0 1
geomTransf Linear 2 0 1 0 
# -----------------�������----------------------
source SectionElastic.tcl
# -----------------����ģ�� ����ģ��--------------
set poisson 0.20
set E1 [expr 34.5*$GPa]
set G1 [expr $E1/(2*(1+$poisson))]
set E2 [expr 32.5*$GPa]
set G2 [expr $E2/(2*(1+$poisson))]
set E3 [expr 31.5*$GPa]
set G3 [expr $E3/(2*(1+$poisson))]
# -----------------���嵥Ԫ--------------------
source EleBeam.tcl
source ElePier.tcl
# -----------------��������--------------------
source MassBeam.tcl
source MassPier.tcl
# -----------------�����㳤�ȵ�Ԫ----------------
equalDOF 1 81 3 4 5 6
equalDOF 22 81 3 4 5 6
equalDOF 60 81 3 4 5 6
equalDOF 80 81 3 4 5 6
uniaxialMaterial Steel01 1 10000000 1000000 0
uniaxialMaterial Steel01 2 10000000 1000000 0
uniaxialMaterial Steel01 3 10000000 1000000 0
uniaxialMaterial Steel01 4 10000000 1000000 0

# ��Ԫ����	EleNumber	Inode	Jnode		-mat1	-mat2		dir1	dir2			
element zeroLength	122	1	81	-mat	1	1	-dir	1	2
element zeroLength	123	22	95	-mat	2	2	-dir	1	2
element zeroLength	124	60	105	-mat	3	3	-dir	1	2
element zeroLength	125	80	113	-mat	4	4	-dir	1	2



#element zeroLength	126	135	136	-mat	3	3	-dir	1	2	3	4	6
#element zeroLength	127	137	138	-mat	3	3	-dir	1	2	3	4	6
#element zeroLength	128	139	140	-mat	4	4	-dir	1	3	4	6
#element zeroLength	129	141	142	-mat	4	4	-dir	1	3	4	6

puts "[eigen 32]"










