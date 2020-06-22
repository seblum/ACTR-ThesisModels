;;; ----- ----- ----- ----- ----- ;;;
;;; -----    
;;; -----    WIND SHEAR   NM Submodel  
;;; -----    author:      s.blum@campus.tu-berlin.de
;;; -----    date:        18/12/2019
;;; -----    
;;; ----- ----- ----- ----- ----- ;;;

(delete-model submodel-normative)

(define-model submodel-normative

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
; ND
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
    (simulate-left isa chunk)
    (set-focus isa chunk)
    (simulate-action isa chunk)
    (goal isa chunk state nil)
  	(idle isa chunk)
  	)
     
  ; Model for fast pilots
  ; check for FCU or MCMW
  ; then say it is fast
   

  (P simulate-action-10
    =goal>
        state            simulate-normative
    ?imaginal>
        state         		free
  ==>
    +imaginal>
        response          "s"
    =goal>
     state                action-10
    )


  (P action-retour-10
    =goal>
     state                action-10
    ?manual>   
      state               free
    =imaginal>
        response          =duration
   ==>
    +manual>              
      cmd      press-key     
      key      =duration
    -imaginal>
    =goal>
      state 		idle
    !eval! ("return-duration-normative" =duration)
;   !output! (=duration)
   ;!output! (=duration)
    )


(goal-focus goal)

)

