# *******************************************************************************
# Company:  Adiuvo Engineering & Training Ltd
#
# Function: This file creates a BPS project and loads in the files defined in 
#           input_files.f output results are written out as one CSV file for each 
#           of the files analysed. If you wish to review the issues in the GUI 
#           open the -f file in the GUI environment
#
# Useage: 	This file can be called from the BluePearlCLI
#
# Author:   Adam Taylor Adam@AdiuvoEngineering.com
#
# Created:  Saturday 11 July 20202
#
# Copyright (C) 2020 Adiuvo Engineering & Training Ltd
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# ******************************************************************************* 




#set up the BPS project and run it 

BPS::read_ffile input_files.f 

BPS::set_msg_check_package ESA_IP

BPS::run load

set working [pwd]
puts $working

#Format the output information so we have the necessary information as we want it 

#what checks are enabled
set check_list [BPS::get_checks]

#create a list of checks which are enabled in the current project
foreach y $check_list {
	set checks [lindex $y 0]
	set enabled [lindex $y 1]
	if {$enabled == 1} {
		append check_enb $checks\n	
	}
}

#get the files the project is working on for output formatting
set input_files [BPS::get_input_files]

set ip_f [BPS::get_input_files -report]


set part "BPS_RESULTS"
set result_dir_name [concat "$working/$part"]

if { [file exists $result_dir_name] == 1} {               
	file delete -force $result_dir_name
}

file mkdir $result_dir_name

 foreach x $input_files {
 
	#format file name correctly, get the first element which is the filenamne
	set filename [lindex $x 0]
	#determine the directory the files are contained within 
	#files to be analysed must be in lower directory than the bat is located 
	set reg [concat "($working)(/)((\[a-z0-9_-\]/*)*)"]
	regexp -nocase "$reg" $filename match sub1 sub2 sub3 sub4
	
	#strip the base path leaving just file name 
	set fbasename [file tail $filename]
   
	set ext ".vhd"
	set filereq [concat "$sub3$ext"]
	set type "load_"
	#set the txt file name use original filename with the directory path
	set file_data [open "$result_dir_name/$type$fbasename.txt" w+]
	
	#load in the mesages of the type we are interested in from the file we are interested in using only the file name not the directory path
	set test [BPS::get_result_run_messages -checks $check_enb -file $filereq -report]

	puts $file_data $test
	close $file_data

}

puts "Now Running CDC and PATH Analysis \n"

BPS::run analyze

 foreach x $input_files {
 
	#format file name correctly, get the first element which is the filenamne
	set filename [lindex $x 0]
	#determine the directory the files are contained within 
	#files to be analysed must be in lower directory than the bat is located 
	set reg [concat "($working)(/)((\[a-z0-9_-\]/*)*)"]
	regexp -nocase "$reg" $filename match sub1 sub2 sub3 sub4
	
	#strip the base path leaving just file name 
	set fbasename [file tail $filename]
   
	set ext ".vhd"
	set filereq [concat "$sub3$ext"]
	set type "analayze_"
	#set the txt file name use original filename with the directory path
	set file_data [open "$result_dir_name/$type$fbasename.txt" w+]
	
	#load in the mesages of the type we are interested in from the file we are interested in using only the file name not the directory path
	set test [BPS::get_result_run_messages -checks $check_enb -file $filereq -report]

	puts $file_data $test
	close $file_data

}


puts "end of script"

exit