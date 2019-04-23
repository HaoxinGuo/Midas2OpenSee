wipe
model basic -ndm 3 -ndf 6

source LibUnits.tcl;
# -----------------定义节点-----------------------------
#Beam Node 主梁
source NodeBeam.tcl;

#Pier Node 桥墩
source NodePier2.tcl;

# Node 弹簧
# source NodeSpring.tcl

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
geomTransf Linear 3 0 0 1
# -----------------定义截面----------------------
source SectionElastic.tcl
# -----------------弹性模量 剪切模量--------------
set poisson 0.20
set E1 [expr 34.5*$GPa]
set G1 [expr $E1/(2*(1+$poisson))]
set E2 [expr 32.5*$GPa]
set G2 [expr $E2/(2*(1+$poisson))]
set E3 [expr 31.5*$GPa]
set G3 [expr $E3/(2*(1+$poisson))]
# -----------------定义单元--------------------
source EleBeam.tcl
source ElePier.tcl
# -----------------定义质量--------------------
source MassBeam.tcl
source MassPier.tcl
# -----------------定义零长度单元----------------
equalDOF 81 1 3 4 5 6
equalDOF 95 22 3 4 5 6
equalDOF 105 60 3 4 5 6
equalDOF 126 80 3 4 5 6
uniaxialMaterial Steel01 1 156000 78000000 0.03

# 单元类型	EleNumber	Inode	Jnode		-mat1	-mat2		dir1	dir2			
element zeroLength	122	1	81	-mat	1	1	-dir	1	2
element zeroLength	123	22	95	-mat	1	1	-dir	1	2
element zeroLength	124	60	105	-mat	1	1	-dir	1	2
element zeroLength	125	80	113	-mat	1	1	-dir	1	2


puts "[eigen 10]"










