defmodule AtomMapperTest do
  use ExUnit.Case

  test "is_any" do
    assert AtomMapper.is_any(3) == 3
    assert AtomMapper.is_any(true) == true
    assert AtomMapper.is_any("yeah") == "yeah"
  end

  test "to_int" do
    assert AtomMapper.to_int("3") == 3
    assert AtomMapper.to_int("ok") == false
    assert AtomMapper.to_int(3) == 3
  end

  test "map simple map" do
    this = %{"this" => 4, "that" => "yeah", "what" => true}
    that = %{this: 4, that: "yeah", what: true}
    spec = %{this: &is_integer/1, that: &AtomMapper.is_any/1, what: :any}
    assert that == AtomMapper.map(this, spec)
  end

  test "rejecting" do
    this = %{"this" => 4, "that" => "yeah", "what" => true}
    that = %{what: true}
    spec = %{this: &is_boolean/1, that: [:who, :when], what: :any}
    assert that == AtomMapper.map(this, spec)
  end

  test "map simple map with atom values" do
    this = %{"this" => 4, "that" => "yeah", "what" => true}
    that = %{this: 4, that: :yeah, what: true}
    spec = %{this: &is_integer/1, that: [:yeah, :what], what: &is_boolean/1}
    assert that == AtomMapper.map(this, spec)
  end

  test "map nested map" do
    this = %{"this" => 4, "that" => %{"next" => 2, "past" => true}}
    that = %{this: 4, that: %{next: 2, past: true}}
    spec = %{this: &is_integer/1, that: %{next: &is_integer/1, past: &is_boolean/1}}
    assert that == AtomMapper.map(this, spec)
  end
end
