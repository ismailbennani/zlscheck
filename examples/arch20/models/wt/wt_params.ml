(* The Zélus compiler, version 2.0
  (jeudi 4 juin 2020, 17:57:12 (UTC+0200)) *)
open Ztypes
open MyOp
open Wt_common
type vscontrol =
{ rgn3MP : MyOp.t ;
  ctInSp : MyOp.t ;
  maxRat : MyOp.t ;
  maxTq : MyOp.t ;
  rgn2K : MyOp.t ;
  rgn2Sp : MyOp.t ;
  rtGnSp : MyOp.t ;
  rtPwr : MyOp.t ;
  slPc : MyOp.t ;
  sySp : MyOp.t ;
  slope15 : MyOp.t ;
  slope25 : MyOp.t ; trGnSp : MyOp.t ; vs_filterConstant : MyOp.t }
let string_of_vscontrol ((prefix_140:string) , (vsctrl_141:vscontrol)) =
  (^) "{\n" 
      ((^) ((^) prefix_140 
                ((^) "  rgn3MP: " 
                     ((^) (MyOp.to_string vsctrl_141.rgn3MP)  ";\n"))) 
           ((^) ((^) prefix_140 
                     ((^) "  ctInSp: " 
                          ((^) (MyOp.to_string vsctrl_141.ctInSp)  ";\n"))) 
                ((^) ((^) prefix_140 
                          ((^) "  maxRat: " 
                               ((^) (MyOp.to_string vsctrl_141.maxRat)  ";\n")))
                     
                     ((^) ((^) prefix_140 
                               ((^) "  maxTq: " 
                                    ((^) (MyOp.to_string vsctrl_141.maxTq) 
                                         ";\n"))) 
                          ((^) ((^) prefix_140 
                                    ((^) "  rgn2K: " 
                                         ((^) (MyOp.to_string vsctrl_141.rgn2K)
                                               ";\n"))) 
                               ((^) ((^) prefix_140 
                                         ((^) "  rgn2Sp: " 
                                              ((^) (MyOp.to_string vsctrl_141.rgn2Sp)
                                                    ";\n"))) 
                                    ((^) ((^) prefix_140 
                                              ((^) "  rtGnSp: " 
                                                   ((^) (MyOp.to_string 
                                                           vsctrl_141.rtGnSp)
                                                         ";\n"))) 
                                         ((^) ((^) prefix_140 
                                                   ((^) "  rtPwr: " 
                                                        ((^) (MyOp.to_string 
                                                                vsctrl_141.rtPwr)
                                                              ";\n"))) 
                                              ((^) ((^) prefix_140 
                                                        ((^) "  slPc: " 
                                                             ((^) (MyOp.to_string 
                                                                    vsctrl_141.slPc)
                                                                   ";\n"))) 
                                                   ((^) ((^) prefix_140 
                                                             ((^) "  sySp: " 
                                                                  ((^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    vsctrl_141.sySp)
                                                                     
                                                                    ";\n"))) 
                                                        ((^) ((^) prefix_140 
                                                                  ((^) 
                                                                    "  slope15: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    vsctrl_141.slope15)
                                                                     
                                                                    ";\n"))) 
                                                             ((^) ((^) 
                                                                    prefix_140
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "  slope25: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    vsctrl_141.slope25)
                                                                     
                                                                    ";\n"))) 
                                                                  ((^) 
                                                                    (
                                                                    (^) 
                                                                    prefix_140
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "  trGnSp: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    vsctrl_141.trGnSp)
                                                                     
                                                                    ";\n"))) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    prefix_140
                                                                    
                                                                    (
                                                                    (^) 
                                                                    "  vs_filterConstant: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    vsctrl_141.vs_filterConstant)
                                                                     
                                                                    ";\n"))) 
                                                                    (
                                                                    (^) 
                                                                    prefix_140
                                                                     
                                                                    "}")))))))))))))))

