module type S =
sig
  type t
  type params

  val init : params -> t
  val log : t -> float * float array * float array * float -> unit
  val finalize : t -> unit
end

module None =
struct
  type t = unit
  type params = unit

  let init () = ()
  let log () _ = ()
  let finalize () = ()
end

module LogToFile =
struct
  type t = out_channel
  type params = string

  let init path = open_out path
  let log fd (t, inp, out, rob) =
    let open Printer in
    Printf.fprintf fd "%g,%s,%s,%g\n"
      t (string_of_float_array "," inp) 
      (string_of_float_array "," out) rob
  let finalize fd = close_out fd
end

module LogAll =
struct
  type t = LogToFile.t
  type params = LogToFile.params

  let init folder = 
    let i = ref 1 in 
    while (Sys.file_exists (Filename.concat folder (Printf.sprintf "%d.csv" !i))) do 
      i := !i + 1;
    done;
    ignore(Unix.system ("mkdir -p " ^ folder ^ " > /dev/null"));
    LogToFile.init (Filename.concat folder (Printf.sprintf "%d.csv" !i))
  let log = LogToFile.log
  let finalize = LogToFile.finalize
end

module LogFals =
struct
  type t = {
    folder: string;
    tmp_path: string;
    mutable falsified: bool;
    p: LogToFile.t;
  }   
  type params = LogToFile.params

  let init folder = 
    let tmp_path = Filename.temp_file "fals" ".csv" in
    ignore(Unix.system ("mkdir -p " ^ folder ^ " > /dev/null"));
    {
      folder; tmp_path; falsified = false;
      p = LogToFile.init tmp_path;
    }
  let log ({ p } as params) (t, inp, out, rob) = 
    params.falsified <- rob < 0.;
    LogToFile.log p (t, inp, out, rob)
  let finalize { folder; tmp_path; falsified; p } = 
    LogToFile.finalize p;
    if falsified then begin
      let filename = Filename.remove_extension (Filename.basename tmp_path) in    
      let new_filename = 
        let new_filename = Filename.concat folder (filename ^ ".csv") in
        if Sys.file_exists new_filename then
          let suffix = ref 0 in
          while (Sys.file_exists (Filename.concat folder (Printf.sprintf "%s%d.csv" filename !suffix))) do
            suffix := !suffix + 1
          done;
          Filename.concat folder (Printf.sprintf "%s%d.csv" filename !suffix)
        else new_filename
      in
      ignore(Unix.system ("mv " ^ tmp_path ^ " " ^ new_filename));
    end
end

module Combine(Log1 : S)(Log2 : S) =
struct
  type t = Log1.t * Log2.t
  type params = Log1.params * Log2.params

  let init (p1, p2) = Log1.init p1, Log2.init p2
  let log (t1, t2) x =
    Log1.log t1 x;
    Log2.log t2 x
  let finalize (t1, t2) =
    Log1.finalize t1;
    Log2.finalize t2
end