open Core;;
let input = In_channel.read_all "./input.txt";;
module CharSet = Set.Make(Char);;

let build_list string startIndex size =
    let list = ref [] in
    for i = 0 to size - 1 do
        let char = string.[startIndex + i] in
        list := !list@[char];
    done;
    !list;;

let find_index string number_unique =
    let currentIndex = ref 0 in
    try
    	while true do
            let charSet = CharSet.elements (CharSet.of_list (build_list string !currentIndex number_unique)) in
            let charSetString = Base.String.of_char_list charSet in

            if (phys_equal (String.length charSetString) number_unique)
            then raise Exit
            else currentIndex := !currentIndex + 1
    	done;
    with
    	Exit -> print_endline (string_of_int (!currentIndex + number_unique));;

(* Part 1 *)
find_index input 4;;

print_endline "";;
(* Part 2 *)
find_index input 14;;