type cpc =
{ gS_factor : MyOp.t ;
  kI : MyOp.t ; kP : MyOp.t ; tI : MyOp.t ; antiWindUp : MyOp.t }
let string_of_cpc ((prefix_143:string) , (cpc_142:cpc)) =
  (^) "{\n" 
      ((^) ((^) prefix_143 
                ((^) "  gS_factor: " 
                     ((^) (MyOp.to_string cpc_142.gS_factor)  ";\n"))) 
           ((^) ((^) prefix_143 
                     ((^) "  kI: "  ((^) (MyOp.to_string cpc_142.kI)  ";\n")))
                
                ((^) ((^) prefix_143 
                          ((^) "  kP: " 
                               ((^) (MyOp.to_string cpc_142.kP)  ";\n"))) 
                     ((^) ((^) prefix_143 
                               ((^) "  tI: " 
                                    ((^) (MyOp.to_string cpc_142.tI)  ";\n")))
                          
                          ((^) ((^) prefix_143 
                                    ((^) "  antiWindUp: " 
                                         ((^) (MyOp.to_string cpc_142.antiWindUp)
                                               ";\n"))) 
                               ((^) prefix_143  "}"))))))

type pitch =
{ omega : MyOp.t ;
  xi : MyOp.t ;
  delay : MyOp.t ;
  rateLimit : MyOp.t ;
  max : MyOp.t ;
  min : MyOp.t ;
  theta0 : MyOp.t ;
  thetaDot0 : MyOp.t ;
  actuatorType : int ; pitch_filterConstant : MyOp.t ; cpc : cpc }
let string_of_pitch ((prefix_145:string) , (pitch_144:pitch)) =
  (^) "{\n" 
      ((^) ((^) prefix_145 
                ((^) "  omega: " 
                     ((^) (MyOp.to_string pitch_144.omega)  ";\n"))) 
           ((^) ((^) prefix_145 
                     ((^) "  xi: " 
                          ((^) (MyOp.to_string pitch_144.xi)  ";\n"))) 
                ((^) ((^) prefix_145 
                          ((^) "  delay: " 
                               ((^) (MyOp.to_string pitch_144.delay)  ";\n")))
                     
                     ((^) ((^) prefix_145 
                               ((^) "  rateLimit: " 
                                    ((^) (MyOp.to_string pitch_144.rateLimit)
                                          ";\n"))) 
                          ((^) ((^) prefix_145 
                                    ((^) "  max: " 
                                         ((^) (MyOp.to_string pitch_144.max) 
                                              ";\n"))) 
                               ((^) ((^) prefix_145 
                                         ((^) "  min: " 
                                              ((^) (MyOp.to_string pitch_144.min)
                                                    ";\n"))) 
                                    ((^) ((^) prefix_145 
                                              ((^) "  theta0: " 
                                                   ((^) (MyOp.to_string 
                                                           pitch_144.theta0) 
                                                        ";\n"))) 
                                         ((^) ((^) prefix_145 
                                                   ((^) "  thetaDot0: " 
                                                        ((^) (MyOp.to_string 
                                                                pitch_144.thetaDot0)
                                                              ";\n"))) 
                                              ((^) ((^) prefix_145 
                                                        ((^) "  actuatorType: "
                                                             
                                                             ((^) (string_of_int 
                                                                    pitch_144.actuatorType)
                                                                   ";\n"))) 
                                                   ((^) ((^) prefix_145 
                                                             ((^) "  pitch_filterConstant: "
                                                                  
                                                                  ((^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    pitch_144.pitch_filterConstant)
                                                                     
                                                                    ";\n"))) 
                                                        ((^) ((^) prefix_145 
                                                                  ((^) 
                                                                    "  cpc: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_cpc 
                                                                    (
                                                                    (
                                                                    (^) 
                                                                    prefix_145
                                                                     
                                                                    "  ") ,
                                                                    pitch_144.cpc))
                                                                     
                                                                    ";\n"))) 
                                                             ((^) prefix_145 
                                                                  "}"))))))))))))

