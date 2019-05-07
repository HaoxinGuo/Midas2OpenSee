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

uniaxialMaterial Steel01 1 1000 10000000 0
uniaxialMaterial Steel01 2 1000 10000000 0
uniaxialMaterial Steel01 3 1000 10000000 0
uniaxialMaterial Steel01 4 1000 10000000 0

# ��Ԫ����	EleNumber	Inode	Jnode		-mat1	-mat2		dir1	dir2
equalDOF 127	128	1	5	
equalDOF 129	130	1	5
equalDOF 131	132	5	
equalDOF 133	134	1	5
equalDOF 135	136	1	5
equalDOF 137	138	1	5
equalDOF 139	140	1	5 
# 3	4	5	6
equalDOF 141	142	1	5

element zeroLength	1000	127	128	-mat	1	1	-dir	2 	3 	4	6
element zeroLength	1001	129	130	-mat	1	1	-dir	2	3	4	6
element zeroLength	1002	131	132	-mat	2	2	-dir	1	2	3	4	6
element zeroLength	1003	133	134	-mat	2	2	-dir	1	2 	3 	4	6
element zeroLength	1004	135	136	-mat	3	3	-dir	2 	3 	4	6
element zeroLength	1005	137	138	-mat	3	3	-dir	2 	3 	4	6
element zeroLength	1006	139	140	-mat	4	4	-dir	2 	3 	4	6
element zeroLength	1007	141	142	-mat	4	4	-dir	2 	3 	4	6







# puts "[eigen 10]"


set lambda [eigen 10]; # ��ȡǰ10������ֵ eigenvalue mode j = 2

puts "lambda1 = $lambda"; #��һ��Ƶ�ʵ��������� display the first mode period in the command window

set lambda1 [lindex $lambda [expr 1-1]]; # ��ȡ��һ������ֵ eigenvalue mode j = 1 
set lambda2 [lindex $lambda [expr 2-1]]; # ��ȡ�ڶ�������ֵ eigenvalue mode j = 2
set lambda3 [lindex $lambda [expr 3-1]]; # ��ȡ��һ������ֵ eigenvalue mode j = 1 
set lambda4 [lindex $lambda [expr 4-1]]; # ��ȡ��һ������ֵ eigenvalue mode j = 1 
set lambda5 [lindex $lambda [expr 5-1]]; # ��ȡ��һ������ֵ eigenvalue mode j = 1 



puts "lambda1 = $lambda1"; #��һ��Ƶ�ʵ��������� display the first mode period in the command window
puts "lambda2 = $lambda2"; #��һ��Ƶ�ʵ��������� display the first mode period in the command window


#��������
set omega1 [expr pow($lambda1,0.5)]; # ��һ��Ƶ�ʵ��������� (1st mode circular frequency)
set omega2 [expr pow($lambda2,0.5)]; # �ڶ���Ƶ�ʵ��������� (2nd mode circular frequency)
set omega3 [expr pow($lambda3,0.5)]; # �ڶ���Ƶ�ʵ��������� (2nd mode circular frequency)
set omega4 [expr pow($lambda4,0.5)]; # �ڶ���Ƶ�ʵ��������� (2nd mode circular frequency)
set omega5 [expr pow($lambda5,0.5)]; # �ڶ���Ƶ�ʵ��������� (2nd mode circular frequency)




#����
set T1 [expr 2*$PI/$omega1]; # ��һ��Ƶ�ʵ��������� (1st mode circular frequency)
set T2 [expr 2*$PI/$omega2]; # �ڶ���Ƶ�ʵ��������� (2nd mode circular frequency)
set T3 [expr 2*$PI/$omega3]; # ��һ��Ƶ�ʵ��������� (1st mode circular frequency)
set T4 [expr 2*$PI/$omega4]; # �ڶ���Ƶ�ʵ��������� (2nd mode circular frequency)
set T5 [expr 2*$PI/$omega5]; # �ڶ���Ƶ�ʵ��������� (2nd mode circular frequency)



puts "T1 = $T1 s"; #��һ��Ƶ�ʵ��������� display the first mode period in the command window
puts "T2 = $T2 s"; #�ڶ���Ƶ�ʵ��������� display the first mode period in the command window
puts "T3 = $T3 s"; #��һ��Ƶ�ʵ��������� display the first mode period in the command window
puts "T4 = $T4 s"; #�ڶ���Ƶ�ʵ��������� display the first mode period in the command window
puts "T5 = $T5 s"; #�ڶ���Ƶ�ʵ��������� display the first mode period in the command window









