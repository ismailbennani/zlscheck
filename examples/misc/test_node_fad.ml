(* The Zélus compiler, version 2.1
  (lundi 9 novembre 2020, 18:33:12 (UTC+0100)) *)
open Ztypes_fad
open Nodes_fad
type ('c , 'b , 'a) _system =
  { mutable major_115 : 'c ; mutable i_119 : 'b ; mutable y_118 : 'a }

let system (cstate_161:Ztypes_fad.cstate) = 
  
  let system_alloc _ =
    cstate_161.cmax <- Stdlib.(+) cstate_161.cmax  1;
    { major_115 = false ;
      i_119 = (false:bool) ; y_118 = { pos = FadFloat.create (); der = FadFloat.create () } } in
  let system_step self ((time_114:float) ,
                        ((x_112:FadFloat.t) , (y0_113:FadFloat.t))) =
    ((let (cindex_162:int) = cstate_161.cindex in
      let cpos_164 = ref (cindex_162:int) in
      cstate_161.cindex <- Stdlib.(+) cstate_161.cindex  1 ;
      self.major_115 <- cstate_161.major ;
      (if cstate_161.major then
       for i_1 = cindex_162 to 0 do Zls_fad.set cstate_161.dvec  i_1  (FadFloat.create ()) done
       else ((self.y_118.pos <- Zls_fad.get cstate_161.cvec  !cpos_164 ;
              cpos_164 := Stdlib.(+) !cpos_164  1))) ;
      (let (result_166:FadFloat.t) =
           (if self.i_119 then self.y_118.pos <- y0_113) ;
           self.i_119 <- false ;
           (let (out_y_117:FadFloat.t) = self.y_118.pos in
            let (dy_116:FadFloat.t) = FadFloat.scale x_112  2. in
            self.y_118.der <- dy_116 ; out_y_117) in
       cpos_164 := cindex_162 ;
       (if cstate_161.major then
        (((Zls_fad.set cstate_161.cvec  !cpos_164  self.y_118.pos ;
           cpos_164 := Stdlib.(+) !cpos_164  1)))
        else (((Zls_fad.set cstate_161.dvec  !cpos_164  self.y_118.der ;
                cpos_164 := Stdlib.(+) !cpos_164  1)))) ; result_166)):
    FadFloat.t) in  let system_reset self  =
                      (self.i_119 <- true:unit) in
  Node { alloc = system_alloc; step = system_step ; reset = system_reset }
type ('c , 'b , 'a) _system2 =
  { mutable major_123 : 'c ; mutable i_127 : 'b ; mutable y_126 : 'a }

let system2 (cstate_167:Ztypes_fad.cstate) = 
  
  let system2_alloc _ =
    cstate_167.cmax <- Stdlib.(+) cstate_167.cmax  1;
    { major_123 = false ;
      i_127 = (false:bool) ; y_126 = { pos = FadFloat.create (); der = FadFloat.create () } } in
  let system2_step self ((time_122:float) ,
                         ((x_120:FadFloat.t) , (y0_121:FadFloat.t))) =
    ((let (cindex_168:int) = cstate_167.cindex in
      let cpos_170 = ref (cindex_168:int) in
      cstate_167.cindex <- Stdlib.(+) cstate_167.cindex  1 ;
      self.major_123 <- cstate_167.major ;
      (if cstate_167.major then
       for i_1 = cindex_168 to 0 do Zls_fad.set cstate_167.dvec  i_1  (FadFloat.create ()) done
       else ((self.y_126.pos <- Zls_fad.get cstate_167.cvec  !cpos_170 ;
              cpos_170 := Stdlib.(+) !cpos_170  1))) ;
      (let (result_172:FadFloat.t) =
           (if self.i_127 then self.y_126.pos <- y0_121) ;
           self.i_127 <- false ;
           (let (out_y_125:FadFloat.t) = self.y_126.pos in
            let (dy_124:FadFloat.t) =
                FadFloat.scale (FadFloat.( * ) x_120  out_y_125)  2. in
            self.y_126.der <- dy_124 ; out_y_125) in
       cpos_170 := cindex_168 ;
       (if cstate_167.major then
        (((Zls_fad.set cstate_167.cvec  !cpos_170  self.y_126.pos ;
           cpos_170 := Stdlib.(+) !cpos_170  1)))
        else (((Zls_fad.set cstate_167.dvec  !cpos_170  self.y_126.der ;
                cpos_170 := Stdlib.(+) !cpos_170  1)))) ; result_172)):
    FadFloat.t) in  let system2_reset self  =
                      (self.i_127 <- true:unit) in
  Node { alloc = system2_alloc; step = system2_step ; reset = system2_reset }
type ('b , 'a) _wrapper =
  { mutable i_158 : 'b ; mutable major_130 : 'a }

let wrapper (cstate_173:Ztypes_fad.cstate) = 
  let Node { alloc = i_158_alloc; step = i_158_step ; reset = i_158_reset } = system2 
  cstate_173 in
  let wrapper_alloc _ =
    ();{ major_130 = false;i_158 = i_158_alloc () (* continuous *)  } in
  let wrapper_step self ((time_129:float) , (inp_128:(FadFloat.t)Array.t)) =
    ((self.major_130 <- cstate_173.major ;
      (let (y0_134:FadFloat.t) = Array.get inp_128  1 in
       let (x_132:FadFloat.t) = Array.get inp_128  0 in
       let (y_133:FadFloat.t) =
           i_158_step self.i_158 (time_129 , (x_132 , y0_134)) in
       let (outp_131:(FadFloat.t)Array.t) =
           Array.of_list ((::) (y_133 , ([]))) in
       outp_131)):FadFloat.t Array.t) in 
  let wrapper_reset self  =
    (i_158_reset self.i_158 :unit) in
  Node { alloc = wrapper_alloc; step = wrapper_step ; reset = wrapper_reset }
type ('c , 'b , 'a) _discrete_system =
  { mutable i_159 : 'c ; mutable i_148 : 'b ; mutable m_146 : 'a }

let discrete_system  = 
  let Node { alloc = i_159_alloc; step = i_159_step ; reset = i_159_reset } = 
  Nodes_fad.solve wrapper  20.  in
  let discrete_system_alloc _ =
    ();
    { i_148 = (false:bool) ; m_146 = (42.:float);
      i_159 = i_159_alloc () (* discrete *)  } in
  let discrete_system_reset self  =
    ((self.i_148 <- true ; self.m_146 <- 0.01 ; i_159_reset self.i_159 ):
    unit) in 
  let discrete_system_step self ((x_135:FadFloat.t) , (y0_136:FadFloat.t)) =
    ((let yp_145 = ref (false:bool) in
      let yv_144 = ref (Obj.magic ():FadFloat.t) in
      (if self.i_148 then self.m_146 <- 0.01) ;
      self.i_148 <- false ;
      (let (x_147:float) = self.m_146 in
       let (inp_138:(FadFloat.t)Array.t) =
           Array.of_list ((::) (x_135 , ((::) (y0_136 , ([]))))) in
       let { Nodes_fad.time = (t_142:float) ;
             Nodes_fad.status = (status_141:Nodes_fad.status) ;
             Nodes_fad.result = (outp_140:(FadFloat.t)Array.t) } =
           i_159_step self.i_159 (x_147 , inp_138) in
       let (y__143:FadFloat.t) = Array.get outp_140  0 in
       (begin match status_141 with
              | Nodes_fad.Interpolate | Nodes_fad.RootsFound | Nodes_fad.Cascade | Nodes_fad.StopTimeReached | Nodes_fad.TimeHasPassed ->
                  yp_145 := true ; yv_144 := y__143
              | Nodes_fad.Horizon(_) | Nodes_fad.Success(_) | Nodes_fad.Error ->
                  ()
               end) ;
       self.m_146 <- (if (>=) t_142  x_147 then (+.) x_147  0.01 else x_147)
       ; (t_142 , (!yv_144 , !yp_145)))):float * FadFloat.t signal) in
  Node { alloc = discrete_system_alloc; reset = discrete_system_reset ;
                                        step = discrete_system_step }
type ('a) _main =
  { mutable i_160 : 'a }

let main  = 
  let Node { alloc = i_160_alloc; step = i_160_step ; reset = i_160_reset } = discrete_system 
   in let main_alloc _ =
        ();{ i_160 = i_160_alloc () (* discrete *)  } in
  let main_reset self  =
    (i_160_reset self.i_160 :unit) in 
  let main_step self () =
    ((let resultp_155 = ref (false:bool) in
      let resultv_154 = ref ("aaaaaaa":string) in
      let (x_149:FadFloat.t) = FadFloat.make 3. in
      let (y0_150:FadFloat.t) = FadFloat.make 1. in
      let _ = FadFloat.diff x_149  0  1 in
      let _ = FadFloat.diff y0_150  1  2 in
      let ((t_151:float) , ((yv_152:FadFloat.t) , (copy_157:bool))) =
          i_160_step self.i_160 (x_149 , y0_150) in
      (begin match (yv_152 , copy_157) with
             | ((res_156:FadFloat.t) , true) ->
                 resultp_155 := true ;
                 (let _ =
                      print_endline ((^) "sys(x=" 
                                         ((^) (string_of_float (FadFloat.get 
                                                                  x_149)) 
                                              ((^) ", y0=" 
                                                   ((^) (string_of_float 
                                                           (FadFloat.get 
                                                              y0_150)) 
                                                        ((^) ")(t=" 
                                                             ((^) (string_of_float 
                                                                    t_151) 
                                                                  ((^) 
                                                                    ") = " 
                                                                    (
                                                                    FadFloat.to_string 
                                                                    res_156)))))))) in
                  resultv_154 := input_line stdin) | _ -> ()  end) ;
      (!resultv_154 , !resultp_155)):string signal) in
  Node { alloc = main_alloc; reset = main_reset ; step = main_step }
