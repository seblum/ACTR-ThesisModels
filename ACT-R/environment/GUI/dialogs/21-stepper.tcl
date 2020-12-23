global stop_type
global stepper_tutor
global tutor_ans
global tutor_bindings
global tutor_answers
global step_now
global run_over
global stepper_tutorable
global stepper_tutored

proc stepper_button_state_control {state} {
 .stepper.step configure -state $state
 .stepper.stop configure -state $state
 .stepper.run_until configure -state $state
} 

proc run_starts {model time} {
  global run_over

  set run_over 0
  call_act_r_command "stepper-condition" nil [list false false]
  stepper_button_state_control normal
}

proc run_ends {model time} {
  global run_over

  set run_over 1
  stepper_button_state_control disabled
}

proc select_stepper {} {
  global options_array

  if {[winfo exists .stepper] == 1} {
    wm deiconify .stepper
    raise .stepper
  } else {

    if {[call_act_r_command "act-r-running-p"] == "true"} {
      tk_messageBox -icon info -type ok -title "ACT-R running" \
                    -message "Cannot open the stepper while ACT-R is currently running."
      return 0
    }

    set stepper_temp [call_act_r_command "stepper-status-check"]

    if {$stepper_temp == "already" } {
      tk_messageBox -icon info -type ok -title "Stepper" \
                    -message "There is already a stepper window open in a connected Environment and only one stepper is allowed."
      return 0
    }

    if {$stepper_temp == "none"} {
      tk_messageBox -icon info -type ok -title "Stepper" \
                    -message "All models currently have :v set to nil which means there will be no events for the stepper to use."
    }

    toplevel .stepper
    wm withdraw .stepper
    wm title .stepper "Stepper"

    wm geometry .stepper [get_configuration .stepper]

    tk_optionMenu .stepper.run_until_type stop_type Time Production Module

    .stepper.run_until_type configure -font button_font

    [.stepper.run_until_type cget -menu] configure -font menu_font

    button .stepper.run_until -text "Run Until:" -font button_font -command {stepper_run_until}                  

    entry .stepper.run_until_time -width 6 -font text_font -textvariable run_until_time 

    label .stepper.current -text "Last Stepped:" -justify left -font label_font
    label .stepper.next -text "Next Step:" -justify left -font label_font

    button .stepper.step -text "Step" -font button_font -command {stepper_step_button}
    button .stepper.stop -text "Stop" -font button_font -command {stepper_stop_button}
    
    label .stepper.current_text -font text_font \
          -textvar .stepper.current_text.var -justify left -anchor nw

    label .stepper.next_text -font text_font \
          -textvar .stepper.next_text.var -justify left -anchor nw

    frame .stepper.prod_frame -borderwidth 0
    frame .stepper.prod_frame.f4 -borderwidth 0  
  
    label .stepper.prod_frame.f4.list_title -textvar .stepper.prod_frame.f4.list_title.var \
           -anchor nw -justify left -font label_font

    set .stepper.prod_frame.f4.list_title.var ""

    frame .stepper.prod_frame.f4.f -borderwidth 0  

    listbox .stepper.prod_frame.f4.f.list -listvar .stepper.prod_frame.f4.f.list.var \
            -yscrollcommand ".stepper.prod_frame.f4.f.scrl set" \
            -selectmode single -exportselection 0 -font list_font -bd 0
   
    bind .stepper.prod_frame.f4.f.list <<ListboxSelect>> {
      update_instantiation_viewers %W
    }

    scrollbar .stepper.prod_frame.f4.f.scrl -command ".stepper.prod_frame.f4.f.list yview"


    frame .stepper.prod_frame.f3 -borderwidth 0
    frame .stepper.prod_frame.f3.f -borderwidth 0

    label .stepper.prod_frame.f3.production \
          -textvariable .stepper.prod_frame.f3.production.var  \
          -justify left -font label_font

    text .stepper.prod_frame.f3.f.text -font text_font \
         -yscrollcommand ".stepper.prod_frame.f3.f.scrl set" \
         -state disabled 

    
    scrollbar .stepper.prod_frame.f3.f.scrl -command ".stepper.prod_frame.f3.f.text yview"

    frame .stepper.prod_frame.f2 -borderwidth 0
    frame .stepper.prod_frame.f2.f -borderwidth 0

    label .stepper.prod_frame.f2.bindings \
          -textvariable .stepper.prod_frame.f2.bindings.var \
          -justify left -font label_font

    text .stepper.prod_frame.f2.f.text -font text_font \
         -yscrollcommand ".stepper.prod_frame.f2.f.scrl set" \
         -state disabled
  
    scrollbar .stepper.prod_frame.f2.f.scrl -command ".stepper.prod_frame.f2.f.text yview"


    checkbutton .stepper.stepper_tutor -text "Tutor Mode" -font checkbox_font \
                -variable stepper_tutor -command {select_tutor_mode} 

    .stepper.stepper_tutor deselect


    frame .stepper.prod_frame.f5 -borderwidth 0
    frame .stepper.prod_frame.f5.f -borderwidth 0

    label .stepper.prod_frame.f5.production \
          -textvariable .stepper.prod_frame.f5.production.var  \
          -justify left -font label_font

    text .stepper.prod_frame.f5.f.text -font text_font \
         -yscrollcommand ".stepper.prod_frame.f5.f.scrl set" \
         -state disabled 

    scrollbar .stepper.prod_frame.f5.f.scrl -command ".stepper.prod_frame.f5.f.text yview"

    place .stepper.step -x 2 -y 2 -width 50 -height 25
    place .stepper.stop -x 55 -y 2 -width 50 -height 25
 
    place .stepper.run_until -x 108 -y 2 -width 80 -height 25
    place .stepper.run_until_type -x 190 -y 2 -width 100 -height 25
    place .stepper.run_until_time -x 292 -y 2 -width -394 -relwidth 1.0 -height 25
    place .stepper.stepper_tutor -x -100 -relx 1.0 -y 5 -height 25 -width 100

    place .stepper.next -x 0 -y 30 -height 25 -width 90 
    place .stepper.next_text -x 102 -y 32 -relwidth 1.0 -width -92 -height 23 

    place .stepper.current -x 0 -y 60 -height 25 -width 90 
    place .stepper.current_text -x 102 -y 62 -relwidth 1.0 -width -92 -height 23 

    place .stepper.prod_frame -x 0 -y 90 -relwidth 1.0 -relheight 1.0 -height -90

    place .stepper.prod_frame.f5 -relx 0.0 -rely .5 -relwidth .4 -relheight .5

    pack .stepper.prod_frame.f5.production -side top 

    pack .stepper.prod_frame.f5.f.scrl -side right -fill y 
    pack .stepper.prod_frame.f5.f.text -side left -expand 1 -fill both

    pack .stepper.prod_frame.f5.f -side top -expand 1 -fill both

    place .stepper.prod_frame.f4 -relx 0.0 -rely 0.0 -relwidth .4 -relheight .5

    pack .stepper.prod_frame.f4.list_title -side top 

    pack .stepper.prod_frame.f4.f.scrl -side right -fill y 
    pack .stepper.prod_frame.f4.f.list -side left -expand 1 -fill both

    pack .stepper.prod_frame.f4.f -side top -expand 1 -fill both

    place .stepper.prod_frame.f3 -relx 0.4 -rely 0.4 -relwidth .6 -relheight .6

    pack .stepper.prod_frame.f3.production -side top 

    pack .stepper.prod_frame.f3.f.scrl -side right -fill y 
    pack .stepper.prod_frame.f3.f.text -side left -expand 1 -fill both

    pack .stepper.prod_frame.f3.f -side top -expand 1 -fill both

    place .stepper.prod_frame.f2 -relx 0.4 -rely 0.0 -relwidth .6 -relheight .4

    pack .stepper.prod_frame.f2.bindings -side top 

    pack .stepper.prod_frame.f2.f.scrl -side right -fill y 
    pack .stepper.prod_frame.f2.f.text -side left -expand 1 -fill both

    pack .stepper.prod_frame.f2.f -side top -expand 1 -fill both

    add_cmd "stepper_run_start" "run_starts" "Monitor function for stepper button control."
    add_cmd "stepper_run_stop" "run_ends" "Monitor function for stepper button control."
    add_cmd "wait_for_stepper" "wait_for_stepper" "Internal command for stepper tool wait during pre-event hook. Do not call."
    add_cmd "display_stepper_stepped" "display_stepper_stepped" "Internal command for stepper tool update. Do not call."
    add_cmd "close-stepper-tool" "close_stepper_tool" "Internal command for closing the stepper when a clear-all occurs. Do not call."
    add_cmd "reset-stepper-tool" "reset_stepper_tool" "Internal command for monitoring resets in stepper. Do not call."

    send_cmd "monitor" [list "run-start" "stepper_run_start"]
    send_cmd "monitor" [list "run-stop" "stepper_run_stop"]
    send_cmd "monitor" [list "clear-all-start" "close-stepper-tool"]
    send_cmd "monitor" [list "reset-step1" "reset-stepper-tool"]

    bind .stepper.step <Destroy> {

      send_cmd "remove-monitor" [list "run-start" "stepper_run_start"]
      send_cmd "remove-monitor" [list "run-stop" "stepper_run_stop"]
      send_cmd "remove-monitor" [list "clear-all-start" "close-stepper-tool"]
      send_cmd "remove-monitor" [list "reset-step1" "reset-stepper-tool"]
      
      remove_cmd "stepper_run_start"
      remove_cmd "stepper_run_stop"
      remove_cmd "wait_for_stepper"
      remove_cmd "display_stepper_stepped"
      remove_cmd "close-stepper-tool"
      remove_cmd "reset-stepper-tool"

      call_act_r_command "uninstall-stepper-hooks"
      
      global step_now

      set step_now 999 
    }

    reset_stepper_tool ""

#    if {[call_act_r_command "act-r-running-p"] == "true"} {
#      run_starts 0 0
#    } else {
    run_ends 0 0
#    }

    if {[call_act_r_command "install-stepper-hooks"] != "true"} {
      tk_messageBox -icon warning -type ok -title "Stepper problem" \
                    -message "There was a problem initializing the stepper controls and it cannot be used."
      destroy .stepper
    } else {
      wm deiconify .stepper
    }
  }
}

