wipe
model BasicBuilder -ndm 3 -ndf 6;

source LibUnits.tcl;
# -----------------定义节点-----------------------------
#Beam Node 主梁
source NodeBeam.tcl;

#Pier Node 桥墩
source NodePier.tcl;

# Node 弹簧
source NodeSpring.tcl

# -----------------定义约束条件-----------------------------
fix 94 1 1 1 1 1 1
fix 104 1 1 1 1 1 1
fix 112 1 1 1 1 1 1
fix 126 1 1 1 1 1 1
# -----------------定义刚性连接-----------------------------
# source EqualSpring.tcl
# -----------------定义坐标转换-----------------------------
# 坐标转换
geomTransf Linear 1 0 0 1
geomTransf Linear 2 0 1 0 
geomTransf Linear 3 1 0 0 
# -----------------定义截面----------------------
source SectionElastic.tcl
# -----------------弹性模量 剪切模量--------------
set poisson 0.20
set E0 [expr 34.5*$GPa]
set G0 [expr $E0/(2*(1+$poisson))]
set E1 [expr 34.5*$GPa]
set G1 [expr $E1/(2*(1+$poisson))]
set E2 [expr 32.5*$GPa]
set G2 [expr $E2/(2*(1+$poisson))]
set E3 [expr 31.5*$GPa]
set G3 [expr $E3/(2*(1+$poisson))]
# -----------------定义单元--------------------
source EleBeam.tcl
source ElePier.tcl
source Elerigid.tcl
# -----------------定义质量--------------------
source MassBeam.tcl
source MassPier.tcl
# -----------------定义零长度单元----------------

uniaxialMaterial Steel01 1 1000 10000000 0
uniaxialMaterial Steel01 2 1000 10000000 0
uniaxialMaterial Steel01 3 1000 10000000 0
uniaxialMaterial Steel01 4 1000 10000000 0

# 单元类型	EleNumber	Inode	Jnode		-mat1	-mat2		dir1	dir2
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


set lambda [eigen 10]; # 提取前10阶特征值 eigenvalue mode j = 2

puts "lambda1 = $lambda"; #第一阶频率的特征周期 display the first mode period in the command window

set lambda1 [lindex $lambda [expr 1-1]]; # 提取第一阶特征值 eigenvalue mode j = 1 
set lambda2 [lindex $lambda [expr 2-1]]; # 提取第二阶特征值 eigenvalue mode j = 2
set lambda3 [lindex $lambda [expr 3-1]]; # 提取第一阶特征值 eigenvalue mode j = 1 
set lambda4 [lindex $lambda [expr 4-1]]; # 提取第一阶特征值 eigenvalue mode j = 1 
set lambda5 [lindex $lambda [expr 5-1]]; # 提取第一阶特征值 eigenvalue mode j = 1 



puts "lambda1 = $lambda1"; #第一阶频率的特征周期 display the first mode period in the command window
puts "lambda2 = $lambda2"; #第一阶频率的特征周期 display the first mode period in the command window


#特征周期
set omega1 [expr pow($lambda1,0.5)]; # 第一阶频率的特征周期 (1st mode circular frequency)
set omega2 [expr pow($lambda2,0.5)]; # 第二阶频率的特征周期 (2nd mode circular frequency)
set omega3 [expr pow($lambda3,0.5)]; # 第二阶频率的特征周期 (2nd mode circular frequency)
set omega4 [expr pow($lambda4,0.5)]; # 第二阶频率的特征周期 (2nd mode circular frequency)
set omega5 [expr pow($lambda5,0.5)]; # 第二阶频率的特征周期 (2nd mode circular frequency)




#周期
set T1 [expr 2*$PI/$omega1]; # 第一阶频率的特征周期 (1st mode circular frequency)
set T2 [expr 2*$PI/$omega2]; # 第二阶频率的特征周期 (2nd mode circular frequency)
set T3 [expr 2*$PI/$omega3]; # 第一阶频率的特征周期 (1st mode circular frequency)
set T4 [expr 2*$PI/$omega4]; # 第二阶频率的特征周期 (2nd mode circular frequency)
set T5 [expr 2*$PI/$omega5]; # 第二阶频率的特征周期 (2nd mode circular frequency)



puts "T1 = $T1 s"; #第一阶频率的特征周期 display the first mode period in the command window
puts "T2 = $T2 s"; #第二阶频率的特征周期 display the first mode period in the command window
puts "T3 = $T3 s"; #第一阶频率的特征周期 display the first mode period in the command window
puts "T4 = $T4 s"; #第二阶频率的特征周期 display the first mode period in the command window
puts "T5 = $T5 s"; #第二阶频率的特征周期 display the first mode period in the command window









