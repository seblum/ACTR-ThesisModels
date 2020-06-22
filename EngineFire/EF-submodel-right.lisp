;;; ----- ----- ----- ----- ----- ;;;
;;; -----    
;;; -----    ENGINE FIRE  ISM Right Submodel  
;;; -----    author:      s.blum@campus.tu-berlin.de
;;; -----    date:        18/12/2019
;;; -----    
;;; ----- ----- ----- ----- ----- ;;;


(delete-model right-model)

(define-model right-model

  (sgp :v t :show-focus t :needs-mouse nil)

  (chunk-type response letter)

  (add-visicon-features '(isa visual-location screen-x 20 screen-y 20 
                          value 1 height 10 width 40 
                          color "PFD"))
  (add-visicon-features '(isa visual-location screen-x 40 screen-y 20 
                          value 1 height 10 width 40 
                          color "ND"))
  (add-visicon-features '(isa visual-location screen-x 100 screen-y 60 
                          value 1 height 10 width 40 
                          color "MFD"))
; FCU
  (chunk-type memory simstep
                     response
                     AOIresult)
  (chunk-type goal state)

  (define-chunks
    (start isa chunk)
    (middle-start isa chunk)
    (attend isa chunk)
    (simulate isa chunk)
    (end isa chunk)
    (focus isa chunk)
    (memory isa chunk)
    (action isa chunk)
    (simstep isa chunk)
    (simulate-right isa chunk)
    (set-focus isa chunk)
    (simulate-action isa chunk)
    (goal isa chunk state nil)
    (idle isa chunk)
  	)
     
     
  ; Model for fast pilots
  ; check for FCU or MCMW
  ; then say it is fast


  (P start-submodel
    =goal>
       state          simulate-right
  ==>
    =goal>
       state          set-focus
    )


  (P set-focus-aoi
    =goal>
       state          set-focus
    ?visual-location>
       state          free
  ==>
    +visual-location>
        screen-x      100 
        screen-y      60
    =goal>
       state          simulate
    )


  (P simulate-focus-aoi
    =goal>
       state          simulate
    ?visual>
       state          free
    =visual-location>
        screen-x      100 
        screen-y      60
  ==>
    +visual>
        cmd         move-attention
        screen-pos  =visual-location
    =visual-location>
        screen-x      100 
        screen-y      60
    =goal>
     state            focus
    )


  (P focus-aoi-retour
    =goal>
     state            focus
    =visual>
        ISA         visual-object
        color       =focus
    =visual-location>
==>
    @visual-location>
    =visual>
        color          =focus
    =goal>
        state            free
    !eval! ("return-focus-right" =focus)
 ;  !output! (=focus)
    )
   

    (P simulate-action
    =goal>
        state            simulate-action
     ?imaginal>
        state         free
  ==>
    +imaginal>
        response        "s"
    =goal>
     state            action
    )


  (P action-retour
    =goal>
     state              action
    ?manual>   
      state             free
    =imaginal>
        response        =duration
   ==>
    +manual>              
      cmd      press-key     
      key      =duration
    -imaginal>
    =goal>
      state 		idle
    !eval! ("return-duration-right" =duration)
 ;  !output! (=duration)
    )


(goal-focus goal)

)

