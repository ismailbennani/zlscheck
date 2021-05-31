(* The Zélus compiler, version 2.0
  (jeudi 4 juin 2020, 17:57:12 (UTC+0200)) *)
open Ztypes
open Constants
open MyOp
type ctrlLimits =
{ throttleMax : MyOp.t ;
  throttleMin : MyOp.t ;
  elevatorMaxDeg : MyOp.t ;
  elevatorMinDeg : MyOp.t ;
  aileronMaxDeg : MyOp.t ;
  aileronMinDeg : MyOp.t ;
  rudderMaxDeg : MyOp.t ;
  rudderMinDeg : MyOp.t ;
  maxBankDeg : MyOp.t ; nzMax : MyOp.t ; nzMin : MyOp.t }
let defaultCtrlLimits = { throttleMax = (MyOp.make 1.) ;
                          throttleMin = (MyOp.make 0.) ;
                          elevatorMaxDeg = (MyOp.make 25.) ;
                          elevatorMinDeg = (MyOp.make (-25.)) ;
                          aileronMaxDeg = (MyOp.make 21.5) ;
                          aileronMinDeg = (MyOp.make (-21.5)) ;
                          rudderMaxDeg = (MyOp.make 30.) ;
                          rudderMinDeg = (MyOp.make (-30.)) ;
                          maxBankDeg = (MyOp.make 60.) ;
                          nzMax = (MyOp.make 6.) ; nzMin = (MyOp.make (-1.)) }

let string_of_ctrl_limits (ctrl_limits_16:ctrlLimits) =
  (^) "{ " 
      ((^) "throttleMax = " 
           ((^) (string_of_float (MyOp.get ctrl_limits_16.throttleMax)) 
                ((^) "; " 
                     ((^) "throttleMin = " 
                          ((^) (string_of_float (MyOp.get ctrl_limits_16.throttleMin))
                               
                               ((^) "; " 
                                    ((^) "elevatorMaxDeg = " 
                                         ((^) (string_of_float (MyOp.get 
                                                                  ctrl_limits_16.elevatorMaxDeg))
                                              
                                              ((^) "; " 
                                                   ((^) "elevatorMinDeg = " 
                                                        ((^) (string_of_float 
                                                                (MyOp.get 
                                                                   ctrl_limits_16.elevatorMinDeg))
                                                             
                                                             ((^) "; " 
                                                                  ((^) 
                                                                    "aileronMaxDeg = "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    ctrl_limits_16.aileronMaxDeg))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "; " 
                                                                    (
                                                                    (^) 
                                                                    "aileronMinDeg = "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    ctrl_limits_16.aileronMinDeg))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "; " 
                                                                    (
                                                                    (^) 
                                                                    "rudderMaxDeg = "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    ctrl_limits_16.rudderMaxDeg))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "; " 
                                                                    (
                                                                    (^) 
                                                                    "rudderMinDeg = "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    ctrl_limits_16.rudderMinDeg))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "; " 
                                                                    (
                                                                    (^) 
                                                                    "maxBankDeg = "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    ctrl_limits_16.maxBankDeg))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "; " 
                                                                    (
                                                                    (^) 
                                                                    "nzMax = "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    ctrl_limits_16.nzMax))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "; " 
                                                                    (
                                                                    (^) 
                                                                    "nzMin = "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    ctrl_limits_16.nzMin))
                                                                     
                                                                    " }"))))))))))))))))))))))))))))))))

type f16_state =
{ vt : MyOp.t ;
  alpha : MyOp.t ;
  beta : MyOp.t ;
  phi : MyOp.t ;
  theta : MyOp.t ;
  psi : MyOp.t ;
  p : MyOp.t ;
  q : MyOp.t ;
  r : MyOp.t ; x9 : MyOp.t ; x10 : MyOp.t ; alt : MyOp.t ; power : MyOp.t }
let string_of_f16_state (state_17:f16_state) =
  (^) "{ " 
      ((^) "vt = " 
           ((^) (string_of_float (MyOp.get state_17.vt)) 
                ((^) "; " 
                     ((^) "alpha = " 
                          ((^) (string_of_float (MyOp.get (MyOp.(/) state_17.alpha
                                                                    
                                                                    Constants.pi)))
                               
                               ((^) "\207\128; " 
                                    ((^) "beta = " 
                                         ((^) (string_of_float (MyOp.get 
                                                                  (MyOp.(/) 
                                                                    state_17.beta
                                                                    
                                                                    Constants.pi)))
                                              
                                              ((^) "\207\128; " 
                                                   ((^) "phi = " 
                                                        ((^) (string_of_float 
                                                                (MyOp.get 
                                                                   (MyOp.(/) 
                                                                    state_17.phi
                                                                    
                                                                    Constants.pi)))
                                                             
                                                             ((^) "\207\128; "
                                                                  
                                                                  ((^) 
                                                                    "theta = "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    (
                                                                    MyOp.(/) 
                                                                    state_17.theta
                                                                    
                                                                    Constants.pi)))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "\207\128; "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "psi = " 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    (
                                                                    MyOp.(/) 
                                                                    state_17.psi
                                                                    
                                                                    Constants.pi)))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "\207\128; "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "P = " 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_17.p))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "; " 
                                                                    (
                                                                    (^) 
                                                                    "Q = " 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_17.q))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "; " 
                                                                    (
                                                                    (^) 
                                                                    "R = " 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_17.r))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "; " 
                                                                    (
                                                                    (^) 
                                                                    "x9 = " 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_17.x9))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "; " 
                                                                    (
                                                                    (^) 
                                                                    "x10 = " 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_17.x10))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "; " 
                                                                    (
                                                                    (^) 
                                                                    "altitude = "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_17.alt))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "; " 
                                                                    (
                                                                    (^) 
                                                                    "power = "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_17.power))
                                                                     
                                                                    " }"))))))))))))))))))))))))))))))))))))))

