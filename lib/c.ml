(*********************
 * List
 *********************)
module List = struct
  include List

  let partition n (* 0 ≤ n *) xs =
    let xs, ys =
      xs |> mapi (fun i x -> (i, x)) |> partition (fun (i, _) -> i < n)
    in
    let remove_index = map (fun (_, x) -> x) in
    (remove_index xs, remove_index ys)

  (* NOTE: c.f. https://stackoverflow.com/questions/3989776/transpose-of-a-list-of-lists *)
  let rec transpose = function
    | [] -> []
    | [] :: xss -> transpose xss
    | (x :: xs) :: xss -> (x :: map hd xss) :: transpose (xs :: map tl xss)
end

(*********************
 * Dataset
 *********************)
module Dataset = struct
  type t = {
    n : int; (* 2 ≤ n ≤ 100 *)
    ass : int list list;
        (* List.length ass = n ∧
           (∀ a_s ∈ ass. List.length a_s = n) ∧
           (ass |> List.flatten |> List.sort compare = List.init (n*n) ((+) 1)) *)
  }

  let rec parse_input = function
    | [] -> []
    | n_str :: lines ->
        let n = int_of_string n_str in
        let ass_lines, lines = List.partition n lines in
        {
          n;
          ass =
            ass_lines
            |> List.map @@ String.split_on_char ' '
            |> List.map @@ List.map int_of_string;
        }
        :: parse_input lines
end

(*********************
  * Main
  *********************)
let change_seating ass =
  ass
  |> List.map (fun a_s ->
         a_s
         |> List.mapi (fun i a -> (i, a))
         |> List.fold_left
              (fun (ys, ys') (i, a) ->
                if i mod 2 = 0 then (a :: ys, ys') else (ys, a :: ys'))
              ([], [])
         |> fun (ys, ys') -> ys @ ys')

let solve () =
  Util.read_input "0" |> Dataset.parse_input
  |> List.iter (fun ({ ass; _ } : Dataset.t) ->
         ass |> change_seating |> List.transpose |> change_seating
         |> List.iter (fun a_s ->
                a_s |> List.map string_of_int |> String.concat " "
                |> print_endline))
