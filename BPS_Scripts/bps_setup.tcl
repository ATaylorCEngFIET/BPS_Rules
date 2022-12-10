BPS::clear_packages -confirm=1
BPS::clear_all_design_signoff_checklists -confirm=1

BPS::add_package {ESA_IP_CHECK}
BPS::create_design_signoff_checklist -checklist {ESA_IP_CHECK_CL} 
BPS::add_extrainfo_package {ESA_IP} -check_package_name {ESA_IP_CHECK} -msgprefix {ESA}
BPS::set_report -all false
BPS::set_check_enabled * -enabled false
BPS::clear_log_package_summary
BPS::set_memorystateinterval 0
BPS::reset_naming_options
set max_columms 80
#example checks only 
set l_bp_checkers {
	LLC
	NAME_ANALYSIS_CLOCKS
	IDENTIFY_RESET_SIGNALS
	NAME_ANALYSIS_RESETS
	NAME_ANALYSIS_LABELS
	FILE_HEADER
	ENTITY_ARCH_FILELOC
	SLCC
	MULT_PORTS
	PORT_INST_SIGNAL
	NO_COMPONENT_INSTANTIATION_NOBINDING
	FOREIGN_LANGUAGE_KWD
	UNO
	NAME_ANALYSIS_PORT_DATA_TYPES
	PORT_GROUPING
	SUBMOD_INOUT_PORTS
	MIXED_REGISTER_RST
	RESET_MIXED_EDGES
	SYNCH_SR
	RST
	NO_INITIAL
	NO_SR
	NO_SYNCH_DEASSERT_RST
	NAME_ANALYSIS_SIGNALS
	FSM_NO_HCCS
	UNREACHABLE_STATE
	FSM_BOUNDS
	TERM_STATE
	IGCKM
	IGCK
	CKGT
	MULTI_CLK
	NEGEDGE
	POSEDGE
	UNEV
	REGI_SYNCH
	REGO
	CSL
	INT_TRI
	LATCH_CREATED
	CLPR
	ICKGT
	UNCONSTRAINED_INT
	RANGE_CHECK
	HCCC
	MCVS
	SIG_BITS_LOST
	VECTOR_INDEX_BEYOND_VECTOR_RANGE
	MBA
	NO_DELAY
	REPORT_PARAMS
	ITE_DEPTH
	NAME_ANALYSIS_LIBRARIES
	ACCESS_GLOBAL_VAR
	NAME_ANALYSIS_PORTS
	NAME_ANALYSIS_KEYWORDS
	MDR
	MEA
	UBA
	MIA
	DCI
	UNCONNECTED_UNDRIVEN_USED_NET
	UNCONNECTED_UNDRIVEN_USED_PIN
	RSTASR					   
}

set esa_rule 1
#enable defined checks
foreach x $l_bp_checkers {
	BPS::set_check_enabled $x -enabled true
	BPS::add_check_to_package   -check $x {ESA_IP_CHECK}
	BPS::add_check_to_checklist -check $x  -checklist {ESA_IP_CHECK_CL}
	BPS::set_check_extrainfo $x  -text ESA_$esa_rule -package {ESA_IP}
	#BPS::set_message_extrainfo BPS-0040 -text {Adv-01} -package {ACS}
	incr esa_rule
}

set l_bp_msgs {
	BPS-0039
	BPS-0858
	BPS-0882
	BPS-0859
	BPS-0918
	BPS-0267
	BPS-0902
	BPS-0040
	BPS-0255
	BPS-0684
	BPS-1014
	BPS-0651
	BPS-0015
	BPS-0934
	BPS-0969
	BPS-0254
	BPS-1055
	BPS-0451
	BPS-0149
	BPS-0024
	BPS-0272
	BPS-0395
	BPS-0453
	BPS-0856
	BPS-0950
	BPS-0201
	BPS-0891
	BPS-0202
	BPS-0053
	BPS-0052
	BPS-0018
	BPS-0489
	BPS-0048
	BPS-0047
	BPS-0059
	BPS-0001
	BPS-0061
	BPS-0058
	BPS-0240
	BPS-0948
	BPS-0021
	BPS-0338
	BPS-0952
	BPS-0183
	BPS-0042
	BPS-0026
	BPS-0363
	BPS-1030
	BPS-0030
	BPS-0271
	BPS-0467
	BPS-0250
	BPS-0936
	BPS-0840
	BPS-0855
	BPS-0932
	BPS-0543
	BPS-0004
	BPS-0173
	BPS-0003
	BPS-0291
	BPS-0801
	BPS-0803
	BPS-0249
}

set esa_rule 1
#enable defined checks
foreach x $l_bp_msgs {
	#BPS::set_check_enabled $x -enabled true
	#BPS::add_check_to_package   -check $x {ESA_IP_CHECK}
	#BPS::add_check_to_checklist -check $x  -checklist {ESA_IP_CHECK_CL}
	#BPS::set_check_extrainfo $x  -text ESA_$esa_rule -package {ESA_IP}
	BPS::set_message_extrainfo $x -text ESA_$esa_rule -package {ESA_IP}
	incr esa_rule
}
