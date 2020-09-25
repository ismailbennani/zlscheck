(* The Zélus compiler, version 2.1
  (vendredi 25 septembre 2020, 16:45:09 (UTC+0200)) *)
open Ztypes
open Constants
open FadFloat
type ctrlLimits =
{ throttleMax : FadFloat.t ;
  throttleMin : FadFloat.t ;
  elevatorMaxDeg : FadFloat.t ;
  elevatorMinDeg : FadFloat.t ;
  aileronMaxDeg : FadFloat.t ;
  aileronMinDeg : FadFloat.t ;
  rudderMaxDeg : FadFloat.t ;
  rudderMinDeg : FadFloat.t ;
  maxBankDeg : FadFloat.t ; nzMax : FadFloat.t ; nzMin : FadFloat.t }
let defaultCtrlLimits = { throttleMax = (FadFloat.make 1.) ;
                          throttleMin = (FadFloat.make 0.) ;
                          elevatorMaxDeg = (FadFloat.make 25.) ;
                          elevatorMinDeg = (FadFloat.make (-25.)) ;
                          aileronMaxDeg = (FadFloat.make 21.5) ;
                          aileronMinDeg = (FadFloat.make (-21.5)) ;
                          rudderMaxDeg = (FadFloat.make 30.) ;
                          rudderMinDeg = (FadFloat.make (-30.)) ;
                          maxBankDeg = (FadFloat.make 60.) ;
                          nzMax = (FadFloat.make 6.) ;
                          nzMin = (FadFloat.make (-1.)) }

let string_of_ctrl_limits (ctrl_limits_16:ctrlLimits) =
  (^) "{ " 
      ((^) "throttleMax = " 
           ((^) (string_of_float (FadFloat.get ctrl_limits_16.throttleMax)) 
                ((^) "; " 
                     ((^) "throttleMin = " 
                          ((^) (string_of_float (FadFloat.get ctrl_limits_16.throttleMin))
                               
                               ((^) "; " 
                                    ((^) "elevatorMaxDeg = " 
                                         ((^) (string_of_float (FadFloat.get 
                                                                  ctrl_limits_16.elevatorMaxDeg))
                                              
                                              ((^) "; " 
                                                   ((^) "elevatorMinDeg = " 
                                                        ((^) (string_of_float 
                                                                (FadFloat.get 
                                                                   ctrl_limits_16.elevatorMinDeg))
                                                             
                                                             ((^) "; " 
                                                                  ((^) 
                                                                    "aileronMaxDeg = "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
                                                                    ctrl_limits_16.nzMin))
                                                                     
                                                                    " }"))))))))))))))))))))))))))))))))

type f16_state =
{ vt : FadFloat.t ;
  alpha : FadFloat.t ;
  beta : FadFloat.t ;
  phi : FadFloat.t ;
  theta : FadFloat.t ;
  psi : FadFloat.t ;
  p : FadFloat.t ;
  q : FadFloat.t ;
  r : FadFloat.t ;
  x9 : FadFloat.t ; x10 : FadFloat.t ; alt : FadFloat.t ; power : FadFloat.t }
let string_of_f16_state (state_17:f16_state) =
  (^) "{ " 
      ((^) "vt = " 
           ((^) (string_of_float (FadFloat.get state_17.vt)) 
                ((^) "; " 
                     ((^) "alpha = " 
                          ((^) (string_of_float (FadFloat.get (FadFloat.(/) 
                                                                 state_17.alpha
                                                                 
                                                                 Constants.pi)))
                               
                               ((^) "\207\128; " 
                                    ((^) "beta = " 
                                         ((^) (string_of_float (FadFloat.get 
                                                                  (FadFloat.(/) 
                                                                    state_17.beta
                                                                    
                                                                    Constants.pi)))
                                              
                                              ((^) "\207\128; " 
                                                   ((^) "phi = " 
                                                        ((^) (string_of_float 
                                                                (FadFloat.get 
                                                                   (FadFloat.(/) 
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
                                                                    FadFloat.get 
                                                                    (
                                                                    FadFloat.(/) 
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
                                                                    FadFloat.get 
                                                                    (
                                                                    FadFloat.(/) 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
                                                                    state_17.power))
                                                                     
                                                                    " }"))))))))))))))))))))))))))))))))))))))

