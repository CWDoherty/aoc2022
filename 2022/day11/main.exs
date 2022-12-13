defmodule Monkey do
  defstruct id: nil, items: [], testNumber: nil, operation: nil, trueMonkey: nil, falseMonkey: nil, number_of_inspections: 0
end

defmodule Main do
  def parse_monkey(monkey) do
    monkeyParts = String.split(monkey, "\n")

    id =
      String.to_integer(
        Enum.at(monkeyParts, 0)
        |> String.split(" ")
        |> Enum.at(1)
        |> String.at(0)
      ) / 1

    items =
      Enum.at(monkeyParts, 1)
      |> String.split(":")
      |> Enum.at(1)
      |> String.split(",")
      |> Enum.map(&String.replace(&1, " ", ""))
      |> Enum.map(&(String.to_integer(&1) / 1))


    operation = Enum.at(monkeyParts, 2) |> String.split("=") |> Enum.at(1) |> String.trim()

    testNumber =
      String.to_integer(Enum.at(monkeyParts, 3) |> String.split(" ") |> List.last()) / 1

    trueMonkey =
      String.to_integer(Enum.at(monkeyParts, 4) |> String.split(" ") |> List.last()) / 1

    falseMonkey =
      String.to_integer(Enum.at(monkeyParts, 5) |> String.split(" ") |> List.last()) / 1

    %Monkey{
      id: id,
      items: items,
      operation: operation,
      testNumber: testNumber,
      trueMonkey: trueMonkey,
      falseMonkey: falseMonkey,
      number_of_inspections: 0,
    }
  end

  def monkey_round(monkeys) do
    Enum.reduce(monkeys, monkeys, fn {index, _monkey}, acc ->
      monkey_throws(acc, index)
    end)
  end

  def monkey_throws(monkeys, index) do
    Enum.reduce(monkeys[index].items, monkeys, fn item, acc ->
      thrower = acc[index]
      new_item_before_relief = apply_operation(thrower.operation, item)
      new_item_after_relief = reduce_worry(new_item_before_relief)
      receiver_id = case rem(trunc(new_item_after_relief), trunc(thrower.testNumber)) do
        0 -> trunc(thrower.trueMonkey)
        _ -> trunc(thrower.falseMonkey)
      end
      receiver = Map.update!(acc[receiver_id], :items, &[new_item_after_relief | &1])
      thrower = %{thrower | items: [], number_of_inspections: thrower.number_of_inspections + 1}
      %{acc | index => thrower, receiver_id => receiver}
    end)
  end

  def apply_operation(operation, value) do
    operator = Enum.at(String.split(operation, " "), 1)
    second_operand_str = Enum.at(String.split(operation, " "), 2)
    second_operand = if second_operand_str == "old" do value else String.to_integer(second_operand_str) / 1 end
    case operator do
      "*" -> value * second_operand
      "+" -> value + second_operand
    end
  end

  def reduce_worry(item) do
    floor(item / 3)
  end

  def main(input, rounds) do
    monkeys =
      input
      |> String.split("\n\n")
      |> Enum.map(&parse_monkey(&1))
      |> Enum.with_index
      |> Map.new(fn {monkey, index} -> {index, monkey} end)

    monkey_business =
      Enum.reduce(1..rounds, monkeys, fn _, acc ->
        monkey_round(acc)
      end)
      |> Enum.map(fn {_, monkey} -> monkey.number_of_inspections end)
      |> Enum.sort(:desc)
      |> Enum.take(2)
      |> Enum.product

    monkey_business
  end
end

input = File.read!("input.txt")
part1 = Main.main(input, 20)

IO.puts "Part 1: #{part1}"