proc close_stepper_tool {model} {
  destroy .stepper
}

proc reset_stepper_tool {model} {
  global .stepper.current_text.var
  global .stepper.prod_frame.f4.list_title.var
  global .stepper.prod_frame.f3.production.var
  global .stepper.prod_frame.f2.bindings.var
  global .stepper.prod_frame.f5.production.var 
  global .stepper.next_text.var
  global .stepper.prod_frame.f4.f.list.var
  global stepper_tutor
  global stepper_tutored
  global stepper_tutorable

  if {[winfo exists .tutor_response] == 1} {

    global tutor_ans
    set tutor_ans ""
    destroy .tutor_response
  }

  set .stepper.next_text.var ""
  set .stepper.current_text.var ""
 
  set .stepper.prod_frame.f4.list_title.var ""
  set .stepper.prod_frame.f5.production.var ""
  set .stepper.prod_frame.f2.bindings.var ""
  set .stepper.prod_frame.f3.production.var ""

  update_text_pane .stepper.prod_frame.f5.f.text ""
  update_text_pane .stepper.prod_frame.f2.f.text ""
  update_text_pane .stepper.prod_frame.f3.f.text ""

  set .stepper.prod_frame.f4.f.list.var ""

  set stepper_tutor 0
  set stepper_tutored 0
  set stepper_tutorable 0

}



