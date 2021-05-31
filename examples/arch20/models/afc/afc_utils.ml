(* The Zélus compiler, version 2.0
  (jeudi 4 juin 2020, 17:57:12 (UTC+0200)) *)
open Ztypes
open MyOp
let pi = 3.1416

let rad2rpm = (/.) 30.  pi

let rpm2rad = (/.) pi  30.

let spec_num = 1

let simTime = 50.

let fuel_inj_tol = 1.

let fault_time = 60.

let en_speed = 1000.

let af_sensor_tol = 1.

let maf_sensor_tol = 1.

let measureTime = 1.

let line_kappa = Array.map MyOp.make 
                           (Array.of_list ((::) (1000. ,
                                                 ((::) (1500. ,
                                                        ((::) (2000. ,
                                                               ((::) 
                                                                  (2500. ,
                                                                   ((::) 
                                                                    (
                                                                    3000. ,
                                                                    ([]))))))))))))

let col_kappa = Array.map MyOp.make 
                          (Array.of_list ((::) (0.1 ,
                                                ((::) (0.2 ,
                                                       ((::) (0.3 ,
                                                              ((::) (
                                                                    0.4 ,
                                                                    ([]))))))))))

let vals_kappa = Array.of_list ((::) ((Array.map MyOp.make 
                                                 (Array.of_list ((::) 
                                                                   (0.8 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.7 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.66 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.6 ,
                                                                    ([])))))))))))
                                      ,
                                      ((::) ((Array.map MyOp.make 
                                                        (Array.of_list 
                                                           ((::) (0.7 ,
                                                                  ((::) 
                                                                    (
                                                                    0.66 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.66 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.6 ,
                                                                    ([])))))))))))
                                             ,
                                             ((::) ((Array.map MyOp.make 
                                                               (Array.of_list 
                                                                  ((::) 
                                                                    (
                                                                    0.7 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.65 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.63 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.6 ,
                                                                    ([])))))))))))
                                                    ,
                                                    ((::) ((Array.map 
                                                              MyOp.make 
                                                              (Array.of_list 
                                                                 ((::) 
                                                                    (
                                                                    0.8 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.73 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.66 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.6 ,
                                                                    ([])))))))))))
                                                           ,
                                                           ((::) ((Array.map 
                                                                    MyOp.make
                                                                    
                                                                    (
                                                                    Array.of_list 
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.9 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.85 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.8 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.7 ,
                                                                    ([])))))))))))
                                                                  , ([])))))))))))

let lookup_kappa ((omega_36:MyOp.t) , (cyl_air_charge_35:MyOp.t)) =
  Afc_interp.interp2 (line_kappa , col_kappa , vals_kappa) 
                     (omega_36 , cyl_air_charge_35)

let line_tau_ww = Array.map MyOp.make 
                            (Array.of_list ((::) (1000. ,
                                                  ((::) (1500. ,
                                                         ((::) (2000. ,
                                                                ((::) 
                                                                   (2500. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    3000. ,
                                                                    ([]))))))))))))

let col_tau_ww = Array.map MyOp.make 
                           (Array.of_list ((::) (0.1 ,
                                                 ((::) (0.2 ,
                                                        ((::) (0.3 ,
                                                               ((::) 
                                                                  (0.4 , ([]))))))))))

let vals_tau_ww = Array.of_list ((::) ((Array.map MyOp.make 
                                                  (Array.of_list ((::) 
                                                                    (
                                                                    0.4 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.22 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.35 ,
                                                                    ([])))))))))))
                                       ,
                                       ((::) ((Array.map MyOp.make 
                                                         (Array.of_list 
                                                            ((::) (0.3 ,
                                                                   ((::) 
                                                                    (
                                                                    0.22 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.22 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.3 ,
                                                                    ([])))))))))))
                                              ,
                                              ((::) ((Array.map MyOp.make 
                                                                (Array.of_list 
                                                                   ((::) 
                                                                    (
                                                                    0.35 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.4 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.5 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.45 ,
                                                                    ([])))))))))))
                                                     ,
                                                     ((::) ((Array.map 
                                                               MyOp.make 
                                                               (Array.of_list 
                                                                  ((::) 
                                                                    (
                                                                    0.3 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.35 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.4 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.5 ,
                                                                    ([])))))))))))
                                                            ,
                                                            ((::) ((Array.map 
                                                                    MyOp.make
                                                                    
                                                                    (
                                                                    Array.of_list 
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.5 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.35 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.4 ,
                                                                    ([])))))))))))
                                                                   , 
                                                                   ([])))))))))))