let json_of_f16_state (state_18:f16_state) =
  (^) "{" 
      ((^) "\"vt\":" 
           ((^) (string_of_float (FadFloat.get state_18.vt)) 
                ((^) "," 
                     ((^) "\"alpha\":" 
                          ((^) (string_of_float (FadFloat.get state_18.alpha))
                               
                               ((^) "," 
                                    ((^) "\"beta\":" 
                                         ((^) (string_of_float (FadFloat.get 
                                                                  state_18.beta))
                                              
                                              ((^) "," 
                                                   ((^) "\"phi\":" 
                                                        ((^) (string_of_float 
                                                                (FadFloat.get 
                                                                   state_18.phi))
                                                             
                                                             ((^) "," 
                                                                  ((^) 
                                                                    "\"theta\":"
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_float 
                                                                    (
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
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
                                                                    FadFloat.get 
                                                                    state_18.power))
                                                                     
                                                                    "}"))))))))))))))))))))))))))))))))))))))

type solver_state =
{ f16 : f16_state ; nz : FadFloat.t ; ps : FadFloat.t ; ny_r : FadFloat.t }
let string_of_state (state_19:solver_state) =
  (^) "{ " 
      ((^) "f16_state = " 
           ((^) (string_of_f16_state state_19.f16) 
                ((^) "; " 
                     ((^) "nz = " 
                          ((^) (string_of_float (FadFloat.get state_19.nz)) 
                               ((^) "; " 
                                    ((^) "ps = " 
                                         ((^) (string_of_float (FadFloat.get 
                                                                  state_19.ps))
                                              
                                              ((^) "; " 
                                                   ((^) "ny_r = " 
                                                        ((^) (string_of_float 
                                                                (FadFloat.get 
                                                                   state_19.ny_r))
                                                              " }")))))))))))

let json_of_state (state_20:solver_state) =
  (^) "{" 
      ((^) "\"f16_state\":" 
           ((^) (json_of_f16_state state_20.f16) 
                ((^) "," 
                     ((^) "\"nz\":" 
                          ((^) (string_of_float (FadFloat.get state_20.nz)) 
                               ((^) "," 
                                    ((^) "\"ps\":" 
                                         ((^) (string_of_float (FadFloat.get 
                                                                  state_20.ps))
                                              
                                              ((^) "," 
                                                   ((^) "\"ny_r\":" 
                                                        ((^) (string_of_float 
                                                                (FadFloat.get 
                                                                   state_20.ny_r))
                                                              "}")))))))))))

type input =
{ thtlc : FadFloat.t ; el : FadFloat.t ; ail : FadFloat.t ; rdr : FadFloat.t }
let string_of_input (input_21:input) =
  (^) "{ " 
      ((^) "thtlc = " 
           ((^) (string_of_float (FadFloat.get input_21.thtlc)) 
                ((^) "; " 
                     ((^) "el = " 
                          ((^) (string_of_float (FadFloat.get input_21.el)) 
                               ((^) "; " 
                                    ((^) "ail = " 
                                         ((^) (string_of_float (FadFloat.get 
                                                                  input_21.ail))
                                              
                                              ((^) "; " 
                                                   ((^) "rdr = " 
                                                        ((^) (string_of_float 
                                                                (FadFloat.get 
                                                                   input_21.rdr))
                                                              " }")))))))))))

type ref_ctrl =
{ thtlc_ref : FadFloat.t ;
  nz_ref : FadFloat.t ; ps_ref : FadFloat.t ; ny_r_ref : FadFloat.t }
let string_of_ref_ctrl (ref_ctrl_22:ref_ctrl) =
  (^) "{ " 
      ((^) "thtlc_ref = " 
           ((^) (string_of_float (FadFloat.get ref_ctrl_22.thtlc_ref)) 
                ((^) "; " 
                     ((^) "nz_ref = " 
                          ((^) (string_of_float (FadFloat.get ref_ctrl_22.nz_ref))
                               
                               ((^) "; " 
                                    ((^) "ps_ref = " 
                                         ((^) (string_of_float (FadFloat.get 
                                                                  ref_ctrl_22.ps_ref))
                                              
                                              ((^) "; " 
                                                   ((^) "ny_r_ref = " 
                                                        ((^) (string_of_float 
                                                                (FadFloat.get 
                                                                   ref_ctrl_22.ny_r_ref))
                                                              " }")))))))))))