proc select_tutor_mode {} {
  global tutor_bindings 
  global tutor_answers
  global stepper_tutored
  global stepper_tutor
  global stepper_tutorable


  if {[winfo exists .tutor_response] == 1} {

    global tutor_ans
    set tutor_ans ""
    destroy .tutor_response
  }

  if [array exists tutor_bindings] {
    array unset tutor_bindings 
  }  
  if [array exists tutor_answers] {
    array unset tutor_answers
  }  

  if {$stepper_tutored && !$stepper_tutor} {
    set stepper_tutored 0
  }  elseif {$stepper_tutorable && $stepper_tutor} { 
    set stepper_tutored 1
  }

  if {$stepper_tutor} {
    call_act_r_command "turn-on-stepper-tutoring" nil ""
  } else {
    call_act_r_command "turn-off-stepper-tutoring" nil ""
  }


  update_instantiation_viewers .stepper.prod_frame.f4.f.list
}


proc wait_for_stepper {model event} {

  global step_now
  global run_over
  global .stepper.next_text.var

  set .stepper.next_text.var $event

  if {$run_over == 1} {
    return "true"
  } else {

    set step_now 0
    tkwait variable step_now

    if {$step_now < 0} {
      return "break"
    } else {
      return "true"
    }
  }
}

proc display_stepper_stepped {model text items tutorable p1 p2 p3 p4} {
  global .stepper.current_text.var
  global .stepper.prod_frame.f4.list_title.var
  global .stepper.prod_frame.f3.production.var
  global .stepper.prod_frame.f2.bindings.var
  global .stepper.prod_frame.f5.production.var 
  global stepper_tutored
  global stepper_tutor
  global .stepper.next_text.var
  global stepper_tutorable

  set .stepper.next_text.var ""

  set .stepper.current_text.var $text
 
  set .stepper.prod_frame.f4.list_title.var $p1
  set .stepper.prod_frame.f5.production.var $p2
  set .stepper.prod_frame.f2.bindings.var $p3
  set .stepper.prod_frame.f3.production.var $p4

  update_text_pane .stepper.prod_frame.f5.f.text ""
  update_text_pane .stepper.prod_frame.f2.f.text ""
  update_text_pane .stepper.prod_frame.f3.f.text ""

# quick hack to fix an issue with my JSON parser not converting null to ""

  if {$items == "null"} {set items ""}

  set stepper_tutorable $tutorable
  
  if {$tutorable && $stepper_tutor} {
    set stepper_tutored 1
    
    if {[llength $items] > 1} {
      set items [list [lindex $items 0]]
    }
  } else {
    set stepper_tutored 0
  }
  update_list_box .stepper.prod_frame.f4.f.list $items 1 1
}


