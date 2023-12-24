(*********************
 * Dataset
 *********************)
module Dataset = struct
  type t = {
    n : int; (* 2 ≤ n ≤ 100 *)
    a_s : int list; (* List.length a_s = n ∧ (∀ a ∈ a_s. 1 ≤ v ≤ 10^4) *)
  }

  let rec parse_input = function
    | [] -> []
    | n_str :: a_s_str :: lines ->
        {
          n = int_of_string n_str;
          a_s = a_s_str |> String.split_on_char ' ' |> List.map @@ int_of_string;
        }
        :: parse_input lines
    | _ -> raise Util.Invalid_input
end

(*********************
  * Main
  *********************)
let solve () =
  Util.read_input "0" |> Dataset.parse_input
  |> List.iter (fun ({ a_s; _ } : Dataset.t) ->
         a_s
         |> List.map @@ ( - ) 2023
         |> List.map Int.abs
         |> List.mapi (fun i x -> (i + 1, x))
         |> List.sort (fun (_, x) (_, x') -> compare x x')
         |> List.hd |> fst |> Printf.printf "%d\n")
