;;; ----- ----- ----- ----- ----- ;;;
;;; -----    
;;; -----    WIND SHEAR   ISM Metamodel  
;;; -----    author:      s.blum@campus.tu-berlin.de
;;; -----    date:        18/12/2019
;;; -----    
;;; ----- ----- ----- ----- ----- ;;;


(clear-all)

(define-model main-model
  (sgp
   ;:auto-attend t
   :esc t
   :v nil
   :rt -1               
   :time-master-start-increment 0.085
   :time-mult 1.55
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
                 scenario
                 anticipate
                 actiontime_4
                 previousreaction)

(chunk-type mentalmodel actiontime_4 
                        actiontime_10
                        resultleft
                        resultright
                        resultaction
                        resultactionmodel
                        behavior_4
                        behavior_10
                        anticipation)

(chunk-type flight-info scenario
                        prev
                        SPEED
                        ALTITUDE
                        speed-trend
                        altitude-trend)


(define-chunks 
    (start isa chunk)
    (goal isa chunk)
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
    (FIND-BEHAVIOR isa chunk)
    (ATTEND-BEHAVIOR isa chunk)
    (SCAN-BEHAVIOR isa chunk)
    (CALCULATE-BEHAVIOR isa chunk)
    (SIMULATE-SUBMODEL isa chunk)
    (COMPARE-ANTICIPATION isa chunk)
    (BREAK-PRIMARY-FLIGHT-DISPLAY isa chunk)
    (ATTEND-ACTION isa chunk)
    (LOOP-ACTION isa chunk)
    (START-WAITING isa chunk)
    (BREAK-LOOP-END-PROGRAM isa chunk)

   )

(add-dm
    (eve4  ISA flight-info scenario 2 SPEED 290.0 ALTITUDE 220.0 speed-trend default altitude-trend default)
    (eve10 ISA flight-info scenario 4 SPEED 500.0 ALTITUDE 200000.0 speed-trend default altitude-trend default)
  )


;;; -------------------------------------------------------------------------------------------
;;; ---------------------------- INITIALIZE THAT CSPM HAS CONTROL -----------------------------
;;; -------------------------------------------------------------------------------------------


(p wait-for-start
  =goal>
    state               start
    scenario            =scenario
==>
  =goal>
    state               waiting
  +retrieval>
      isa               flight-info
      scenario          =scenario 
  )


(p start-flight 
    =goal>
      state             waiting
    =retrieval>
      isa               flight-info
      altitude          =altitude 
      speed             =speed
      altitude-trend    =altitude-trend
      speed-trend       =speed-trend
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
      altitude          =altitude	
      speed 			      =speed
      altitude-trend    =altitude-trend
      speed-trend 	    =speed-trend
    =goal>
      state  		        has-control
  )


(p start-monitoring
    =goal>
      state             has-control
  ==>
    =goal>
      state             scan-primary-flight-display
      next 				      ALTITUDE
!eval! ("state-initialized" "start")
  )


;;; -------------------------------------------------------------------------------------------
;;; ---------------------------------- FIRST MONITORING LOOP ----------------------------------
;;; -------------------------------------------------------------------------------------------



(p start-new-scenario
  =goal>
    state               newscenario
    scenario            4
==>
  =goal>
    state               start
    scenario            4
!eval! ("start-scenario" 4)
  )



(p end-program
  =goal>
    state               endprogram
    scenario            end
==>
  =goal>
    state               finish
    scenario            end
!eval! ("end-program" "yes")
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
    state               attend-flight-info
  )


(p attend-flight-info 
  =goal>
    state 		          attend-flight-info
  - scenario            end
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


(p update-speed-decrease
  =goal>
    state               idle ;attending-display
  - scenario            end
  =imaginal>
  >= SPEED               =val
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
    next 				        ALTITUDE
  ) 


(p update-speed-increase ;; Update increasing speed info in imaginal buffer
  =goal>
    state               idle ;attending-display
  - scenario            end
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
    next                ALTITUDE
  ) 



(p update-altitude-increase ;; Update increasing altitude info in imaginal
  =goal>
    state               idle ;attending-display
  - scenario            end
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
    next                SPEED
  )


(p update-altitude-decrease
  =goal>
    state               idle ;attending-display
  - scenario            end
  =imaginal>
  >= ALTITUDE            =val
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
    next                SPEED
  )


;;; -------------------------------------------------------------------------------------------
;;; ---------------------------------- HEAR TONE ALERT ----------------------------------------
;;; -------------------------------------------------------------------------------------------


(p hear-tone ;; If tone appears, move aural-attention
  =goal>
    state               idle
  =aural-location>
  ?aural>
    state               free
  ==>
  +aural>
    event               =aural-location
  =goal>
    state               produce-speech
   !output! (TONE HEARD)
  )


(p process-speed-warning
  =goal>
    state               produce-speech
    scenario            =scenario
  ?temporal>
    state               free
  =aural>
    event               =aural-location
  ==>
  +temporal> 
    isa                 time
  =goal>
    state         	    find-behavior
    next                Action
    scenario            =scenario
!eval! ("state-hear-tone" "start" =scenario)
  )


(p find-behavior
	=goal>
		state 			        find-behavior
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
    state               attend-behavior 
	)



; check when the alert is, fast or slow? 
; for event 4, start simulating
; for event 10, return anticipation result

 
(p attend-behavior
  =goal>
    state               attend-behavior
  =visual-location>
  ?visual>
    state               free
==>
  @visual-location>
  +visual>
    cmd                 move-attention
    screen-pos          =visual-location
  =goal>
    state               scan-behavior
)

;;; -------------------------------------------------------------------------------------------
;;; ------------------------------ Monitor Action Scenario 2 ----------------------------------
;;; -------------------------------------------------------------------------------------------

(p backup-behavior-fallback-2
  =goal>
    state               scan-behavior
    scenario            2
  =visual>
    color               Action
  = value               0.0
  =temporal>
  > ticks               200
    ticks               =ticktime
==>
  @visual>
  @visual-location>
  =temporal>
  +imaginal>
    isa                 mentalmodel
    actiontime_4        =ticktime
    behavior_4          "s"
  =goal>
    state               simulate-submodel
  )

; needs to be adjusted according to what action is performed

(p scan-behavior-negativ-2
  =goal>
    state               scan-behavior
    scenario            2
  =visual>
    color               Action
  = value               0.0
==>
  @visual>
  =goal>
      state             find-behavior
  )

(p scan-behavior-positiv-2
  =goal>
    state               scan-behavior
    scenario            2
  =visual>
    color               Action
  = value               1.0
==>
  @visual>
  =goal>
      state             calculate-behavior
  )


(P calculate-behavior-short-2
  =goal>
    state               calculate-behavior
    scenario            2
  =imaginal>
  =temporal>
  >= ticks              0
  < ticks               4
    ticks               =ticktime
==>
  =temporal>
  +imaginal>
    isa                 mentalmodel
    actiontime_4          =ticktime
    behavior_4          "s"
  =goal>
    state               simulate-submodel
  )


(P calculate-behavior-long-2
  =goal>
    state               calculate-behavior
    scenario            2
  =imaginal>
  =temporal>
  >= ticks               5
    ticks               =ticktime
==>
  =temporal>
  +imaginal>
    isa                 mentalmodel
    actiontime_4          =ticktime
    behavior_4          "l"
  =goal>
    state               simulate-submodel
  )
; simulate both submodels

;;; -------------------------------------------------------------------------------------------
;;; ------------------------------ Monitor Action Scenario 4 ----------------------------------
;;; -------------------------------------------------------------------------------------------


(p backup-behavior-fallback-4
  =goal>
    state               scan-behavior
    scenario            4
  =visual>
    color               Action
  = value               0.0
  =temporal>
  > ticks               200
    ticks               =ticktime
==>
  @visual>
  @visual-location>
  =temporal>
  +imaginal>
    isa                 mentalmodel
    actiontime_10          =ticktime
    behavior_10         "s"
  =goal>
    state               compare-anticipation
  )


(p scan-behavior-negativ-4
  =goal>
    state               scan-behavior
    scenario            4
  =visual>
    color               Action
  = value               0.0
==>
  @visual>
  =goal>
    state               find-behavior
  )


(p scan-behavior-positiv-4
  =goal>
    state               scan-behavior
    scenario            4
  =visual>
    color               Action
  = value               1.0
==>
  =visual>
  =goal>
      state             calculate-behavior
  )


(P calculate-behavior-short-4
  =goal>
    state               calculate-behavior
    scenario            4
 =imaginal>
 =temporal>
  >= ticks              0
  < ticks               3
    ticks               =ticktime
==>
 =temporal>
 +imaginal>
    isa                 mentalmodel
    actiontime_10       =ticktime
    behavior_10         "s"
 =goal>
    state               compare-anticipation
  )


(P calculate-behavior-long-4
  =goal>
    state               calculate-behavior
    scenario            4
  =imaginal>
  =temporal>
  >= ticks              3
    ticks               =ticktime
==>
  =temporal>
  +imaginal>
    isa                 mentalmodel
    actiontime_10       =ticktime
    behavior_10         "l"
  =goal>
    state               compare-anticipation
  )



;;; -------------------------------------------------------------------------------------------
;;; ------------------------------ Break if nothing found -------------------------------------
;;; -------------------------------------------------------------------------------------------





;(p scan-behavior-break-2
;  =goal>
;    state               scan-behavior
;  =temporal>
;   > ticks              200
;  =imaginal>
;==>
;  -temporal>
;  =imaginal>
;    behavior_4          "x"
;    behavior_10         "x"
;    actiontime          "x"
;  =goal>
;      state             failed
;  )


;;; -------------------------------------------------------------------------------------------
;;; ------------------------------ SIMULATE SUBMODELS AOI -------------------------------------
;;; -------------------------------------------------------------------------------------------


(p simulate-left-submodel
  =goal>
    state               simulate-submodel
  =imaginal>
==>
  =imaginal>
  =goal>
    state               free
!eval! ("simulate-focus-left" "start")
  )


(p simulate-right-submodel
  =goal>
    state               simulate-submodel
  =imaginal>
==>
  =imaginal>
  =goal>
    state               free
!eval! ("simulate-focus-right" "start")
  )


(spp simulate-left-submodel  :u 20)
(spp simulate-right-submodel :u 20)



;;; -------------------------------------------------------------------------------------------
;;; ------------------------------   MATCH SUBMODELS AOI  -------------------------------------
;;; -------------------------------------------------------------------------------------------

; check which submodel returns the same time as the previously checked

(P match-left
  =goal>
    state               match-left
  =imaginal>
    behavior_4          =result
    resultleft          =result
    actiontime_4        =ticktime
  ==>
  =goal>
    state               sim-sub-action-left
  =imaginal>
!eval! ("state-submodel-correct" "start" =result =ticktime)
  )


  (P match-right
  =goal>
    state               match-right
  =imaginal>
    behavior_4          =result
    resultright         =result
    actiontime_4        =ticktime
==>
  =goal>
  	state 		          sim-sub-action-right
  =imaginal>
!eval! ("state-submodel-correct" "start" =result =ticktime)
  )


(P not-match-left
  =goal>
    state               match-left
  =imaginal>
    behavior_4          =result
  - resultleft          =result
==>
  =goal>
    state               simulate-submodel
  =imaginal>
!eval! ("state-submodel-not-correct" "start")
  )


(P not-match-right
  =goal>
    state               match-right
  =imaginal>
    behavior_4          =result
  - resultright         =result
==>
  =goal>
    state               simulate-submodel
  =imaginal>
!eval! ("state-submodel-not-correct" "start")
  )


(spp match-left :reward 20)
(spp match-right :reward 20)

(spp not-match-left :reward 0)
(spp not-match-right :reward 0)




;;; ----------------------------------------------------------------------------------------------
;;; ------------------------------ SIMULATE SUBMODELS ACTION -------------------------------------
;;; ----------------------------------------------------------------------------------------------

; simulate this submodel further how the pilot is responding in the future.
; save that in imaginal and return to monitoring.
; if next alarm, check how the pilot is responding.

(p simulate-left-submodel-action
  =goal>
    state               sim-sub-action-left
  =imaginal>
==>
  =imaginal>
  =goal>
    state               actiontimecalc
!eval! ("simulate-action-left" "start")
  )



(p simulate-right-submodel-action
  =goal>
    state               sim-sub-action-right
  =imaginal>
==>
  =imaginal>
  =goal>
    state               actiontimecalc
!eval! ("simulate-action-right" "start")
  )




;;; -----------------------------------------------------------------------------------------------
;;; ------------------------------ CALCULATE SUBMODELS ACTION -------------------------------------
;;; -----------------------------------------------------------------------------------------------


(P anticipate-action
  =goal>
    state               actiontimecalc
  =imaginal>
    isa                 mentalmodel
    resultactionmodel   =actionresult
    behavior_4          =result
    actiontime_4        =actiontime_4
  =temporal>
==>
  -temporal>
  =imaginal>
     behavior_4         =result
  =goal>
    state               set-new-imaginal
    next                Action
    anticipate          =actionresult
    previousreaction    =result
    actiontime_4        =actiontime_4
 !eval! ("state-anticipation" =actionresult)
  )

; now go back to monitoring
; set event in goal to 10
; set result in goal to actionresult

 


;;; ------------------------------------------------------------------------------------------------
;;; ---------------------------------- ACTION TIME MONITORING LOOP ---------------------------------
;;; ------------------------------------------------------------------------------------------------


(p compare-anticipation
  =goal>
    state               compare-anticipation
    anticipate          =anticipate
    previousreaction    =behavior_4
    actiontime_4        =actiontime_4
  =imaginal>
    behavior_10         =behavior_10
    actiontime_10       =actiontime_10
==>
  +imaginal>
    behavior_4          =behavior_4
    anticipation        =anticipate
    behavior_10         =behavior_10
    actiontime_4        =actiontime_4
    actiontime_10       =actiontime_10
  =goal>
    state               match-anticipation
  )

(p anticipation-match
  =goal>
    state               match-anticipation
  =imaginal>
    anticipation        =anticipation
    behavior_10         =anticipation
  =temporal>
==>
  -temporal>
  =imaginal>
  =goal>
      state             successful
  )

(p anticipation-not-match
  =goal>
    state               match-anticipation
  =imaginal>
    anticipation        =anticipation
  - behavior_10         =anticipation
  =temporal>
==>
  -temporal>
  =imaginal>
  =goal>
      state             failed
  )


;;; ------------------------------------------------------------------------------------------------
;;; -------------------------------- STATE IF ANTICIPATION CORRECT ---------------------------------
;;; ------------------------------------------------------------------------------------------------


(p anticipation-correct
  =goal>
    state               successful
  =imaginal>
    behavior_4          =behavior_4
    behavior_10         =behavior_10
    actiontime_4        =actiontime_4
    actiontime_10       =actiontime_10
==>
  =imaginal>
    behavior_4          =behavior_4
    behavior_10         =behavior_10
    actiontime_4        =actiontime_4
    actiontime_10       =actiontime_10
  =goal>
    state               set-new-imaginal
   !output! (action was CORRECT)
!eval! ("state-anticipation-correct" "successful" =behavior_4 =behavior_10 =actiontime_4 =actiontime_10)
  )


(P anticipation-failed
  =goal>
    state               failed
  =imaginal>
    behavior_4          =behavior_4
    behavior_10         =behavior_10
    actiontime_4        =actiontime_4
    actiontime_10       =actiontime_10
==>
  =imaginal>
    behavior_4          =behavior_4
    behavior_10         =behavior_10
    actiontime_4        =actiontime_4
    actiontime_10       =actiontime_10
  =goal>
    state               set-new-imaginal
  !output! (action was INCORRECT)
!eval! ("state-anticipation-not-correct" "failed" =behavior_4 =behavior_10 =actiontime_4 =actiontime_10)
  )


(spp anticipation-correct :reward 100)

(spp anticipation-failed :reward 0)




;;; ------------------------------------------------------------------------------------------
;;; ---------------------------------- BACK TO MONITORING ------------------------------------
;;; ------------------------------------------------------------------------------------------


(p set-new-imaginal
  =goal>
    state                 set-new-imaginal
  =imaginal>
==>
  +imaginal>
    isa                   flight-info
    altitude              0 
    speed                 0
    altitude-trend        "default" 
    speed-trend           "default"
  =goal>
    state                 scan-primary-flight-display
    next                  ALTITUDE
  )




(goal-focus goal)


)

