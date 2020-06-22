;;; ----- ----- ----- ----- ----- ;;;
;;; -----    
;;; -----    ENGINE FIRE  Normative Metamodel  
;;; -----    author:      s.blum@campus.tu-berlin.de
;;; -----    
;;; ----- ----- ----- ----- ----- ;;;


(clear-all)


(define-model normative-main
  (sgp
   ;:auto-attend t
   :esc t
   :v nil
   :rt -1               
   :time-master-start-increment 1.0
   :time-mult 1.0
   :time-noise 0.001
   ;:trace-detail low
   :ul t
   ;:tone-detect-delay 1.0
   )

;; Disable aural buffer stuffing for model-generated speech/sounds
(set-audloc-default - location self :attended nil)
; (set-visloc-default) ;; Disable visual buffer stuffing
   
;; CHUNK-TYPES

(chunk-type goal state next prev)
(chunk-type mentalmodel AOIpT 
                        resultleft
                        resultmiddle
                        resultright
                        resultaction
                        resultactionmodel
                        uppertime
                        lowertime)

(chunk-type simulate-models state)
(chunk-type flight-data altitude)
(chunk-type flight-info event
                        SPEED
                        ALTITUDE
                        speed-trend
                        altitude-trend
                        focus)
(chunk-type actiontime object 
                       uppertime
                       lowertime)

(define-chunks 
    (start isa chunk)
    (goal isa simulate-models state start)
    (produce-speech isa chunk)
    (respond isa chunk)
    (match isa chunk)
    (passed isa chunk)
    (keep-monitoring isa chunk)
    (waiting isa chunk)
    (scanning isa chunk)
    (monitoring isa chunk)
    (has-control isa chunk)
    (idle isa chunk)
    (default isa chunk)
    (altitude isa chunk)
    (speed isa chunk)
    (decreasing isa chunk)
    (increasing isa chunk)
    (back-to-monitoring isa chunk)
    (wait-for-focus-result isa chunk)
    (action isa chunk)
    (actionresult isa chunk)
    (actiontimecalc isa chunk)
    (AOIpT isa chunk)
    (SIMULATE-SUBMODEL-AOI isa chunk)
    (MATCH-LEFT isa chunk)
    (MATCH-RIGHT isa chunk)
    (MATCH-MIDDLE isa chunk)
    (SIM-SUB-ACTION-LEFT isa chunk)
    (SIM-SUB-ACTION-MIDDLE isa chunk)
    (SIM-SUB-ACTION-RIGHT isa chunk)
    (CALCULATE-ACTION isa chunk)
    (SCAN-ACTION isa chunk)
    (SCAN-PRIMARY-FLIGHT-DISPLAY isa chunk)
    (ATTEND-FLIGHT-INFO-DISPLAY isa chunk)
    (SCAN-THRUSTLEVER isa chunk)
    (THRUSTLEVER isa chunk)
    (SUCCESSFUL isa chunk)
    (FAILED isa chunk)
    (ALT isa chunk)
    (SPD isa chunk)
    (END isa chunk)

    (PFD isa chunk)
    (ND isa chunk)
    (WD isa chunk)
    (OV isa chunk)
    (MFD isa chunk)
   
    (TIME isa chunk)
    (AUD_FWSNUMBER isa chunk)
    (AUD_ALARMNUMBER isa chunk)
    (FCUALTSELOUT_SIMAPLAW_A isa chunk)
    (FCUALTSELOUT_SIMAPLAW_B isa chunk)
    (FCU_ALTKNOBINCREMENT isa chunk)
    (IR1OUT_A4_I_150_GPS_UTC_HOURS isa chunk)
    (IR1OUT_A4_I_150_GPS_UTC_MINUTES isa chunk)
    (IR1OUT_A4_I_150_GPS_UTC_SECONDS isa chunk)
    (BAP1ENGDOUT_SIMAPLAW_A isa chunk)
    (B1FDENGDNCOUT_SIMAPLAW_A isa chunk)
    (B1FDENGDNCOUT_SIMAPLAW_B isa chunk)
    (BATHRENGDOUT isa chunk)
    (P_PEDALS_STEERING isa chunk)
    (P_PEDAL_LEFT_BRAKE isa chunk)
    (P_PEDAL_LEFT_BRAKE_PERCENT isa chunk)
    (P_PEDAL_RIGHT_BRAKE isa chunk)
    (P_PEDAL_RIGHT_BRAKE_PERCENT isa chunk)
    (P_THROTTLE_LEVER_ANGLE_ENGINE_1 isa chunk)
    (P_THROTTLE_LEVER_ANGLE_ENGINE_2 isa chunk)
    (P_THROTTLE_LEVER_ANGLE_ENGINE_3 isa chunk)
    (P_THROTTLE_LEVER_ANGLE_ENGINE_4 isa chunk)
    (P_LEFT_SIDESTICK_TRIGGER_PRESSED isa chunk)
    (P_LG_PANEL_ANTI_SKID_POSITION_SELECTED isa chunk)
    (P_LG_PANEL_GEAR_DOWN_REQUEST isa chunk)
    (P_LG_PANEL_GEAR_UP_REQUEST isa chunk)
    (P_LG_PANEL_RTO_BUTTON_PRESSED isa chunk)
    (P_LEFT_SIDESTICK_PITCH_CTRL isa chunk)
    (P_LEFT_SIDESTICK_ROLL_CTRL isa chunk)
    (P_RIGHT_SIDESTICK_PITCH_CTRL isa chunk)
    (P_RIGHT_SIDESTICK_ROLL_CTRL isa chunk)
    (CKT_ENGINE1MASTERLEVERON isa chunk)
    (CKT_ENGINE2MASTERLEVERON isa chunk)
    (CKT_THRUSTLEVERANGLE[0] isa chunk)
    (CKT_THRUSTLEVERANGLE[1] isa chunk)
    (CKT_THRUSTLEVERANGLE[2] isa chunk)
    (CKT_THRUSTLEVERANGLE[3] isa chunk)
    (P_TRIM_CP_RUDDER_RESET isa chunk)
    (P_FLAPS_BOOLEAN_1 isa chunk)
    (P_FLAPS_BOOLEAN_2 isa chunk)
    (P_FLAPS_BOOLEAN_3 isa chunk)
    (P_FLAPS_BOOLEAN_4 isa chunk)
    (P_FLAPS_BOOLEAN_5 isa chunk)
    (P_GLS_L_MASTER_CAUTION_BUTTON_PUSHED isa chunk)
    (P_GLS_R_MASTER_WARNING_BUTTON_PUSHED isa chunk)
    (FCU_LEFTBAROSETTING isa chunk)
    (ALTFCU isa chunk)
    (BGOTOFCUOUT_SIMAPLAW_A isa chunk)
    (FCGS_FCUVERTICALSPEEDSELECT isa chunk)
    (FCGS_HDGTRKTARGETTOBEDISPLAYEDONFCU isa chunk)
    (FCUALTSELPROUT_SIMAPLAW_A isa chunk)
    (FCULATSELPROUT_SIMAPLAW_A isa chunk)
    (FCUMACHSELOUT_SIMAPLAW_A isa chunk)
    (FCUMODEOUT_SIMAPLAW_A isa chunk)
    (FCURANGEOUT_SIMAPLAW_A isa chunk)
    (FCUSPDSELOUT_SIMAPLAW_A isa chunk)
    (FCUSPDSELPROUT_SIMAPLAW_A isa chunk)
    (FCUVSSELPROUT_SIMAPLAW_A isa chunk)
    (FCU_ALTRATESELECTOR isa chunk)
    (FCU_RIGHTBAROSETTING isa chunk)
    (FCU_ADAPTRANGECPT10NM isa chunk)
    (FCU_ADAPTRANGECPT20NM isa chunk)
    (FCU_ADAPTRANGECPT40NM isa chunk)
    (FCU_ADAPTRANGEFO10NM isa chunk)
    (FCU_ADAPTRANGEFO20NM isa chunk)
    (AOI isa chunk)
    (ALARMACTIVE isa chunk)
    (NAN isa chunk)
  )


(add-dm
    (lm ISA actiontime object "l" uppertime 29 lowertime 22)
    (mm ISA actiontime object "m" uppertime 21 lowertime 14)
    (rm ISA actiontime object "s" uppertime 12 lowertime 8)
    (nm ISA actiontime object "n" uppertime 25 lowertime 12)
  )


;;; -------------------------------------------------------------------------------------------
;;; ---------------------------- INITIALIZE THAT CSPM HAS CONTROL -----------------------------
;;; -------------------------------------------------------------------------------------------


(p wait-for-start
    =goal>
      state             start
  ==>
    =goal>
      state             waiting
  )


(p start-flight 
    =goal>
      state waiting
    ?imaginal>
      state             free
    ?vocal>
      state             free
  ==>
    +vocal>
      cmd               speak
      string            "CSPM has control"
   +imaginal>
      isa               flight-info
      altitude          0 
      speed             0
      altitude-trend    "default" 
      speed-trend       "default"
      focus             "default"
    =goal>
      state             has-control
  )


(p start-monitoring
    =goal>
      state             has-control
  ==>
    =goal>
      state             scan-primary-flight-display
      next 				AOIpT
      prev 				SPD
!eval! ("state-initialized" "start")
  )





;;; -------------------------------------------------------------------------------------------
;;; ---------------------------------- FIRST MONITORING LOOP ----------------------------------
;;; -------------------------------------------------------------------------------------------



(p scan-primary-flight-display
  =goal>
    state               scan-primary-flight-display
    next                =display
  ?visual>
    state               free
  ?visual-location>
    state               free
==>
  +visual>
    clear               t ;; Prevent visual buffer from updating without explicit requests
  +visual-location>
    color               =display
  =goal>
    state               idle
  )


(p attend-flight-info 
  =goal>
    state 		          idle
  =visual-location>
  ?visual>
    state 		          free
==>
  @visual-location>
  +visual>
    cmd 			      move-attention
    screen-pos 	          =visual-location
  =goal>
    state 		          idle
  )


(p update-pilot-focus-ALT ;; Update increasing altitude info in imaginal
  =goal>
    state               idle ;attending-display
    prev 				SPD
  =imaginal>
  =visual>
    color               AOIpT
    value               =value
==>
  @visual-location>
  @visual>
  =imaginal>
    focus               =value
  =goal>
    state               scan-primary-flight-display
    next 				ALTITUDE
    prev 				AOIpT
  )


(p update-pilot-focus-SPD ;; Update increasing altitude info in imaginal
  =goal>
    state               idle ;attending-display
    prev 				ALT
  =imaginal>
  =visual>
    color               AOIpT
    value               =value
==>
  @visual-location>
  @visual>
  =imaginal>
    focus               =value
  =goal>
    state               scan-primary-flight-display
    next 				SPEED
    prev 				AOIpT
  )



(p update-speed-decrease
  =goal>
    state               idle ;attending-display
    prev 				AOIpT
  =imaginal>
  > SPEED               =val
  =visual>
    color               SPEED
    value               =val
==>
  @visual-location>
  @visual>
  =imaginal>
    SPEED               =val
    speed-trend         decreasing
  =goal>
    state               scan-primary-flight-display
    next 				AOIpT
    prev 				SPD
  ) 


(p update-speed-increase ;; Update increasing speed info in imaginal buffer
  =goal>
    state               idle ;attending-display
    prev 				AOIpT
  =imaginal>
  < SPEED               =val
  =visual>
    color               SPEED
    value               =val
==>
  @visual-location>
  @visual>
  =imaginal>
    SPEED               =val
    speed-trend         increasing
  =goal>
    state               scan-primary-flight-display
    next 				AOIpT
    prev 				SPD
  ) 



(p update-altitude-increase ;; Update increasing altitude info in imaginal
  =goal>
    state idle ;attending-display
    prev 				AOIpT
  =imaginal>
  < ALTITUDE            =val
  =visual>
    color               ALTITUDE
    value               =val
==>
  @visual-location>
  @visual>
  =imaginal>
    ALTITUDE            =val
    altitude-trend      increasing
  =goal>
    state               scan-primary-flight-display
    next 				AOIpT
    prev 				ALT
  )


(p update-altitude-decrease
  =goal>
    state               idle ;attending-display
    prev 				AOIpT
  =imaginal>
  > ALTITUDE            =val
  =visual>
    color               ALTITUDE
    value               =val
==>
  @visual-location>
  @visual>
  =imaginal>
    ALTITUDE            =val
    altitude-trend      decreasing
  =goal>
    state               scan-primary-flight-display
    next 				AOIpT
    prev 				ALT
  )




;;; -------------------------------------------------------------------------------------------
;;; ---------------------------------- HEAR TONE ALERT ----------------------------------------
;;; -------------------------------------------------------------------------------------------


(p hear-tone ;; If tone appears, move aural-attention and go to p300/tone
  =goal>
  ;  state               idle
  =aural-location>
  ?aural>
    state               free
  ==>
  +aural>
    event               =aural-location
  =goal>
    state               produce-speech
  )


(p process-speed-warning
  =goal>
    state               produce-speech
  =aural>
    event               =aural-location
  =imaginal>
    isa                 flight-info
    focus               =focus
  ?temporal>
    state               free
  ==>
  +temporal> 
    isa                 time
  +imaginal>
    isa                 mentalmodel
    AOIpT               =focus ; This needs to be AOIpT    "PFD";
  =goal>
    state               respond
!eval! ("state-hear-tone" "start")
  )


(p wait-for-simulation
  =goal>
    state               respond
  ?vocal>
    state               free
  =imaginal>
==>
  =imaginal>
  +vocal>
    cmd                 speak
    string              "ECAM action please"
 =goal>
    state               simulate-submodel-AOI
  )




;;; -------------------------------------------------------------------------------------------
;;; ------------------------------ SIMULATE NORMATIVE RESPONSETIME -------------------------------------
;;; -------------------------------------------------------------------------------------------


(p simulate-normative-submodel
  =goal>
    state               simulate-submodel-AOI
  =imaginal>
==>
  =imaginal>
  =goal>
    state               actiontimecalc
!eval! ("simulate-action-normative" "start")
  )






;;; --------------------------------------------------------------------------------------------
;;; ------------------------------ CALCULATE MODELS ACTION -------------------------------------
;;; --------------------------------------------------------------------------------------------


(P retrieve-action
  =goal>
    state               actiontimecalc
  =imaginal>
    isa                 mentalmodel
    resultactionmodel   =actionresult
==>
  =imaginal>
  +retrieval>  
    ISA                 actiontime
    object              =actionresult
  =goal>
    state               calculate-action
  )


(P calculate-action
  =goal>
    state               calculate-action
  =retrieval>  
    ISA                 actiontime
    object              =actionresult
    uppertime           =uptime
    lowertime           =lowtime
  =imaginal>
==>
  =retrieval>  
  =imaginal>
    isa                 mentalmodel
    uppertime           =uptime
    lowertime           =lowtime
  =goal>
    state               scan-thrustlever
    next                CKT_ThrustLeverAngle[0]
  )




;;; ------------------------------------------------------------------------------------------------
;;; ------------------------------------- ATTEND THRUSTLEVER ---------------------------------------
;;; ------------------------------------------------------------------------------------------------


(p scan-thrustlever
  =goal>
    state               scan-thrustlever
    next                =display
  ?visual>
    state               free
  ?visual-location>
    state               free
==>
  +visual>
    clear               t ;; Prevent visual buffer from updating without explicit requests
  +visual-location>
    color               =display
  =goal>
    state               thrustlever
  )

 
(p attend-thrustlever
  =goal>
    state               thrustlever
  =visual-location>
  ?visual>
    state               free
==>
  @visual-location>
  +visual>
    cmd                 move-attention
    screen-pos          =visual-location
  =goal>
    state               scan-action
)
 


;;; ------------------------------------------------------------------------------------------------
;;; ---------------------------------- ACTION TIME MONITORING LOOP ---------------------------------
;;; ------------------------------------------------------------------------------------------------


(p action-not-found
  =goal>
    state               scan-action
    next                =next
  =visual>
    color               =next
  > value               0
==>
  =visual>
  =goal>
      state             action-not-found
  )


(p action-found
  =goal>
    state               scan-action
    next                =next
  =visual>
    color               =next
  = value               0
==>
  =visual>
  =goal>
      state             action-found
  )

;;; ----- ACTION NOT FOUND ---------------------------------

(p action-not-found-below-upper
  =goal>
    state               action-not-found
  =imaginal>
  >= uppertime          =ticktime
  =temporal>
    ticks               =ticktime
==>
  =temporal>
  =imaginal>
  =goal>
    state               scan-thrustlever
    next                CKT_ThrustLeverAngle[0]
  )


(p action-not-found-above-upper
  =goal>
    state               action-not-found
    next                =next
  =imaginal>
  < uppertime           =ticktime
  =temporal>
    ticks               =ticktime
==>
  =temporal>
  =imaginal>
  =goal>
    state               failed
  )

;;; ----- ACTION FOUND ---------------------------------

(p action-found-in-range
  =goal>
    state               action-found
    next                =next
  =imaginal>
  >= uppertime          =ticktime
  <= lowertime          =ticktime
  =temporal>
    ticks               =ticktime
==>
  =temporal>
  =imaginal>
  =goal>
    state               successful
  )


(p action-found-above-range
  =goal>
    state               action-found
    next                =next
  =imaginal>
  <= uppertime          =ticktime
  =temporal>
    ticks               =ticktime
==>
  =temporal>
  =imaginal>
  =goal>
    state               failed
  )


(p action-found-below-range
  =goal>
    state               action-found
    next                =next
  =imaginal>
  >= lowertime          =ticktime
  =temporal>
    ticks               =ticktime
==>
  =temporal>
  =imaginal>
  =goal>
    state               failed
  )


;;; ------------------------------------------------------------------------------------------------
;;; -------------------------------- STATE IF ANTICIPATION CORRECT ---------------------------------
;;; ------------------------------------------------------------------------------------------------


(p anticipation-correct
  =goal>
    state               successful
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticktime
  =visual>
    value               =value
==>
  =visual>
    value               =value
  =temporal>
    ticks               =ticktime
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               back-to-monitoring
   !output! (action was CORRECT)
!eval! ("state-anticipation-correct" "successful" =value =ticktime =uppertime =lowertime)
  )


(P anticipation-failed
  =goal>
    state               failed
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticktime
  =visual>
    value               =value
==>
  =visual>
    value               =value
  =temporal>
    ticks               =ticktime
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               back-to-monitoring
  !output! (action was INCORRECT)
!eval! ("state-anticipation-not-correct" "failed" =value =ticktime =uppertime =lowertime)
  )


(spp anticipation-correct :reward 100)

(spp anticipation-failed :reward 0)



(p back-in-monitoring
  =goal>
    state               back-to-monitoring
  =imaginal>
  =temporal>
  =visual>
==>
  =goal>
    state               scan-primary-flight-display
    next 				AOIpT
    prev 				SPD
  -temporal>
  +imaginal>
      isa               flight-info
      altitude          0	
      speed 			      0
      altitude-trend    "default"	
      speed-trend 	    "default"
      focus             "default"  
  @visual> 
  )





;;; ------------------------------------------------------------------------------------------------
;;; ---------------- END SIMULATION OF PILOT IS NOT LOOKING ANYWHERE | AOIpT == x ------------------
;;; ------------------------------------------------------------------------------------------------


(p break-loop-end-program-ALT
  =goal>
    state               idle ;attending-display
    prev 				ALT
  =imaginal>
  =visual>
    color               AOIpT
    value               "x"
==>
  @visual-location>
  @visual>
  -imaginal>
  =goal>
    state               end
!eval! ("end-program" 1)
  )


(p break-loop-end-program-SPD
  =goal>
    state               idle ;attending-display
    prev 				SPD
  =imaginal>
  =visual>
    color               AOIpT
    value               "x"
==>
  @visual-location>
  @visual>
  -imaginal>
  =goal>
    state               end
!eval! ("end-program" 1)
  )


(p break-loop-end-program-AOIpT
  =goal>
    state               idle ;attending-display
    prev 				AOIpT
  =imaginal>
  =visual>
    color               AOIpT
    value               "x"
==>
  @visual-location>
  @visual>
  -imaginal>
  =goal>
    state               end
!eval! ("end-program" 1)
   )



(goal-focus goal)

)