proc stepper_step_button {} {
  global stepper_tutor
  global tutor_bindings
  global step_now

  if {!$stepper_tutor || [array names tutor_bindings] == ""} { 

    call_act_r_command "stepper-condition" nil [list false false]

    # make sure it changes to avoid race condition with tkwait
    set step_now [expr $step_now + 1] 
  } else {
    tk_messageBox -icon info -type ok -title "Tutoring" \
                  -message "You must complete the instantiation before continuing in tutor mode."
  }
}    


proc stepper_stop_button {} { # always let the user stop even in tutor mode now

  global step_now
    
  if {$step_now < 0} { 
    # make sure it changes to avoid race condition with tkwait
    set step_now [expr $step_now - 1]
  } else {
    set step_now -1
  }
}

proc stepper_run_until {} {

  global stepper_tutor
  global stop_type
  global run_until_time
  global step_now


  if $stepper_tutor {
    tk_messageBox -icon info -type ok -title "Tutoring" \
                  -message "Run Until not allowed when in tutor mode."
  } else {

    set result [lindex [call_act_r_command "stepper-condition" nil [list $stop_type $run_until_time]] 0]

    if {$result == 1} {
      # make sure it changes to avoid race condition with tkwait
      set step_now [expr $step_now + 1] 
    } else {
      tk_messageBox -icon info -type ok -title "Run Until Issue" -message $result
    }
  }
}  

