(* The Zélus compiler, version 2.0
  (lundi 25 mai 2020, 14:33:03 (UTC+0200)) *)
open Ztypes
type vbool = (bool  * float)
let check_vbool ((b_242:'a2965) , (f_243:float)) =
  (>=) f_243  0.

let top = (true , infinity)

let bottom = (false , neg_infinity)

let good (f_244:'a2980) =
  (true , f_244)

let bad (f_245:'a2984) =
  (false , f_245)

let howTrue ((b_246:bool) , (f_247:float)) =
  if b_246 then (+.) 1.  f_247 else (-.) (-1.)  f_247

let isTrue ((b_248:'a3006) , _) =
  b_248

let isFalse ((b_249:bool) , _) =
  not b_249

let rob (_ , (f_250:'a3021)) =
  f_250

let lt ((x_251:float) , (y_252:float)) =
  if (<) x_251  y_252
  then (true , ((-.) y_252  x_251))
  else (false , ((-.) x_251  y_252))

let le ((x_253:float) , (y_254:float)) =
  if (<=) x_253  y_254
  then (true , ((-.) y_254  x_253))
  else (false , ((-.) x_253  y_254))

let gt ((x_255:float) , (y_256:float)) =
  if (>) x_255  y_256
  then (true , ((-.) x_255  y_256))
  else (false , ((-.) y_256  x_255))

let ge ((x_257:float) , (y_258:float)) =
  if (>=) x_257  y_258
  then (true , ((-.) x_257  y_258))
  else (false , ((-.) y_258  x_257))

let eq ((x_259:'a3124) , (y_260:'a3124)) =
  (((=) x_259  y_260) , 0.)

let neg ((b_261:bool) , (v_262:'a3136)) =
  ((not b_261) , v_262)

let scale ((k_264:float) , ((b_263:'a3146) , (v_265:float))) =
  (b_263 , (( *. ) v_265  k_264))

let temporal_scale ((k_267:float) , ((b_266:bool) , (v_268:float))) =
  if b_266
  then (b_266 , (( *. ) v_268  k_267))
  else (b_266 , ((/.) v_268  k_267))

let staliro_combine_false ((v1_269:'a3188) , (v2_270:'a3188)) =
  max v1_269  v2_270

let staliro_combine_true ((v1_271:'a3198) , (v2_272:'a3198)) =
  min v1_271  v2_272

let staliro_and (((v1_273:bool) , (v1_274:'a3216)) ,
                 ((v2_275:bool) , (v2_276:'a3216))) =
  let result_281 = ref ((false , Obj.magic ()):bool * 'a) in
  (begin match (v1_273 , v2_275) with
         | (false , false) ->
             result_281 := (false , (staliro_combine_false (v1_274 , v2_276)))
         | (false , true) -> result_281 := (false , v1_274)
         | (true , false) -> result_281 := (false , v2_276)
         | (true , true) ->
             result_281 := (true , (staliro_combine_true (v1_274 , v2_276)))
          end) ; !result_281

type ('c , 'b , 'a) _staliro_always =
  { mutable i_298 : 'c ; mutable m_293 : 'b ; mutable result_292 : 'a }

let staliro_always  = 
  
  let staliro_always_alloc _ =
    ();
    { i_298 = (false:bool) ;
      m_293 = ((false , Obj.magic ()):bool * 'b) ;
      result_292 = ((false , Obj.magic ()):bool * 'b) } in
  let staliro_always_reset self  =
    (self.i_298 <- true:unit) in 
  let staliro_always_step self ((v_282:bool) , (v_283:'a3262)) =
    (((if self.i_298 then self.m_293 <- (v_282 , v_283)) ;
      (let ((x_294:bool) , (x_295:'a3262)) = self.m_293 in
       (begin match (v_282 , x_294) with
              | (false , false) ->
                  self.result_292 <- (false ,
                                      (staliro_combine_false (v_283 , x_295)))
              | (false , true) -> self.result_292 <- (false , v_283)
              | (true , false) -> self.result_292 <- (false , x_295)
              | (true , true) ->
                  self.result_292 <- (true ,
                                      (staliro_combine_true (v_283 , x_295)))
               end) ;
       (let ((x_296:bool) , (x_297:'a3262)) =
            if self.i_298 then (v_282 , v_283) else self.result_292 in
        self.i_298 <- false ; self.m_293 <- (x_296 , x_297) ; (x_296 , x_297)))):
    bool * 'b) in
  Node { alloc = staliro_always_alloc; reset = staliro_always_reset ;
                                       step = staliro_always_step }
let staliro_or (((v1_299:bool) , (v1_300:'a3321)) ,
                ((v2_301:bool) , (v2_302:'a3321))) =
  neg (staliro_and ((neg (v1_299 , v1_300)) , (neg (v2_301 , v2_302))))

let staliro_imply (((v1_303:bool) , (v1_304:'a3339)) ,
                   ((v2_305:bool) , (v2_306:'a3339))) =
  staliro_or ((neg (v1_303 , v1_304)) , (v2_305 , v2_306))

type ('a) _staliro_eventually =
  { mutable i_355 : 'a }

let staliro_eventually  = 
  let Node { alloc = i_355_alloc; step = i_355_step ; reset = i_355_reset } = staliro_always 
   in
  let staliro_eventually_alloc _ =
    ();{ i_355 = i_355_alloc () (* discrete *)  } in
  let staliro_eventually_reset self  =
    (i_355_reset self.i_355 :unit) in 
  let staliro_eventually_step self ((v_307:bool) , (v_308:'a3355)) =
    (neg (i_355_step self.i_355 (neg (v_307 , v_308))):bool * 'c) in
  Node { alloc = staliro_eventually_alloc; reset = staliro_eventually_reset ;
                                           step = staliro_eventually_step }
let plus_combine_false ((v1_309:float) , (v2_310:float)) =
  (+.) v1_309  v2_310

let plus_combine_true ((v1_311:float) , (v2_312:float)) =
  (/.) 1.  ((+.) ((/.) 1.  v1_311)  ((/.) 1.  v2_312))

let plus_and (((v1_313:bool) , (v1_314:float)) ,
              ((v2_315:bool) , (v2_316:float))) =
  let result_321 = ref ((false , 42.):bool * float) in
  (begin match (v1_313 , v2_315) with
         | (false , false) ->
             result_321 := (false , (plus_combine_false (v1_314 , v2_316)))
         | (false , true) -> result_321 := (false , v1_314)
         | (true , false) -> result_321 := (false , v2_316)
         | (true , true) ->
             result_321 := (true , (plus_combine_true (v1_314 , v2_316)))
          end) ; !result_321

type ('c , 'b , 'a) _plus_always =
  { mutable i_339 : 'c ; mutable m_334 : 'b ; mutable result_333 : 'a }

let plus_always  = 
  
  let plus_always_alloc _ =
    ();
    { i_339 = (false:bool) ;
      m_334 = ((false , 42.):bool * float) ;
      result_333 = ((false , 42.):bool * float) } in
  let plus_always_reset self  =
    (self.i_339 <- true:unit) in 
  let plus_always_step self ((deltaT_322:float) ,
                             ((v_323:bool) , (v_324:float))) =
    (((if self.i_339 then self.m_334 <- (v_323 , v_324)) ;
      (let ((x_335:bool) , (x_336:float)) = self.m_334 in
       (begin match (v_323 , x_335) with
              | (false , false) ->
                  self.result_333 <- (false ,
                                      (plus_combine_false (v_324 , x_336)))
              | (false , true) -> self.result_333 <- (false , v_324)
              | (true , false) -> self.result_333 <- (false , x_336)
              | (true , true) ->
                  self.result_333 <- (true ,
                                      (plus_combine_true (v_324 , x_336)))
               end) ;
       (let ((x_337:bool) , (x_338:float)) =
            if self.i_339 then (v_323 , v_324) else self.result_333 in
        self.i_339 <- false ;
        self.m_334 <- (x_337 , x_338) ;
        temporal_scale (deltaT_322 , (x_337 , x_338))))):bool * float) in
  Node { alloc = plus_always_alloc; reset = plus_always_reset ;
                                    step = plus_always_step }
let plus_or (((v1_340:bool) , (v1_341:float)) ,
             ((v2_342:bool) , (v2_343:float))) =
  neg (plus_and ((neg (v1_340 , v1_341)) , (neg (v2_342 , v2_343))))

let plus_imply (((v1_344:bool) , (v1_345:float)) ,
                ((v2_346:bool) , (v2_347:float))) =
  plus_or ((neg (scale (10000. , (v1_344 , v1_345)))) , (v2_346 , v2_347))

type ('a) _plus_eventually =
  { mutable i_356 : 'a }

let plus_eventually  = 
  let Node { alloc = i_356_alloc; step = i_356_step ; reset = i_356_reset } = plus_always 
   in
  let plus_eventually_alloc _ =
    ();{ i_356 = i_356_alloc () (* discrete *)  } in
  let plus_eventually_reset self  =
    (i_356_reset self.i_356 :unit) in 
  let plus_eventually_step self ((deltaT_352:float) ,
                                 ((v_353:bool) , (v_354:float))) =
    (neg (i_356_step self.i_356 (deltaT_352 , (v_353 , v_354))):bool * float) in
  Node { alloc = plus_eventually_alloc; reset = plus_eventually_reset ;
                                        step = plus_eventually_step }