let json_of_f16_state (state_18:f16_state) =
  (^) "{" 
      ((^) "\"vt\":" 
           ((^) (string_of_float (MyOp.get state_18.vt)) 
                ((^) "," 
                     ((^) "\"alpha\":" 
                          ((^) (string_of_float (MyOp.get state_18.alpha)) 
                               ((^) "," 
                                    ((^) "\"beta\":" 
                                         ((^) (string_of_float (MyOp.get 
                                                                  state_18.beta))
                                              
                                              ((^) "," 
                                                   ((^) "\"phi\":" 
                                                        ((^) (string_of_float 
                                                                (MyOp.get 
                                                                   state_18.phi))
                                                             
                                                             ((^) "," 
                                                                  ((^) 
                                                                    "\"theta\":"
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_18.theta))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "," 
                                                                    (
                                                                    (^) 
                                                                    "\"psi\":"
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_18.psi))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "," 
                                                                    (
                                                                    (^) 
                                                                    "\"P\":" 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_18.p))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "," 
                                                                    (
                                                                    (^) 
                                                                    "\"Q\":" 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_18.q))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "," 
                                                                    (
                                                                    (^) 
                                                                    "\"R\":" 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_18.r))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "," 
                                                                    (
                                                                    (^) 
                                                                    "\"x9\":"
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_18.x9))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "," 
                                                                    (
                                                                    (^) 
                                                                    "\"x10\":"
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_18.x10))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "," 
                                                                    (
                                                                    (^) 
                                                                    "\"altitude\":"
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_18.alt))
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "," 
                                                                    (
                                                                    (^) 
                                                                    "\"power\":"
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    MyOp.get 
                                                                    state_18.power))
                                                                     
                                                                    "}"))))))))))))))))))))))))))))))))))))))

type solver_state =
{ f16 : f16_state ; nz : MyOp.t ; ps : MyOp.t ; ny_r : MyOp.t }
let string_of_state (state_19:solver_state) =
  (^) "{ " 
      ((^) "f16_state = " 
           ((^) (string_of_f16_state state_19.f16) 
                ((^) "; " 
                     ((^) "nz = " 
                          ((^) (string_of_float (MyOp.get state_19.nz)) 
                               ((^) "; " 
                                    ((^) "ps = " 
                                         ((^) (string_of_float (MyOp.get 
                                                                  state_19.ps))
                                              
                                              ((^) "; " 
                                                   ((^) "ny_r = " 
                                                        ((^) (string_of_float 
                                                                (MyOp.get 
                                                                   state_19.ny_r))
                                                              " }")))))))))))

let json_of_state (state_20:solver_state) =
  (^) "{" 
      ((^) "\"f16_state\":" 
           ((^) (json_of_f16_state state_20.f16) 
                ((^) "," 
                     ((^) "\"nz\":" 
                          ((^) (string_of_float (MyOp.get state_20.nz)) 
                               ((^) "," 
                                    ((^) "\"ps\":" 
                                         ((^) (string_of_float (MyOp.get 
                                                                  state_20.ps))
                                              
                                              ((^) "," 
                                                   ((^) "\"ny_r\":" 
                                                        ((^) (string_of_float 
                                                                (MyOp.get 
                                                                   state_20.ny_r))
                                                              "}")))))))))))

type input = { thtlc : MyOp.t ; el : MyOp.t ; ail : MyOp.t ; rdr : MyOp.t }
let string_of_input (input_21:input) =
  (^) "{ " 
      ((^) "thtlc = " 
           ((^) (string_of_float (MyOp.get input_21.thtlc)) 
                ((^) "; " 
                     ((^) "el = " 
                          ((^) (string_of_float (MyOp.get input_21.el)) 
                               ((^) "; " 
                                    ((^) "ail = " 
                                         ((^) (string_of_float (MyOp.get 
                                                                  input_21.ail))
                                              
                                              ((^) "; " 
                                                   ((^) "rdr = " 
                                                        ((^) (string_of_float 
                                                                (MyOp.get 
                                                                   input_21.rdr))
                                                              " }")))))))))))

type ref_ctrl =
{ thtlc_ref : MyOp.t ; nz_ref : MyOp.t ; ps_ref : MyOp.t ; ny_r_ref : MyOp.t }
let string_of_ref_ctrl (ref_ctrl_22:ref_ctrl) =
  (^) "{ " 
      ((^) "thtlc_ref = " 
           ((^) (string_of_float (MyOp.get ref_ctrl_22.thtlc_ref)) 
                ((^) "; " 
                     ((^) "nz_ref = " 
                          ((^) (string_of_float (MyOp.get ref_ctrl_22.nz_ref))
                               
                               ((^) "; " 
                                    ((^) "ps_ref = " 
                                         ((^) (string_of_float (MyOp.get 
                                                                  ref_ctrl_22.ps_ref))
                                              
                                              ((^) "; " 
                                                   ((^) "ny_r_ref = " 
                                                        ((^) (string_of_float 
                                                                (MyOp.get 
                                                                   ref_ctrl_22.ny_r_ref))
                                                              " }")))))))))))

