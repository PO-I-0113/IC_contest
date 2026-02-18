set VERSION_LIST = (distance_square_shared_version distance_square_version exp_multiply2_shared_signed_version exp_multiply2_shared_version pipeline_general_version pipeline_nongeneral_version pipeline_signed_version test)

set CONSTRAIN_LIST = (15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0)

foreach ver ($VERSION_LIST)
    foreach cst ($CONSTRAIN_LIST)
        if ("$ver" == "distance_square_shared_version") then
            set tclfile = dc_syn.tcl""
        else if ("$ver" == "distance_square_version")then
            set tclfile = "dc_syn.tcl"
        else if ("$ver" == "exp_multiply2_shared_signed_version")then
            set tclfile = "dc_syn.tcl"
        else if ("$ver" == "exp_multiply2_shared_version")then
            set tclfile = "dc_syn.tcl"
        else if ("$ver" == "pipeline_general_version")then
            set tclfile = "dc_syn_pipe.tcl"
        else if ("$ver" == "pipeline_nongeneral_version")then
            set tclfile = "dc_syn_pipe.tcl"
        else if ("$ver" == "pipeline_signed_version")then
            set tclfile = "dc_syn_pipe.tcl"
        else if ("$ver" == "test")then
            set tclfile = "dc_syn.tcl"
        endif
        pt_shell -f $tclfile -x "set VERSION $ver; set CONSTRAIN $cst" | tee ./$ver/ADFP16/clk_${cst}_pt_log.txt
    end
end