let lookup_tau_ww ((omega_38:MyOp.t) , (cyl_air_charge_37:MyOp.t)) =
  Afc_interp.interp2 (line_tau_ww , col_tau_ww , vals_tau_ww) 
                     (omega_38 , cyl_air_charge_37)

let line_delay = Array.map MyOp.make 
                           (Array.of_list ((::) (800. ,
                                                 ((::) (1000. ,
                                                        ((::) (1500. ,
                                                               ((::) 
                                                                  (2000. ,
                                                                   ((::) 
                                                                    (
                                                                    3000. ,
                                                                    ([]))))))))))))

let col_delay = Array.map MyOp.make 
                          (Array.of_list ((::) (0.05 ,
                                                ((::) (0.15 ,
                                                       ((::) (0.2 ,
                                                              ((::) (
                                                                    0.25 ,
                                                                    ([]))))))))))

let vals_delay = Array.of_list ((::) ((Array.map MyOp.make 
                                                 (Array.of_list ((::) 
                                                                   (0.8 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.4 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.3 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.25 ,
                                                                    ([])))))))))))
                                      ,
                                      ((::) ((Array.map MyOp.make 
                                                        (Array.of_list 
                                                           ((::) (0.6 ,
                                                                  ((::) 
                                                                    (
                                                                    0.3 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.25 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2 ,
                                                                    ([])))))))))))
                                             ,
                                             ((::) ((Array.map MyOp.make 
                                                               (Array.of_list 
                                                                  ((::) 
                                                                    (
                                                                    0.4 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2 ,
                                                                    ([])))))))))))
                                                    ,
                                                    ((::) ((Array.map 
                                                              MyOp.make 
                                                              (Array.of_list 
                                                                 ((::) 
                                                                    (
                                                                    0.3 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2 ,
                                                                    ([])))))))))))
                                                           ,
                                                           ((::) ((Array.map 
                                                                    MyOp.make
                                                                    
                                                                    (
                                                                    Array.of_list 
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2 ,
                                                                    ([])))))))))))
                                                                  , ([])))))))))))

let lookup_delay ((omega_40:MyOp.t) , (cyl_air_charge_39:MyOp.t)) =
  Afc_interp.interp2 (line_delay , col_delay , vals_delay) 
                     (omega_40 , cyl_air_charge_39)

type ('b , 'a) _transport_delay =
  { mutable i_48 : 'b ; mutable delay_47 : 'a }

let transport_delay  = 
  
  let transport_delay_alloc _ =
    ();
    { i_48 = (false:bool) ; delay_47 = (Obj.magic ():'a Afc_delay.delay_t) } in
  let transport_delay_reset self  =
    (self.i_48 <- true:unit) in 
  let transport_delay_step self ((buffer_size_41:int) ,
                                 (max_delay_43:MyOp.t) ,
                                 (def_42:'a5259) ,
                                 (t_44:MyOp.t) ,
                                 (x_46:'a5259) , (td_45:MyOp.t)) =
    (((if self.i_48 then
       self.delay_47 <- Afc_delay.make_delay buffer_size_41 
                                             max_delay_43  def_42) ;
      self.i_48 <- false ;
      (let () = Afc_delay.record_delay self.delay_47  (t_44 , x_46) in
       Afc_delay.get_delay self.delay_47  (t_44 , x_46 , td_45))):'a) in
  Node { alloc = transport_delay_alloc; reset = transport_delay_reset ;
                                        step = transport_delay_step }
type ('a) _fuel_transport_delay =
  { mutable i_52 : 'a }

let fuel_transport_delay  = 
  let Node { alloc = i_52_alloc; step = i_52_step ; reset = i_52_reset } = transport_delay 
   in
  let fuel_transport_delay_alloc _ =
    ();{ i_52 = i_52_alloc () (* discrete *)  } in
  let fuel_transport_delay_reset self  =
    (i_52_reset self.i_52 :unit) in 
  let fuel_transport_delay_step self ((t_50:MyOp.t) ,
                                      (x_51:MyOp.t) , (delay_49:MyOp.t)) =
    (i_52_step self.i_52
       (20480 , (MyOp.make 10.) , (MyOp.make 14.7) , t_50 , x_51 , delay_49):
    MyOp.t) in
  Node { alloc = fuel_transport_delay_alloc; reset = fuel_transport_delay_reset
                                             ;
                                             step = fuel_transport_delay_step }
