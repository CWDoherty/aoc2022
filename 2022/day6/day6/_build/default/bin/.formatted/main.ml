open Core;;
let input = In_channel.read_all "./input.txt";;
module CharSet = Set.Make(Char);;

let build_set string length offset =
    let list = [] in
    for i = 0 in length do
        list@[input.[i + offset]]
    done;;
    return CharSet.elements (CharSet.of_list list)
let currentIndex = ref 0 in
try
    while true do
        let firstChar = input.[!currentIndex] in
        let secondChar = input.[!currentIndex + 1] in
        let thirdChar = input.[!currentIndex + 2] in
        let fourthChar = input.[!currentIndex + 3] in
        let charSet = CharSet.elements (CharSet.of_list [firstChar; secondChar; thirdChar; fourthChar]) in
        let charSetString = Base.String.of_char_list charSet in

        if (phys_equal (String.length charSetString) 4)
        then raise Exit
        else currentIndex := !currentIndex + 1
    done;
with Exit -> Out_channel.output_string stdout (string_of_int (!currentIndex + 4))

