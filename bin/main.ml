open Icpc_domestic2023

let () =
  (* NOTE: `Sys.argv` must contain a command name at the first. *)
  match Sys.argv.(1) with
  | "a" -> A.solve ()
  (* | "b" -> B.solve () *)
  (* | "c" -> C.solve () *)
  (* | "d" -> D.solve () *)
  | _ -> raise Util.Invalid_input
