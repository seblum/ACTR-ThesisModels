
;;; ----- ----- ----- ----- ----- ;;;
;;; -----                   ----- ;;;
;;; -----    ENGINE FIRE    ----- ;;;
;;; -----                   ----- ;;;
;;; ----- ----- ----- ----- ----- ;;;


;;; UTILITY LEARNING


(clear-all)

(define-model main-model
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

(chunk-type goal state 
                 next 
                 prev
                 action
                 keepinmind
                 )
(chunk-type mentalmodel AOIpT 
                        resultfocus
                        resultactionone
                        resultactiontwo
                        uppertime
                        lowertime 
                        )

(chunk-type simulate-models state)
(chunk-type flight-data altitude)
(chunk-type flight-info event
                        SPEED
                        ALTITUDE
                        speed-trend
                        altitude-trend
                        focus 
                        )
(chunk-type actiontime object 
                       action
                       uppertime
                       lowertime 
                       )

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
    (retrieve-action isa chunk)
    (AOIpT isa chunk)
    (SIMULATE-SUBMODEL isa chunk)
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
    (lm1 ISA actiontime object "l" action 1 uppertime 28 lowertime 22) ; mean = 25 +-3
    (lm2 ISA actiontime object "l" action 2 uppertime 40 lowertime 34) ; mean = 37
    
    (mm1 ISA actiontime object "m" action 1 uppertime 20 lowertime 14) ; mean = 17
    (mm2 ISA actiontime object "m" action 2 uppertime 25 lowertime 19) ; mean = 22

    (rm1 ISA actiontime object "s" action 1 uppertime 13 lowertime 7)  ; mean = 10
    (rm2 ISA actiontime object "s" action 2 uppertime 19 lowertime 13) ; mean = 16
       
    (am1 ISA actiontime object "a" action 99 uppertime 25 lowertime 12)
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
      speed 			      0
      altitude-trend    "default"	
      speed-trend 	    "default"
      focus             "default"
    =goal>
      state  		        has-control
  )


(p start-monitoring
    =goal>
      state             has-control
  ==>
    =goal>
      state             scan-primary-flight-display
      next 				      AOIpT
      prev 				      SPD
      keepinmind          0
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
    cmd 			          move-attention
    screen-pos 	        =visual-location
  =goal>
    state 		          idle
  )

;;; ---------------------------------- update focus ----------------------------------


(p update-pilot-focus-ALT
  =goal>
    state               idle
    prev 				        SPD
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
    next 				        ALTITUDE
    prev 				        AOIpT
  ;  next                AOIpT
  ;  prev                SPD
  )


