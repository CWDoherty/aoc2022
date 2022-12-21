use std::{
    collections::HashMap,
    fs::File,
    io::{BufReader, prelude::*},
    path::Path,
};

fn lines_from_file(filename: impl AsRef<Path>) -> Vec<String> {
    let file = File::open(filename).expect("no such file");
    let buf = BufReader::new(file);
    buf.lines()
        .map(|l| l.expect("Could not parse line"))
        .collect()
}

fn parse_input(lines: &Vec<String>) -> HashMap<&str, &str> {
    let mut map = HashMap::new();
    lines.iter().for_each(|l| {
        let parts = l.split(": ").collect::<Vec<&str>>();
        map.insert(parts[0], parts[1]);
    });

    return map;
}

fn do_operation(first: &u64, second: &u64, operator: &str) -> u64 {
    return match operator {
        "+"=> first + second,
        "-"=> first - second,
        "*"=> first * second,
        "/"=> first / second,
        _=> 0
    }
}

fn main() {
    let lines = lines_from_file("input.txt");
    let input_map = parse_input(&lines);
    let mut monkey_numbers: HashMap<&str, u64> = HashMap::new();
    let mut root_solved = false;

    while !root_solved {
        for (key, value) in &input_map {
            if value.contains(" ") && !monkey_numbers.contains_key(key){
                let parts = value.split(" ").collect::<Vec<&str>>();
                let first = parts[0];
                let operator = parts[1];
                let second = parts[2];

                if monkey_numbers.contains_key(&first) && monkey_numbers.contains_key(&second) {
                    let first_num = monkey_numbers.get(&first).unwrap();
                    let second_num = monkey_numbers.get(&second).unwrap();
                    let num = do_operation(first_num, second_num, operator);
                    if key == &"root" {
                        println!("Part 1: {}", num);
                        root_solved = true;
                        break;
                    }
                    monkey_numbers.insert(key, num);
                    continue;
                }
            } else if !value.contains(" ") {
                let num: u64 = value.parse::<u64>().unwrap();
                monkey_numbers.insert(key, num);
            }
        }
    }
}
