# -*- coding: utf-8 -*-
"""
Created on Tue May  7 18:56:57 2019

@author: 12101
"""

import os
import time
import matplotlib.pyplot as pl
import matplotlib.animation as animation
from mpl_toolkits.mplot3d import Axes3D


def flatten_tcl(tclfiles):
    ''' This function takes a tcl file and rewrites it to a temporary file.
    The new temporary file will be flattened, meaning all expressions are
    replaced with their evaluated value (as a float)
    '''
    variables = {} # a disctionary of variables set in the tcl file
    tempfiles = [] # a list of the temporary files created
    ns = {'__builtins__':None} # create empty namespace to use eval() safely

    for tclfile in tclfiles:
        tempfiles.append(tclfile[:-4]+'_temp.tcl')


        with open(tclfile) as f_in, open(tempfiles[-1], 'w') as f_out:
            for line in f_in:
                # For lines that define variable, add that variable to dictionary
                if line[:3] == 'set':
                    # If the line has 3 words, the variable is set directly and we
                    #  can add it to our dictionary of variable values
                    if len(line.split()) == 3:
                        variables['$'+line.split()[1]] = float(line.split()[2])
                        f_out.write(line)
                    # If the thrid word is an expression, evaluate before write
                    elif '[expr' in line.split()[2]:
                        expr = line[line.find('[expr ')+6:line.find(']')]
                        for variable in variables:
                            if variable in expr:
                                # If variables in expr, replace with value
                                expr = expr.replace(variable,
                                                    str(variables[variable]))
                        # Replace expression with evaluated value of expression
                        expr = eval(expr, ns)
                        variables['$'+line.split()[1]] = float(expr)
                        f_out.write(' '.join(('set', line.split()[1], str(expr))))
                # For lines that don't define variable, eval expressions and print
                else:
                    for variable in variables:
                        line = line.replace(variable, str(variables[variable]))
                    while '[expr' in line: # evaluate any expressions, then print
                        expr = line[line.find('[expr ')+6:line.find(']')]
                        line = line.replace('[expr '+expr+']', str(eval(expr, ns)))
                    f_out.write(line)

    # Combine all _temp tcl files into one messy one, also detect for 3D of 2D
    ndm = 2 # assume 3 dimensions unless '-ndm 2' detected
    with open('temp.tcl', 'w') as f:
        for tempfile in tempfiles:
            with open(tempfile, 'r') as temp:
                for line in temp:
                    f.write(line)
                    if ndm == 2 and '-ndm 3' in line:
                        ndm = 3
                    if ndm == 3 and '-ndm 2' in line:
                        ndm = 'Uh oh, we\'re not sure which ndm to use...'
            os.remove(tempfile)

    return 'temp.tcl', ndm


def getNodeEleSec(datas):
    '''
    函数getNodeEleSec(datas) 定义得到节点 单元 截面信息 输入文件为datas 即去掉，号的mct文件
    输出文件： 
    nodes 节点信息
    elements 单元信息
    SecValue 截面信息
    Secnum 截面标号
    重要变量：
    *NODE    ; Nodes 节点关键字
    *ELEMENT    ; Elements 单元关键字
    *MATERIAL    ; Material 材料关键字
    nodestart/end  节点起始位置结束位置数据
    Elestart/end  单元起始位置结束位置数据
    SecNum 截面数据及截面标号 
     BEAM  识别梁的类型
    '''
    nodes = []
    SecNum ={}
    nodestart = 0
    nodeend =0
    Elestart = 0
    Eleend = 0
    a = -1;
    for data in datas:
        a = a + 1;    
        if '*NODE    ; Nodes' in data[0]:
            #print(datas[a])
            nodestart = a + 2
        if '*ELEMENT    ; Elements' in data[0]:
            #print(datas[a])
            Elestart = a + 6
            nodeend = a - 2
        if '*MATERIAL    ; Material' in data[0]:
            Eleend = a - 2
        
        if data[0][:5] == ' SECT':
            SecNum[str(data[0][6:])] = a+1
            
    for i in range(nodestart,nodeend):
        node = datas[i]
        nodes.append(('node',int(node[0]), float(node[1]), float(node[2]), float(node[3])))
    
    elements = []
    for i in range(Elestart,Eleend):
        Ele = datas[i]
        if Ele[1] == ' BEAM  ':
            Ele[1] = 'elasticBeamColumn'
            elements.append(('element',Ele[1], int(Ele[0]), int(Ele[4]), int(Ele[5]),int(Ele[3])))
    
    SecValue = []
    Secnum = []
    for value in SecNum.values():
        #print(value)
        #print(key)
        sec = datas[value]
        SecValue.append(sec)
        #print(sec)
    for key in SecNum:
        Secnum.append(key)
        
    return nodes,elements,SecValue,Secnum

# 输入文件即mct文件
tclfiles = ('11.tcl',)

# 自输入材料值
poisson = 0.20
E1 = 34.5e9  
G1 = E1/(2*(1 + poisson))

# 文件处理

tclfile, ndm = flatten_tcl(tclfiles)



ndm = 3
datas = []

with open(tclfile) as f:
    for line in f:
        datas.append(line.split(','))



nodes,elements,SecValue,Secnum = getNodeEleSec(datas)  




with  open('node.tcl', 'w') as f_out:
    f_out.write('model BasicBuilder -ndm 3 -ndf 6;' + '\n')
    for lin in nodes:        
        lin2 = list(lin)
        f_out.write(lin2[0] + '\t' + str(lin2[1]) +  '\t' + str(lin2[2]) + '\t' + str(lin2[3]) + '\t' + str(lin2[4]) + '\n')



with  open('Section.tcl', 'w') as f_out:
    for lin,i in zip(SecValue,Secnum):        
        lin2 = list(lin)
        print('set ' + 'A'+i.lstrip() + ' = ' + str(lin2[0]).lstrip())
        #f_out.write('$A'+i.lstrip(),lin2[0] + '\t' + str(lin2[1]) +  '\t' + str(lin2[2]) + '\t' + str(lin2[3]) + '\t' + str(lin2[4]) + '\n')
        f_out.write('set ' + 'E1' + ' = ' + str(E1) + '\n')
        f_out.write('set ' + 'G1' + ' = ' + str(G1) + '\n')
        f_out.write('set ' + 'A'+i.lstrip() + ' = ' + str(lin2[0]).lstrip()+ '\n') 
        f_out.write('set ' + 'J'+i.lstrip() + ' = ' + str(lin2[3]).lstrip() + '\n')
        f_out.write('set ' + 'Iy'+i.lstrip() + ' = ' + str(lin2[5]).lstrip())
        f_out.write('set ' + 'Iz'+i.lstrip() + ' = ' + str(lin2[4]).lstrip() + '\n\n')



with  open('Element.tcl', 'w') as f_out:
    for lin in elements:        
        lin2 = list(lin)
        f_out.write(lin2[0] + '\t' + str(lin2[1]) +  '\t' + str(lin2[2]) + '\t' + str(lin2[3]) + '\t' + str(lin2[4])  + '\t' 
                    + '$A'+str(lin2[5]) + '\t' + '$E1' + '\t' + '$G1' + '\t' + '$J'+str(lin2[5])  + '\t' + '$Iy'+str(lin2[5])+ '\t'  + '$Iz'+str(lin2[5]) + '\t'
                    + '\n' )    







