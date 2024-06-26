defmodule PatternPlotterTest do
  use ExUnit.Case
  alias Gaz.{Canvas, Color}

  test "generate_checkerboard generates correct pattern" do
    pattern = PatternPlotter.generate_checkerboard(4, 4)
    expected_pattern = [
      [Color.white(), Color.black(), Color.white(), Color.black()],
      [Color.black(), Color.white(), Color.black(), Color.white()],
      [Color.white(), Color.black(), Color.white(), Color.black()],
      [Color.black(), Color.white(), Color.black(), Color.white()]
    ]
    assert pattern == expected_pattern
  end

  test "generate_fractal_pattern generates pattern with correct dimensions" do
    pattern = PatternPlotter.generate_fractal_pattern(4, 4)
    assert length(pattern) == 4
    assert Enum.all?(pattern, fn row -> length(row) == 4 end)
  end

  test "generate_stripes generates correct pattern" do
    pattern = PatternPlotter.generate_stripes(4, 4)
    expected_pattern = [
      [Color.black(), Color.black(), Color.white(), Color.white()],
      [Color.black(), Color.black(), Color.white(), Color.white()],
      [Color.black(), Color.black(), Color.white(), Color.white()],
      [Color.black(), Color.black(), Color.white(), Color.white()]
    ]
    assert pattern == expected_pattern
  end

  test "generate_default_pattern generates pattern with correct dimensions" do
    pattern = PatternPlotter.generate_default_pattern(4, 4)
    assert length(pattern) == 4
    assert Enum.all?(pattern, fn row -> length(row) == 4 end)
  end

  test "plot_pattern correctly plots checkerboard pattern on canvas" do
    pattern = PatternPlotter.generate_checkerboard(4, 4)
    canvas = Canvas.new(4, 4)
    PatternPlotter.plot_pattern(4, 4, :checkerboard)

    Enum.each(0..3, fn y ->
      Enum.each(0..3, fn x ->
        color = pattern |> Enum.at(y) |> Enum.at(x)
        assert Canvas.pixel_color(canvas, {x, y}) == color
      end)
    end)
  end
end