proc update_instantiation_viewers {list} {
  global stepper_tutor
  global tutor_bindings
  global stepper_tutored 
  global tutor_answers

  if {[$list curselection] != ""} {
  
    set data [call_act_r_command "update-stepper-info" nil [list [$list get [$list curselection]]]]

    set params [lindex $data 0]
    set bindings [lindex $data 1]
    set request [lindex $data 2]
    set display [lindex $data 3]
    set tutored_display [lindex $data 4]

    update_text_pane .stepper.prod_frame.f5.f.text $params

    if $stepper_tutored {

      set b "" 
      set line 1

      foreach i $bindings {
        append b [format "%s : \n" [lindex $i 0]]
        set tutor_answers([lindex $i 0]) [list [lindex $i 1] 0 $line]
        incr line
      }
    
      update_text_pane .stepper.prod_frame.f2.f.text $b

      update_text_pane .stepper.prod_frame.f3.f.text $tutored_display

    } elseif {$request != ""} {
      update_text_pane .stepper.prod_frame.f2.f.text $request
      update_text_pane .stepper.prod_frame.f3.f.text $display

    } else {
      set b "" 
      foreach i $bindings {
        append b [format "%s : %s\n" [lindex $i 0] [lindex $i 1]]
      }
    
      update_text_pane .stepper.prod_frame.f2.f.text $b
      update_text_pane .stepper.prod_frame.f3.f.text $display
    }

    if $stepper_tutored {

      foreach i $bindings {
     
        set var_name [lindex $i 0]
        set strt 1.0
        set side lhs
        set buf "no"
        set match "$var_name"  
                  # " $var_name"
        set is_buffer 0

        if {[string tolower [lindex $i 2]] == "true"} {
          set is_buffer 1
        } 

        while {[set indx [.stepper.prod_frame.f3.f.text search $match $strt end]] != ""} { 

          set v_start $indx 
                      # [.stepper.prod_frame.f3.f.text index "$indx + 1 chars"]

          set word_end [.stepper.prod_frame.f3.f.text index "$v_start + [string length $var_name] chars"]

          if {[.stepper.prod_frame.f3.f.text search -backwards -exact "==>" $v_start 1.0] != ""} {

            set side "rhs"
          } elseif {$buf == "no"} {
            set previous_buf [.stepper.prod_frame.f3.f.text search -backwards -regexp " =.*>" $v_start 1.0]
            if {$previous_buf != ""} {
              set b_start [.stepper.prod_frame.f3.f.text index "$previous_buf + 1 chars"]
              set b_end [.stepper.prod_frame.f3.f.text search ">" $b_start end]
              set buf [.stepper.prod_frame.f3.f.text get $b_start $b_end]
            }
          }
          
          set t_name [new_variable_name tag]

          .stepper.prod_frame.f3.f.text tag add $t_name $v_start $word_end
          .stepper.prod_frame.f3.f.text tag configure $t_name -background black -foreground white 

          set tutor_bindings($t_name) [list $v_start $word_end $var_name $side $is_buffer $buf]

          .stepper.prod_frame.f3.f.text tag bind $t_name <1> {
            global tutor_bindings
            global tutor_ans

            set t_name [%W tag names @%x,%y]

            if {[llength $t_name] == 1} {
              set strt [lindex $tutor_bindings($t_name) 0]
              set w_end [lindex $tutor_bindings($t_name) 1]
              set var [lindex $tutor_bindings($t_name) 2]
              set side [lindex $tutor_bindings($t_name) 3]
              set is_buf [lindex $tutor_bindings($t_name) 4]
              set buf [lindex $tutor_bindings($t_name) 5]

              if {[get_tutor_response $var $side $buf $is_buf $strt $w_end $t_name]} {

                tkwait variable tutor_ans

                if {$tutor_ans != "NoAnswer"} {

                  array unset tutor_bindings [lindex $tutor_ans 3]

                  .stepper.prod_frame.f3.f.text configure -state normal
                  .stepper.prod_frame.f3.f.text delete [lindex $tutor_ans 1] [lindex $tutor_ans 2]
                  .stepper.prod_frame.f3.f.text tag delete [lindex $tutor_ans 3]
                  .stepper.prod_frame.f3.f.text insert [lindex $tutor_ans 1] [lindex $tutor_ans 0]
                  .stepper.prod_frame.f3.f.text configure -state disabled
                }
              }
            } else {
              tk_messageBox -icon warning -title "Invalid Selection" \
                            -message "There was additional text selected when clicking on a variable.  Please try again." -type ok
            }
          }
          set strt $word_end
        }
      }
    }
  }
} 