(p update-pilot-focus-SPD
  =goal>
    state               idle
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
    next 				       SPEED
    prev 				       AOIpT
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
    next 				        AOIpT
    prev 				         SPD
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


(p hear-tone ;; If tone appears, move aural-attention
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
    AOIpT               "PFD" ; This needs to be AOIpT =focus   "PFD";
  =goal>
    state         	    respond
  )


(p wait-for-simulation
	=goal>
		state 			        respond
  ?vocal>
    state               free
  =imaginal>
==>
  =imaginal>
  +vocal>
    cmd                 speak
    string              "ECAM action please"
 =goal>
	  state 			        simulate-submodel
    action              0
	)




;;; -------------------------------------------------------------------------------------------
;;; ------------------------------ SIMULATE SUBMODELS AOI -------------------------------------
;;; -------------------------------------------------------------------------------------------


(p simulate-break
  =goal>
    state               simulate-submodel
    action              0
  =imaginal>
  =temporal> 
  >= ticks              4
==>
  =temporal> 
  =imaginal>
  =goal>
    state               back-to-monitoring
  )


(p simulate-left-submodel
  =goal>
    state               simulate-submodel
    action              =actionnumber
  =imaginal>
==>
  =imaginal>
  =goal>
    state               free
    action              =actionnumber
!eval! ("simulate-submodel" "left-model" =actionnumber)
  )


(p simulate-middle-submodel
  =goal>
    state               simulate-submodel
    action              =actionnumber
  =imaginal>
==>
  =imaginal>
  =goal>
    state               free
    action              =actionnumber
!eval! ("simulate-submodel" "middle-model" =actionnumber)
  )


(p simulate-right-submodel
  =goal>
    state               simulate-submodel
    action              =actionnumber
  =imaginal>
==>
  =imaginal>
  =goal>
    state               free
    action              =actionnumber
!eval! ("simulate-submodel" "right-model" =actionnumber)
  )


(spp simulate-left-submodel   :u 100)
(spp simulate-middle-submodel :u 100)
(spp simulate-right-submodel  :u 100)
(spp simulate-break           :u 100)




;;; -------------------------------------------------------------------------------------------
;;; ------------------------------ MATCH SUBMODELS AOI -------------------------------------
;;; -------------------------------------------------------------------------------------------


(P match-focus
  =goal>
    state               match-focus
    action              0
  =imaginal>
    AOIpT               =result
    resultfocus         =result
  ==>
  =goal>
    state               simulate-submodel
    action              1
  =imaginal>
  )


(P not-match-focus
  =goal>
    state               match-focus
    action              0
  =imaginal>
    AOIpT               =result
  - resultfocus         =result
  ==>
  =goal>
    state               simulate-submodel
    action              0
  =imaginal>
  )


(spp match-focus     :reward 50)
(spp not-match-focus :reward 0)



;;; -----------------------------------------------------------------------------------------------
;;; ------------------------------ CALCULATE SUBMODELS ACTION -------------------------------------
;;; -----------------------------------------------------------------------------------------------


(P retrieve-action-1
  =goal>
    state               retrieve-action
    action              1
    action              =actionnumber
  =imaginal>
    isa                 mentalmodel
    resultactionone     =actionresult
==>
  =imaginal>
  +retrieval>  
    ISA                 actiontime
    object              =actionresult
    action              =actionnumber
  =goal>
    state               calculate-action
    action              =actionnumber
  )


(P retrieve-action-2
  =goal>
    state               retrieve-action
    action              2
    action              =actionnumber
  =imaginal>
    isa                 mentalmodel
    resultactiontwo     =actionresult
==>
  =imaginal>
  +retrieval>  
    ISA                 actiontime
    object              =actionresult
    action              =actionnumber
  =goal>
    state               calculate-action
    action              =actionnumber
  )


(P calculate-action-1
  =goal>
    state               calculate-action
    action              1
  =retrieval>  
    ISA                 actiontime
    object              =actionresult
    action              1
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
    state               scan-action
    next                CKT_ThrustLeverAngle[0]
  )


(P calculate-action-2
  =goal>
    state               calculate-action
    action              2
  =retrieval>  
    ISA                 actiontime
    object              =actionresult
    action              2
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
    state               scan-action
    next                CKT_Engine1MasterLeverOn
  )



;;; ------------------------------------------------------------------------------------------------
;;; ------------------------------------- ATTEND THRUSTLEVER ---------------------------------------
;;; ------------------------------------------------------------------------------------------------


(p scan-action
  =goal>
    state               scan-action
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
    state               attend-action
  )

 
(p attend-action
  =goal>
    state               attend-action
  =visual-location>
  ?visual>
    state               free
==>
  @visual-location>
  +visual>
    cmd                 move-attention
    screen-pos          =visual-location
  =goal>
    state               check-action
)
 



;;; ------------------------------------------------------------------------------------------------
;;; ---------------------------------- ACTION TIME MONITORING LOOP ---------------------------------
;;; ------------------------------------------------------------------------------------------------


(p action-not-found
  =goal>
    state               check-action
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
    state               check-action
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
    state               scan-action
  )


(p action-not-found-above-upper
  =goal>
    state               action-not-found
  =imaginal>
  < uppertime           =ticktime
  =temporal>
    ticks               =ticktime
==>
  =temporal>
  =imaginal>
  =goal>
    state               scan-action
  )


;;; ----- ACTION FOUND 1 ---------------------------------


(p action-1-failed
  =goal>
    state               action-found
    action              1
  =temporal>
  > ticks               28
==>
  =temporal>
  =goal>
    state               failed
  )

(spp action-1-failed :u 100)
(spp action-1-failed :reward 0)


(p action-1-found-in-range-keepinmind
  =goal>
    state               action-found
    action              1
    keepinmind          =ticktime
  - keepinmind          0
  =imaginal>
  >= uppertime          =ticktime
  <= lowertime          =ticktime
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticks
==>
  =temporal>
    ticks               =ticks
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               simulate-submodel
    action              2
    keepinmind          =ticktime
  )

(spp action-1-found-in-range-keepinmind :u 120)
(spp action-1-found-in-range-keepinmind :reward 50)


(p action-1-found-in-range
  =goal>
    state               action-found
    action              1
    keepinmind          0
  =imaginal>
  >= uppertime          =ticks
  <= lowertime          =ticks
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticks
==>
  =temporal>
    ticks               =ticks
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               simulate-submodel
    action              2
  )

(spp action-1-found-in-range :u 120)
(spp action-1-found-in-range :reward 50)


(p action-1-found-above-range
  =goal>
    state               action-found
    action              1
    keepinmind          0
  =imaginal>
  < uppertime           =ticks
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticks
==>
  =temporal>
    ticks               =ticks
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               simulate-submodel
    action              1
    keepinmind          =ticks
  )

(spp action-1-found-above-range :u 120)
(spp action-1-found-above-range :reward 0)


(p action-1-found-above-range-keepinmind
  =goal>
    state               action-found
    action              1
    keepinmind          =ticktime
  - keepinmind          0
  =imaginal>
  < uppertime           =ticktime
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticks
==>
  =temporal>
    ticks               =ticks
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               simulate-submodel
    action              1
    keepinmind          =ticktime
  )

(spp action-1-found-above-range-keepinmind :u 120)
(spp action-1-found-above-range-keepinmind :reward 0)


(p action-1-found-below-range
  =goal>
    state               action-found
    action              1
    keepinmind          0
  =imaginal>
  > lowertime           =ticks
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticks
==>
  =temporal>
    ticks               =ticks
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               simulate-submodel
    action              1
    keepinmind          =ticks
  )

(spp action-1-found-below-range :u 120)
(spp action-1-found-below-range :reward 0)


(p action-1-found-below-range-keepinmind
  =goal>
    state               action-found
    action              1
    keepinmind          =ticktime
  - keepinmind          0
  =imaginal>
  > lowertime           =ticktime
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticks
==>
  =temporal>
    ticks               =ticks
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               simulate-submodel
    action              1
    keepinmind          =ticktime
  )

(spp action-1-found-below-range-keepinmind :u 120)
(spp action-1-found-below-range-keepinmind :reward 0)


;;; ----- ACTION FOUND 2 ---------------------------------


(p action-2-failed-not-found
  =goal>
    state               action-not-found
    action              2
  =temporal>
  > ticks               40
==>
  =temporal>
  =goal>
    state               failed
)

(spp action-2-failed-not-found :u 120)
(spp action-2-failed-not-found :reward 0)

(p action-2-failed
  =goal>
    state               action-found
    action              2
  =temporal>
  > ticks               40
==>
  =temporal>
  =goal>
    state               failed
  )

(spp action-2-failed :u 120)
(spp action-2-failed :reward 0)

(p action-2-found-in-range-keepinmind
  =goal>
    state               action-found
    action              2
    keepinmind          =ticktime
  - keepinmind          0
  =imaginal>
  >= uppertime          =ticktime
  <= lowertime          =ticktime
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticks
==>
  =temporal>
    ticks               =ticks
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               successful
    keepinmind          =ticktime
  )

(spp action-2-found-in-range-keepinmind :u 120)
(spp action-2-found-in-range-keepinmind :reward 50)


(p action-2-found-in-range
  =goal>
    state               action-found
    action              2
    keepinmind          0
  =imaginal>
  >= uppertime          =ticks
  <= lowertime          =ticks
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticks
==>
  =temporal>
    ticks               =ticks
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               successful
  )

(spp action-2-found-in-range :u 120)
(spp action-2-found-in-range :reward 50)

(p action-2-found-above-range
  =goal>
    state               action-found
    action              2
    keepinmind          0
  =imaginal>
  < uppertime           =ticks
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticks
==>
  =temporal>
    ticks               =ticks
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               simulate-submodel
    action              2
    keepinmind          =ticks
  )

(spp action-2-found-above-range :u 120)
(spp action-2-found-above-range :reward 0)


(p action-2-found-above-range-keepinmind
  =goal>
    state               action-found
    action              2
    keepinmind          =ticktime
  - keepinmind          0
  =imaginal>
  < uppertime           =ticktime
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticks
==>
  =temporal>
    ticks               =ticks
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               simulate-submodel
    action              2
    keepinmind          =ticktime
  )

(spp action-2-found-above-range-keepinmind :u 120)
(spp action-2-found-above-range-keepinmind :reward 0)


(p action-2-found-below-range
  =goal>
    state               action-found
    action              2
    keepinmind          0
  =imaginal>
  > lowertime           =ticks
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticks
==>
  =temporal>
    ticks               =ticks
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               simulate-submodel ; change this -below
    action              2
    keepinmind          =ticks 
  )

(spp action-2-found-below-range :u 120)
(spp action-2-found-below-range :reward 0)


(p action-2-found-below-range-keepinmind
  =goal>
    state               action-found
    action              2
    keepinmind          =ticktime
  - keepinmind          0
  =imaginal>
  > lowertime           =ticktime
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticks
==>
  =temporal>
    ticks               =ticks
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               simulate-submodel
    action              2
    keepinmind          =ticktime
  )

(spp action-2-found-below-range-keepinmind :u 120)
(spp action-2-found-below-range-keepinmind :reward 0)


;;; ------------------------------------------------------------------------------------------------
;;; -------------------------------- STATE IF ANTICIPATION CORRECT ---------------------------------
;;; ------------------------------------------------------------------------------------------------


(p anticipation-correct
  =goal>
    state               successful
    keepinmind          =ticktime
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticks
  =visual>
    value               =value
==>
  =visual>
    value               =value
  =temporal>
    ticks               =ticks
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               back-to-monitoring
    keepinmind          =ticktime
  )


(P anticipation-failed-1
  =goal>
    state               failed
    action              1
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticks
  =visual>
    value               =value
==>
  =visual>
    value               =value
  =temporal>
    ticks               =ticks
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               simulate-submodel
    action              2
  )


(P anticipation-failed-2
  =goal>
    state               failed
    action              2
    action              =action
    keepinmind          =ticktime
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =temporal>
    ticks               =ticks
  =visual>
    value               =value
==>
  =visual>
    value               =value
  =temporal>
    ticks               =ticks
  =imaginal>
    uppertime           =uppertime
    lowertime           =lowertime
  =goal>
    state               back-to-monitoring
    action              =action
    keepinmind          =ticktime
  )


(spp anticipation-correct :reward 20)



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
    prev 				        ALT
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
  )


(p break-loop-end-program-AOIpT
  =goal>
    state               idle ;attending-display
    prev 				        AOIpT
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
   )


(p break-loop-end-program-SPD
  =goal>
    state               idle ;attending-display
    prev                SPD
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
  )






(goal-focus goal)


)

