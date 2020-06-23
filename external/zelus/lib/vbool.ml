(* The Zélus compiler, version 2.0
  (lundi 23 mars 2020, 09:23:21 (UTC+0100)) *)
open Ztypes
type vbool = (bool  * float)
let check_vbool ((b_227:'a2855) , (f_228:float)) =
  (>=) f_228  0.

let top = (true , infinity)

let bottom = (false , neg_infinity)

let good (f_229:'a2870) =
  (true , f_229)

let bad (f_230:'a2874) =
  (true , f_230)

let howTrue ((b_231:bool) , (f_232:float)) =
  if b_231 then (+.) 1.  f_232 else (-.) (-1.)  f_232

let lt ((x_233:float) , (y_234:float)) =
  if (<) x_233  y_234
  then (true , ((-.) y_234  x_233))
  else (false , ((-.) x_233  y_234))

let le ((x_235:float) , (y_236:float)) =
  if (<=) x_235  y_236
  then (true , ((-.) y_236  x_235))
  else (false , ((-.) x_235  y_236))

let gt ((x_237:float) , (y_238:float)) =
  if (>) x_237  y_238
  then (true , ((-.) x_237  y_238))
  else (false , ((-.) y_238  x_237))

let ge ((x_239:float) , (y_240:float)) =
  if (>=) x_239  y_240
  then (true , ((-.) x_239  y_240))
  else (false , ((-.) y_240  x_239))

let neg ((b_241:bool) , (v_242:'a2993)) =
  ((not b_241) , v_242)

let scale ((k_244:float) , ((b_243:'a3003) , (v_245:float))) =
  (b_243 , (( *. ) v_245  k_244))

let temporal_scale ((k_247:float) , ((b_246:bool) , (v_248:float))) =
  if b_246
  then (b_246 , (( *. ) v_248  k_247))
  else (b_246 , ((/.) v_248  k_247))

let staliro_combine_false ((v1_249:'a3045) , (v2_250:'a3045)) =
  max v1_249  v2_250

let staliro_combine_true ((v1_251:'a3055) , (v2_252:'a3055)) =
  min v1_251  v2_252

let staliro_and (((v1_253:bool) , (v1_254:'a3073)) ,
                 ((v2_255:bool) , (v2_256:'a3073))) =
  let result_261 = ref ((false , Obj.magic ()):bool * 'a) in
  (begin match (v1_253 , v2_255) with
         | (false , false) ->
             result_261 := (false , (staliro_combine_false (v1_254 , v2_256)))
         | (false , true) -> result_261 := (false , v1_254)
         | (true , false) -> result_261 := (false , v2_256)
         | (true , true) ->
             result_261 := (true , (staliro_combine_true (v1_254 , v2_256)))
          end) ; !result_261

type ('c , 'b , 'a) _staliro_always =
  { mutable i_278 : 'c ; mutable m_273 : 'b ; mutable result_272 : 'a }

let staliro_always  = 
  
  let staliro_always_alloc _ =
    ();
    { i_278 = (false:bool) ;
      m_273 = ((false , Obj.magic ()):bool * 'b) ;
      result_272 = ((false , Obj.magic ()):bool * 'b) } in
  let staliro_always_reset self  =
    (self.i_278 <- true:unit) in 
  let staliro_always_step self ((v_262:bool) , (v_263:'a3119)) =
    (((if self.i_278 then self.m_273 <- (v_262 , v_263)) ;
      (let ((x_274:bool) , (x_275:'a3119)) = self.m_273 in
       (begin match (v_262 , x_274) with
              | (false , false) ->
                  self.result_272 <- (false ,
                                      (staliro_combine_false (v_263 , x_275)))
              | (false , true) -> self.result_272 <- (false , v_263)
              | (true , false) -> self.result_272 <- (false , x_275)
              | (true , true) ->
                  self.result_272 <- (true ,
                                      (staliro_combine_true (v_263 , x_275)))
               end) ;
       (let ((x_276:bool) , (x_277:'a3119)) =
            if self.i_278 then (v_262 , v_263) else self.result_272 in
        self.i_278 <- false ; self.m_273 <- (x_276 , x_277) ; (x_276 , x_277)))):
    bool * 'b) in
  Node { alloc = staliro_always_alloc; reset = staliro_always_reset ;
                                       step = staliro_always_step }
let staliro_or (((v1_279:bool) , (v1_280:'a3178)) ,
                ((v2_281:bool) , (v2_282:'a3178))) =
  neg (staliro_and ((neg (v1_279 , v1_280)) , (neg (v2_281 , v2_282))))

let staliro_imply (((v1_283:bool) , (v1_284:'a3196)) ,
                   ((v2_285:bool) , (v2_286:'a3196))) =
  staliro_or ((neg (v1_283 , v1_284)) , (v2_285 , v2_286))

type ('a) _staliro_eventually =
  { mutable i_335 : 'a }

let staliro_eventually  = 
  let Node { alloc = i_335_alloc; step = i_335_step ; reset = i_335_reset } = staliro_always 
   in
  let staliro_eventually_alloc _ =
    ();{ i_335 = i_335_alloc () (* discrete *)  } in
  let staliro_eventually_reset self  =
    (i_335_reset self.i_335 :unit) in 
  let staliro_eventually_step self ((v_287:bool) , (v_288:'a3212)) =
    (neg (i_335_step self.i_335 (neg (v_287 , v_288))):bool * 'c) in
  Node { alloc = staliro_eventually_alloc; reset = staliro_eventually_reset ;
                                           step = staliro_eventually_step }
let plus_combine_false ((v1_289:float) , (v2_290:float)) =
  (+.) v1_289  v2_290

let plus_combine_true ((v1_291:float) , (v2_292:float)) =
  (/.) 1.  ((+.) ((/.) 1.  v1_291)  ((/.) 1.  v2_292))

let plus_and (((v1_293:bool) , (v1_294:float)) ,
              ((v2_295:bool) , (v2_296:float))) =
  let result_301 = ref ((false , 42.):bool * float) in
  (begin match (v1_293 , v2_295) with
         | (false , false) ->
             result_301 := (false , (plus_combine_false (v1_294 , v2_296)))
         | (false , true) -> result_301 := (false , v1_294)
         | (true , false) -> result_301 := (false , v2_296)
         | (true , true) ->
             result_301 := (true , (plus_combine_true (v1_294 , v2_296)))
          end) ; !result_301

type ('c , 'b , 'a) _plus_always =
  { mutable i_319 : 'c ; mutable m_314 : 'b ; mutable result_313 : 'a }

let plus_always  = 
  
  let plus_always_alloc _ =
    ();
    { i_319 = (false:bool) ;
      m_314 = ((false , 42.):bool * float) ;
      result_313 = ((false , 42.):bool * float) } in
  let plus_always_reset self  =
    (self.i_319 <- true:unit) in 
  let plus_always_step self ((deltaT_302:float) ,
                             ((v_303:bool) , (v_304:float))) =
    (((if self.i_319 then self.m_314 <- (v_303 , v_304)) ;
      (let ((x_315:bool) , (x_316:float)) = self.m_314 in
       (begin match (v_303 , x_315) with
              | (false , false) ->
                  self.result_313 <- (false ,
                                      (plus_combine_false (v_304 , x_316)))
              | (false , true) -> self.result_313 <- (false , v_304)
              | (true , false) -> self.result_313 <- (false , x_316)
              | (true , true) ->
                  self.result_313 <- (true ,
                                      (plus_combine_true (v_304 , x_316)))
               end) ;
       (let ((x_317:bool) , (x_318:float)) =
            if self.i_319 then (v_303 , v_304) else self.result_313 in
        self.i_319 <- false ;
        self.m_314 <- (x_317 , x_318) ;
        temporal_scale (deltaT_302 , (x_317 , x_318))))):bool * float) in
  Node { alloc = plus_always_alloc; reset = plus_always_reset ;
                                    step = plus_always_step }
let plus_or (((v1_320:bool) , (v1_321:float)) ,
             ((v2_322:bool) , (v2_323:float))) =
  neg (plus_and ((neg (v1_320 , v1_321)) , (neg (v2_322 , v2_323))))

let plus_imply (((v1_324:bool) , (v1_325:float)) ,
                ((v2_326:bool) , (v2_327:float))) =
  plus_or ((neg (scale (10000. , (v1_324 , v1_325)))) , (v2_326 , v2_327))

type ('a) _plus_eventually =
  { mutable i_336 : 'a }

let plus_eventually  = 
  let Node { alloc = i_336_alloc; step = i_336_step ; reset = i_336_reset } = plus_always 
   in
  let plus_eventually_alloc _ =
    ();{ i_336 = i_336_alloc () (* discrete *)  } in
  let plus_eventually_reset self  =
    (i_336_reset self.i_336 :unit) in 
  let plus_eventually_step self ((deltaT_332:float) ,
                                 ((v_333:bool) , (v_334:float))) =
    (neg (i_336_step self.i_336 (deltaT_332 , (v_333 , v_334))):bool * float) in
  Node { alloc = plus_eventually_alloc; reset = plus_eventually_reset ;
                                        step = plus_eventually_step }