type params =
{ rho : MyOp.t ;
  rotor : MyOp.t ;
  lambda_opt : MyOp.t ;
  omega_rated : MyOp.t ;
  wind_rated : MyOp.t ;
  eta : MyOp.t ;
  h_H : MyOp.t ;
  m_T : MyOp.t ;
  m_N : MyOp.t ;
  m_H : MyOp.t ;
  m_B : MyOp.t ;
  f_0 : MyOp.t ;
  d_s : MyOp.t ;
  mTe : MyOp.t ;
  cTe : MyOp.t ;
  kTe : MyOp.t ;
  j_H : MyOp.t ;
  j_B : MyOp.t ;
  j_G : MyOp.t ;
  gBRatio : MyOp.t ;
  inertia : MyOp.t ;
  omega_g_rated : MyOp.t ;
  xt_dot0 : MyOp.t ;
  xT0 : MyOp.t ;
  omega0 : MyOp.t ;
  omega_g0 : MyOp.t ; genEff : MyOp.t ; vscontrol : vscontrol ; pitch : pitch }
let string_of_params (params_146:params) =
  (^) "{\n" 
      ((^) ((^) "  rho: "  ((^) (MyOp.to_string params_146.rho)  ";\n")) 
           ((^) ((^) "  rotor: " 
                     ((^) (MyOp.to_string params_146.rotor)  ";\n")) 
                ((^) ((^) "  lambda_opt: " 
                          ((^) (MyOp.to_string params_146.lambda_opt)  ";\n"))
                     
                     ((^) ((^) "  omega_rated: " 
                               ((^) (MyOp.to_string params_146.omega_rated) 
                                    ";\n")) 
                          ((^) ((^) "  wind_rated: " 
                                    ((^) (MyOp.to_string params_146.wind_rated)
                                          ";\n")) 
                               ((^) ((^) "  eta: " 
                                         ((^) (MyOp.to_string params_146.eta)
                                               ";\n")) 
                                    ((^) ((^) "  h_H: " 
                                              ((^) (MyOp.to_string params_146.h_H)
                                                    ";\n")) 
                                         ((^) ((^) "  m_T: " 
                                                   ((^) (MyOp.to_string 
                                                           params_146.m_T) 
                                                        ";\n")) 
                                              ((^) ((^) "  m_N: " 
                                                        ((^) (MyOp.to_string 
                                                                params_146.m_N)
                                                              ";\n")) 
                                                   ((^) ((^) "  m_H: " 
                                                             ((^) (MyOp.to_string 
                                                                    params_146.m_H)
                                                                   ";\n")) 
                                                        ((^) ((^) "  m_B: " 
                                                                  ((^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.m_B)
                                                                     
                                                                    ";\n")) 
                                                             ((^) ((^) 
                                                                    "  f_0: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.f_0)
                                                                     
                                                                    ";\n")) 
                                                                  ((^) 
                                                                    (
                                                                    (^) 
                                                                    "  d_s: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.d_s)
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  mTe: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.mTe)
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  cTe: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.cTe)
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  kTe: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.kTe)
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  j_H: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.j_H)
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  j_B: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.j_B)
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  j_G: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.j_G)
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  gBRatio: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.gBRatio)
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  inertia: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.inertia)
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  omega_g_rated: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.omega_g_rated)
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  xt_dot0: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.xt_dot0)
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  xT0: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.xT0)
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  omega0: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.omega0)
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  omega_g0: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.omega_g0)
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  genEff: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    MyOp.to_string 
                                                                    params_146.genEff)
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  vscontrol: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_vscontrol 
                                                                    (
                                                                    "  " ,
                                                                    params_146.vscontrol))
                                                                     
                                                                    ";\n")) 
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    (^) 
                                                                    "  pitch: "
                                                                    
                                                                    (
                                                                    (^) 
                                                                    (
                                                                    string_of_pitch 
                                                                    (
                                                                    "  " ,
                                                                    params_146.pitch))
                                                                     
                                                                    ";\n")) 
                                                                    "}")))))))))))))))))))))))))))))

