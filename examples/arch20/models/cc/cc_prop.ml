type state = {
  q : (MyOp.t * MyOp.t * MyOp.t * MyOp.t * MyOp.t) Queue.t;
}

let create () = {
  q = Queue.create ()
}

let update_sliding_window size x q =
  let (t, _, _, _, _) = x in
  Queue.push x q;
  let stop = ref false in
  while not !stop do
    let (t0, _, _, _, _) = Queue.peek q in
    if MyOp.get t0 < MyOp.get t -. size then
      ignore (Queue.pop q)
    else stop := true
  done

(* Fml5: always_[0,72] possibly_[0,8]((always_[0,5] y2-y1 >= 9) -> (always_[5,20]y5-y4>= 9)) *)
let cc5_sliding_window state (t, c1, c2, c4, c5) =
  update_sliding_window 5. (t, c1, c2, c4, c5) state.q;
  let always_c2_c1 =
    Queue.fold (fun acc (t0, c1, c2, c4, c5) ->
        if MyOp.get t0 <= MyOp.get t -. 15. then
          let c2_c1 = MyOp.(c2 - c1 - (make 9.)) in
          MyOp.min acc c2_c1
        else acc
      ) MyOp.infinity state.q
  in
  let always_c5_c4 =
    Queue.fold (fun acc (t0, c1, c2, c4, c5) ->
      if MyOp.get t0 >= MyOp.get t -. 15. then
        let c5_c4 = MyOp.(c5 - c4 - (make 9.)) in
        MyOp.min acc c5_c4
      else acc
      ) MyOp.infinity state.q
  in MyOp.max (MyOp.(~-) always_c2_c1) always_c5_c4
