# --------------------------------------------------------------------------------------------------
# LibUnits.tcl -- define system of units
#		Silvia Mazzoni & Frank McKenna, 2006
#

# define UNITS ----------------------------------------------------------------------------
set m 1.; 				# define basic units -- output units
set kg 1.; 			# define basic units -- output units
set sec 1.; 			# define basic units -- output units

set LunitTXT "m";			# define basic-unit text for output
set FunitTXT "kg";			# define basic-unit text for output
set TunitTXT "sec";			# define basic-unit text for output

#长度单位
set in [expr 0.0254*$m];		# centimeter, needed for displacement input in MultipleSupport excitation
set ft [expr 12.*$in]; 		# define engineering units

set dm [expr 0.1*$m];
set cm [expr 0.01*$m];
set mm [expr 0.001*$m];


set N  [expr $kg*$m/pow($sec,2)];
set kN [expr 1000.*$N];

set kip [expr 4.448*$kN]

set g [expr 9.8*$m/pow($sec,2)]; 	# gravitational acceleration
set gal [expr 0.001*$g];


set ksi [expr $kip/pow($in,2)];
set psi [expr $ksi/1000.];

set lbf [expr $psi*$in*$in];		# pounds force
set pcf [expr $lbf/pow($ft,3)];		# pounds per cubic foot
set psf [expr $lbf/pow($ft,3)];		# pounds per square foot

set in2 [expr $in*$in]; 		# inch^2
set in4 [expr $in*$in*$in*$in]; 		# inch^4
set PI [expr 2*asin(1.0)]; 		# define constants





set m2 [expr $m*$m];
set m4 [expr $m*$m*$m*$m];

set mm2 [expr $mm*$mm];
set mm4 [expr $mm*$mm*$mm*$mm];


set Pa [expr $N/pow($m,2)];
set kPa [expr 1000.*$Pa];
set MPa [expr 1000.*$kPa];
set GPa [expr 1000.*$MPa];

set Ubig 1.e10; 			# a really large number
set Usmall [expr 1/$Ubig]; 		# a really small number
