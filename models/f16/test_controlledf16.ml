(* The Zélus compiler, version 2.0
  (mercredi 26 juin 2019, 14:38:06 (UTC+0200)) *)
open Ztypes
open Constants
open Types
open Staliro_global
let get_initial_cond () =
  { Types.f16 =
    { Types.vt = 540. ;
      Types.alpha = (( *. ) 2.1215  Constants.dtor) ;
      Types.beta = 0. ;
      Types.p = 0. ;
      Types.q = 0. ;
      Types.r = 0. ;
      Types.x9 = 0. ;
      Types.x10 = 0. ;
      Types.alt = 4040. ;
      Types.power = 9. ;
      Types.phi = (Staliro_global.get_global "phi") ;
      Types.theta = (Staliro_global.get_global "theta") ;
      Types.psi = (Staliro_global.get_global "psi") } ;
    Types.nz = 0. ; Types.ps = 0. ; Types.ny_r = 0. }

type ('e , 'd , 'c , 'b , 'a) _model =
  { mutable i_35 : 'e ;
    mutable i_34 : 'd ;
    mutable tmp_25 : 'c ; mutable initial_cond_24 : 'b ; mutable tmp_22 : 'a }

let model (cstate_36:Ztypes.cstate) = 
  let Node { alloc = i_35_alloc; step = i_35_step ; reset = i_35_reset } = Controlledf16.model 
  cstate_36 in
  let model_alloc _ =
    ();
    { i_34 = (false:bool) ;
      tmp_25 = (():unit) ;
      initial_cond_24 = ({ Types.ny_r = 42. ;
                           Types.ps = 42. ;
                           Types.nz = 42. ;
                           Types.f16 =
                           { Types.power = 42. ;
                             Types.alt = 42. ;
                             Types.x10 = 42. ;
                             Types.x9 = 42. ;
                             Types.r = 42. ;
                             Types.q = 42. ;
                             Types.p = 42. ;
                             Types.psi = 42. ;
                             Types.theta = 42. ;
                             Types.phi = 42. ;
                             Types.beta = 42. ;
                             Types.alpha = 42. ; Types.vt = 42. } }:Types.solver_state)
      ; tmp_22 = (():unit);i_35 = i_35_alloc () (* continuous *)  } in
  let model_step self ((time_32:float) , ()) =
    ((((if self.i_34 then self.tmp_22 <- Random.self_init ()) ;
       (if self.i_34 then self.initial_cond_24 <- get_initial_cond ()) ;
       (if self.i_34 then
        self.tmp_25 <- print_endline (Types.string_of_state self.initial_cond_24))
       ;
       self.i_34 <- false ;
       (let ((u_29:Types.input) ,
             (u_ref_30:Types.ref_ctrl) ,
             (state_27:Types.solver_state) ,
             (state_der_28:Types.solver_state)) =
            i_35_step self.i_35
              (time_32 , (self.initial_cond_24 , Types.defaultCtrlLimits)) in
        let (res_31:float) = state_27.Types.f16.Types.alt in
        res_31))):float) in 
  let model_reset self  =
    ((self.i_34 <- true ; i_35_reset self.i_35 ):unit) in
  Node { alloc = model_alloc; step = model_step ; reset = model_reset }
