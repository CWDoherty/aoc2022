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

(* Part 1 *)
let currentIndex = ref 0 in
try
    while true do
        let charSet = CharSet.elements (CharSet.of_list (build_list input !currentIndex 4)) in
        let charSetString = Base.String.of_char_list charSet in

        if (phys_equal (String.length charSetString) 4)
        then raise Exit
        else currentIndex := !currentIndex + 1
    done;
with Exit -> Out_channel.output_string stdout (string_of_int (!currentIndex + 4));

print_endline "\n";;

(* Part 2 *)
let currentIndexPart2 = ref 0 in
try
    while true do
        let charSet = CharSet.elements (CharSet.of_list (build_list input !currentIndexPart2 14)) in
        let charSetString = Base.String.of_char_list charSet in

        if (phys_equal (String.length charSetString) 14)
        then raise Exit
        else currentIndexPart2 := !currentIndexPart2 + 1
    done;
with Exit -> Out_channel.output_string stdout (string_of_int (!currentIndexPart2 + 14));