let get_default (v0_0_147:MyOp.t) =
  let (lambda_opt_154:MyOp.t) = MyOp.make 7.55 in
  let (wind_rated_156:MyOp.t) = MyOp.make 11.2 in
  let (eta_157:MyOp.t) = MyOp.make 0.944 in
  let (h_H_158:MyOp.t) = MyOp.make 90. in
  let (f_0_163:MyOp.t) = MyOp.make 0.31994 in
  let (d_s_164:MyOp.t) = MyOp.make 0.01 in
  let (m_T_159:MyOp.t) = MyOp.make 522617. in
  let (m_N_160:MyOp.t) = MyOp.make 240000. in
  let (m_H_161:MyOp.t) = MyOp.make 56780. in
  let (m_B_162:MyOp.t) = MyOp.make 17740. in
  let (mTe_165:MyOp.t) =
      MyOp.(+) (MyOp.(+) (MyOp.(+) (MyOp.scale m_T_159  0.25)  m_N_160) 
                         m_H_161)  (MyOp.scale m_B_162  3.) in
  let (cTe_166:MyOp.t) =
      MyOp.( * ) (MyOp.( * ) (MyOp.( * ) (MyOp.scale Wt_common.pi_t  4.) 
                                         mTe_165)  d_s_164)  f_0_163 in
  let (j_H_168:MyOp.t) = MyOp.make 115926. in
  let (j_B_169:MyOp.t) = MyOp.make 11776047. in
  let (j_G_170:MyOp.t) = MyOp.make 534.116 in
  let (gBRatio_171:MyOp.t) = MyOp.make ((/.) 1.  97.) in
  let (inertia_172:MyOp.t) =
      MyOp.(+) (MyOp.(+) j_H_168  (MyOp.scale j_B_169  3.)) 
               (MyOp.( * ) j_G_170  (MyOp.pow gBRatio_171  2.)) in
  let (omega_rated_155:MyOp.t) = Wt_common.rpm2radPs (MyOp.make 12.1) in
  let (omega_g_rated_173:MyOp.t) = MyOp.(/) omega_rated_155  gBRatio_171 in
  let (xt_dot0_174:MyOp.t) = MyOp.make 0. in
  let (rho_152:MyOp.t) = MyOp.make 1.225 in
  let (rotor_153:MyOp.t) = MyOp.make ((/.) 126.  2.) in
  let (kTe_167:MyOp.t) =
      MyOp.( * ) mTe_165 
                 (MyOp.pow (MyOp.( * ) Wt_common.twopi_t  f_0_163)  2.) in
  let (xT0_175:MyOp.t) =
      MyOp.(/) (MyOp.( * ) (MyOp.( * ) (MyOp.( * ) (MyOp.pow v0_0_147  2.) 
                                                   (MyOp.scale rho_152  0.5))
                                        Wt_common.pi_t) 
                           (MyOp.pow rotor_153  2.))  kTe_167 in
  let (init_omega_148:(MyOp.t)Array.t) =
      Array.map MyOp.make 
                (Array.of_list ((::) (0. ,
                                      ((::) (0.1267 ,
                                             ((::) (0.2534 ,
                                                    ((::) (0.3801 ,
                                                           ((::) (0.5068 ,
                                                                  ((::) 
                                                                    (
                                                                    0.6336 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.7603 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.887 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.0137 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.1404 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    1.2671 ,
                                                                    ([])))))))))))))))))))))))))))))))))))))))))))))))))))))) in
  let (init_v0_149:(MyOp.t)Array.t) =
      Array.map MyOp.make 
                (Array.of_list ((::) (0. ,
                                      ((::) (1. ,
                                             ((::) (2. ,
                                                    ((::) (3. ,
                                                           ((::) (4. ,
                                                                  ((::) 
                                                                    (
                                                                    5. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    6. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    7. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    8. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    9. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    10. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    11.4 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    12. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    13. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    14. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    15. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    16. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    17. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    18. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    19. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    20. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    21. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    22. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    23. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    24. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    25. ,
                                                                    ([])))))))))))))))))))))))))))))))))))))))))))))))))))))) in
  let (omega0_176:MyOp.t) =
      Wt_common.interp1 (init_v0_149 , init_omega_148 , v0_0_147) in
  let (omega_g0_177:MyOp.t) = MyOp.(/) omega0_176  gBRatio_171 in
  let (genEff_178:MyOp.t) = MyOp.make 0.944 in
  let (vs_rgn3MP_180:MyOp.t) = MyOp.make 0.01745329 in
  let (vs_maxRat_182:MyOp.t) = MyOp.make 15000. in
  let (vs_maxTq_183:MyOp.t) = MyOp.make 47402.91 in
  let (vs_ctInSp_181:MyOp.t) = MyOp.make 70.16224 in
  let (vs_rgn2K_184:MyOp.t) = MyOp.make 2.332287 in
  let (vs_rgn2Sp_185:MyOp.t) = MyOp.make 91.21091 in
  let (vs_slope15_190:MyOp.t) =
      MyOp.(/) (MyOp.( * ) (MyOp.( * ) vs_rgn2K_184  vs_rgn2Sp_185) 
                           vs_rgn2Sp_185) 
               (MyOp.(-) vs_rgn2Sp_185  vs_ctInSp_181) in
  let (vs_rtGnSp_186:MyOp.t) = MyOp.make 121.6805 in
  let (vs_slPc_188:MyOp.t) = MyOp.make 10. in
  let (vs_sySp_189:MyOp.t) =
      MyOp.(/) vs_rtGnSp_186 
               (MyOp.translate (MyOp.scale vs_slPc_188  0.01)  1.) in
  let (vs_rtPwr_187:MyOp.t) = MyOp.make 5296610. in
  let (vs_slope25_191:MyOp.t) =
      MyOp.(/) (MyOp.(/) vs_rtPwr_187  vs_rtGnSp_186) 
               (MyOp.(-) vs_rtGnSp_186  vs_sySp_189) in
  let (vs_trGnSp_192:MyOp.t) =
      if (=) vs_rgn2K_184  (MyOp.make 0.)
      then vs_sySp_189
      else
        MyOp.(/) (MyOp.(-) vs_slope25_191 
                           (MyOp.sqrt (MyOp.( * ) vs_slope25_191 
                                                  (MyOp.(-) vs_slope25_191 
                                                            (MyOp.( * ) 
                                                               (MyOp.scale 
                                                                  vs_rgn2K_184
                                                                   4.) 
                                                               vs_sySp_189)))))
                  (MyOp.scale vs_rgn2K_184  2.) in
  let (vs_filterConstant_193:MyOp.t) =
      MyOp.inv (MyOp.scale Wt_common.twopi_t  0.25) in
  let (pitch_xi_195:MyOp.t) = MyOp.make 0.7 in
  let (pitch_delay_196:MyOp.t) = MyOp.make 0.3545 in
  let (pitch_rateLimit_197:MyOp.t) = Wt_common.deg2rad (MyOp.make 8.) in
  let (pitch_max_198:MyOp.t) = Wt_common.deg2rad (MyOp.make 90.) in
  let (pitch_min_199:MyOp.t) = MyOp.make 0. in
  let (init_pitch_150:(MyOp.t)Array.t) =
      Array.map MyOp.make 
                (Array.of_list ((::) (0. ,
                                      ((::) (0. ,
                                             ((::) (0. ,
                                                    ((::) (0. ,
                                                           ((::) (0. ,
                                                                  ((::) 
                                                                    (
                                                                    0. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0. ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.0529 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.1152 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.1518 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.1824 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2105 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2363 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2604 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.2833 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.3049 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.3264 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.348 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.3697 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.3901 ,
                                                                    (
                                                                    (::) 
                                                                    (
                                                                    0.4096 ,
                                                                    ([])))))))))))))))))))))))))))))))))))))))))))))))))))))) in
  let (pitch_theta0_200:MyOp.t) =
      Wt_common.interp1 (init_v0_149 , init_pitch_150 , v0_0_147) in
  let (pitch_thetaDot0_201:MyOp.t) = MyOp.make 0. in
  let (pitch_filterConstant_203:MyOp.t) =
      MyOp.inv (MyOp.scale Wt_common.twopi_t  0.25) in
  let (cpc_gS_factor_204:MyOp.t) = MyOp.make 0.1099965 in
  let (cpc_kI_205:MyOp.t) = MyOp.make 0.008068634 in
  let (cpc_kP_206:MyOp.t) = MyOp.make 0.01882681 in
  let (cpc_tI_207:MyOp.t) = MyOp.(/) cpc_kP_206  cpc_kI_205 in
  let (cpc_antiWindUp_208:MyOp.t) = MyOp.make 1. in
  { rho = rho_152 ;
    rotor = rotor_153 ;
    lambda_opt = lambda_opt_154 ;
    omega_rated = omega_rated_155 ;
    wind_rated = wind_rated_156 ;
    eta = eta_157 ;
    h_H = h_H_158 ;
    m_T = m_T_159 ;
    m_N = m_N_160 ;
    m_H = m_H_161 ;
    m_B = m_B_162 ;
    f_0 = f_0_163 ;
    d_s = d_s_164 ;
    mTe = mTe_165 ;
    cTe = cTe_166 ;
    kTe = kTe_167 ;
    j_H = j_H_168 ;
    j_B = j_B_169 ;
    j_G = j_G_170 ;
    gBRatio = gBRatio_171 ;
    inertia = inertia_172 ;
    omega_g_rated = omega_g_rated_173 ;
    xt_dot0 = xt_dot0_174 ;
    xT0 = xT0_175 ;
    omega0 = omega0_176 ;
    omega_g0 = omega_g0_177 ;
    genEff = genEff_178 ;
    vscontrol =
    { rgn3MP = vs_rgn3MP_180 ;
      ctInSp = vs_ctInSp_181 ;
      maxRat = vs_maxRat_182 ;
      maxTq = vs_maxTq_183 ;
      rgn2K = vs_rgn2K_184 ;
      rgn2Sp = vs_rgn2Sp_185 ;
      rtGnSp = vs_rtGnSp_186 ;
      rtPwr = vs_rtPwr_187 ;
      slPc = vs_slPc_188 ;
      sySp = vs_sySp_189 ;
      slope15 = vs_slope15_190 ;
      slope25 = vs_slope25_191 ;
      trGnSp = vs_trGnSp_192 ; vs_filterConstant = vs_filterConstant_193 } ;
    pitch =
    { omega = Wt_common.twopi_t ;
      xi = pitch_xi_195 ;
      delay = pitch_delay_196 ;
      rateLimit = pitch_rateLimit_197 ;
      max = pitch_max_198 ;
      min = pitch_min_199 ;
      theta0 = pitch_theta0_200 ;
      thetaDot0 = pitch_thetaDot0_201 ;
      actuatorType = 1 ;
      pitch_filterConstant = pitch_filterConstant_203 ;
      cpc =
      { gS_factor = cpc_gS_factor_204 ;
        kI = cpc_kI_205 ;
        kP = cpc_kP_206 ; tI = cpc_tI_207 ; antiWindUp = cpc_antiWindUp_208 } } }

