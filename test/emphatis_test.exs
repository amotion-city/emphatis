defmodule EmphatisTest do
  use ExUnit.Case
  doctest Emphatis

  test "greets the world" do
    assert Emphatis.bold("Hello, world, it’s 2018!") == "𝐇𝐞𝐥𝐥𝐨, 𝐰𝐨𝐫𝐥𝐝, 𝐢𝐭’𝐬 𝟐𝟎𝟏𝟖!"
  end
end