proc get_tutor_response {word side buf is_buf start end name} {
  if {[winfo exists .tutor_response] == 1} {
    tk_messageBox -icon info -type ok -title "Tutoring" \
                  -message "You haven't completed the previous binding yet."
    wm deiconify .tutor_response
    raise .tutor_response

    return 0
  } else {

    global tutor_help
    global tutor_entry
    global tutor_ans

    toplevel .tutor_response
    wm withdraw .tutor_response
    wm title .tutor_response "Tutor Response"

    wm geometry .tutor_response [get_configuration .tutor_response]

    label .tutor_response.label \
          -text "What is the binding for $word?" \
          -justify left -font label_font

    entry .tutor_response.entry \
          -width 50 -textvariable tutor_entry -font text_font

    set tutor_entry ""

    set tutor_ans ""

    bind .tutor_response.entry <Key-Return> "accept_tutor_response $word $start $end $name"
    
    label .tutor_response.help \
          -textvariable tutor_help \
          -justify left -font label_font \
          -height 2
    
    set tutor_help ""

    button .tutor_response.help_button -text "Help" -font button_font -command "tutor_help $word"
    button .tutor_response.hint_button -text "Hint" -font button_font -command "tutor_hint $word $side $buf $is_buf"

    bind .tutor_response.entry <Destroy> {
      if {$tutor_ans == ""} {
        set tutor_ans "NoAnswer"
      }
    }    

    pack .tutor_response.label -anchor w
    pack .tutor_response.entry -anchor w
    pack .tutor_response.help -anchor w
    pack .tutor_response.hint_button -side left
    pack .tutor_response.help_button -side left

    wm deiconify .tutor_response

    after idle {focus .tutor_response.entry}

    return 1
  }
}

proc accept_tutor_response {word start end name} {
  global tutor_entry
  global tutor_help
  global tutor_ans
  global tutor_answers

  if {$tutor_entry != ""} {

    set correct [lindex $tutor_answers($word) 0]

    if {[string compare -nocase $correct [string trim $tutor_entry]] == 0} {

      set tutor_ans [list $correct $start $end $name]
      destroy .tutor_response

      if {[lindex $tutor_answers($word) 1] == 0} {
        
        set i [string length "$word : "]
        set l [lindex $tutor_answers($word) 2]
 
        .stepper.prod_frame.f2.f.text insert "$l.$i" $correct
        
        set tutor_answers($word) [list $correct 1]
      }

    } else {
      set tutor_help "Incorrect.\n$tutor_entry is not the binding for $word in this instantiation."
      set tutor_entry ""
    }
  }
}


proc tutor_hint {word side buf is_buf} {
  global tutor_help
  global tutor_answers
  
  if {[lindex $tutor_answers($word) 1] == 1} {
    set tutor_help "Look in the bindings section of the stepper window\nto see the current binding for $word."
  } elseif {$side == "rhs"} {
    set tutor_help "You should find the binding for $word on\nthe left hand side of the production first."
  } elseif $is_buf {
    set tutor_help "Use the buffer contents tool to determine the chunk in the [string range $word 1 end] buffer."
  } elseif {$side == "lhs" && $buf != ""} { 
    set tutor_help "$word is in a slot of the [string range $buf 1 end] buffer.\nYou can find its value using the buffer contents tool."
  } else {
    set tutor_help "No hint is available for this variable.  If it is in a !bind! or !mv-bind! you will need to use the help button to get the answer."
  }
}

proc tutor_help {word} {
  global tutor_help
  global tutor_answers

  set tutor_help "The binding of $word is [lindex $tutor_answers($word) 0]"
}


button [control_panel_name].step_button -command {select_stepper} -text "Stepper" -font button_font

pack [control_panel_name].step_button
