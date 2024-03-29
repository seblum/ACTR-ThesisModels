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
  (chunk-type goal state action)

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
    (simulate-middle isa chunk)
    (set-focus isa chunk)
    (simulate-action isa chunk)
    (goal isa chunk state nil)
    (idle isa chunk)
    (action-1 isa chunk)
    (action-2 isa chunk)
    (simulate-focus isa chunk)    )
       

  (P simulate-action-1
    =goal>
        state            simulate
        action      1
    ?imaginal>
        state             free
  ==>
    +imaginal>
        response        "n"
    =goal>
     state              action-1
    )


  (P action-retour-1
    =goal>
     state              action-1
     action       1
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
      state       idle
      action      idle
    !eval! ("return-action-one-normative" =duration)
    )


  (P simulate-action-2
    =goal>
        state            simulate
        action       2
    ?imaginal>
        state             free
  ==>
    +imaginal>
        response        "n"
    =goal>
     state              action-2
    )


  (P action-retour-2
    =goal>
     state              action-2
     action       2
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
      state       idle
      action      idle
    !eval! ("return-action-two-normative" =duration)
    )



(goal-focus goal)

)

