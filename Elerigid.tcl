# 单元类型	单元号	inode	jNode	面积	弹性模量	剪切模量	扭转	抗弯	抗扭	坐标转换
# 单元类型	单元号	inode	jNode	  $A1 	$E1	$G1	$J	$Iy	$Iz	$transfBeam
# 主梁 + 刚臂
element elasticBeamColumn	122	1	143	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3
element elasticBeamColumn	123	1	144	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3
element elasticBeamColumn	124	22	145	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3
element elasticBeamColumn	125	22	146	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3
element elasticBeamColumn	126	60	147	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3
element elasticBeamColumn	127	60	148	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3
element elasticBeamColumn	128	80	149	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3
element elasticBeamColumn	129	80	150	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3
# 支座+ 刚臂
element elasticBeamColumn	130	143	127	$A0	$E0	$G0	$J0	$Iy0	$Iz0	2
element elasticBeamColumn	131	144	129	$A0	$E0	$G0	$J0	$Iy0	$Iz0	2
element elasticBeamColumn	132	145	131	$A0	$E0	$G0	$J0	$Iy0	$Iz0	2
element elasticBeamColumn	133	146	133	$A0	$E0	$G0	$J0	$Iy0	$Iz0	2
element elasticBeamColumn	134	147	135	$A0	$E0	$G0	$J0	$Iy0	$Iz0	2
element elasticBeamColumn	135	148	137	$A0	$E0	$G0	$J0	$Iy0	$Iz0	2
element elasticBeamColumn	136	149	139	$A0	$E0	$G0	$J0	$Iy0	$Iz0	2
element elasticBeamColumn	137	150	141	$A0	$E0	$G0	$J0	$Iy0	$Iz0	2


# 墩+刚臂----->支座
element elasticBeamColumn	138	81	128	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3
element elasticBeamColumn	139	81	130	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3
element elasticBeamColumn	140	95	132	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3
element elasticBeamColumn	141	95	134	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3
element elasticBeamColumn	142	105	136	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3
element elasticBeamColumn	143	105	138	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3
element elasticBeamColumn	144	113	140	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3
element elasticBeamColumn	145	113	142	$A0	$E0	$G0	$J0	$Iy0	$Iz0	3


