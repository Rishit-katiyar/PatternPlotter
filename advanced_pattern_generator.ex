
defmodule AdvancedPatternGenerator do
  alias Gaz.{Canvas, Color}

  # Function to generate and plot a repeating geometric pattern
  #
  # Parameters:
  #   - width: The width of the pattern canvas
  #   - height: The height of the pattern canvas
  #   - pattern_type: The type of pattern to generate (:checkerboard, :fractal, :stripes, etc.)
  #   - foreground_color: The color of the foreground elements in the pattern (optional, default: :black)
  #   - background_color: The color of the background elements in the pattern (optional, default: :white)
  #
  # Returns: :ok | {:error, reason}
  def plot_pattern(width, height, pattern_type, foreground_color \\ :black, background_color \\ :white)
      when is_integer(width) and is_integer(height) and is_atom(pattern_type) and is_atom(foreground_color) and is_atom(background_color) do
    case generate_pattern(width, height, pattern_type, foreground_color, background_color) do
      {:ok, pattern} ->
        canvas = Canvas.new(width, height)
        Enum.each(0..height-1, fn y ->
          Enum.each(0..width-1, fn x ->
            color = pattern |> List.keyfind({x, y}, 0)
            Canvas.pixel(canvas, {x, y}, color)
          end)
        end)
        Canvas.display(canvas)
        :ok
      {:error, reason} ->
        {:error, reason}
    end
  end

  # Function to generate a repeating geometric pattern
  defp generate_pattern(width, height, pattern_type, foreground_color, background_color) do
    case pattern_type do
      :checkerboard ->
        generate_checkerboard(width, height, foreground_color, background_color)
      :fractal ->
        generate_fractal_pattern(width, height, foreground_color, background_color)
      :stripes ->
        generate_stripes(width, height, foreground_color, background_color)
      _ ->
        {:error, "Unsupported pattern type"}
    end
  end

  # Function to generate a checkerboard pattern
  defp generate_checkerboard(width, height, foreground_color, background_color) do
    checkerboard = for i <- 0..height-1, do: for j <- 0..width-1, do: (i + j) |> rem(2)
    Enum.map(checkerboard, &(if &1 == 0, do: foreground_color, else: background_color))
    |> Enum.map(&convert_color/1)
  end

  # Function to generate a fractal pattern
  defp generate_fractal_pattern(width, height, foreground_color, background_color) do
    # Implement fractal pattern generation algorithm here
    # For now, generate a random fractal pattern
    fractal = for _ <- 1..height, do: for _ <- 1..width, do: if :rand.uniform() < 0.5, do: foreground_color, else: background_color
    Enum.to_list(fractal)
  end

  # Function to generate a stripes pattern
  defp generate_stripes(width, height, foreground_color, background_color) do
    stripe_width = div(width, 10) # Adjust the stripe width according to the pattern size
    stripes = for _ <- 1..height, do: Enum.map(1..width, fn(i) -> if rem(i, stripe_width) < div(stripe_width, 2), do: foreground_color, else: background_color end)
    Enum.to_list(stripes)
  end

  # Function to convert color atoms to Color structs
  defp convert_color(:black), do: Color.black()
  defp convert_color(:white), do: Color.white()
  defp convert_color(color), do: raise ArgumentError, "Unsupported color: #{inspect color}"
end

# Example usage:
width = 300
height = 300
pattern_type = :checkerboard

AdvancedPatternGenerator.plot_pattern(width, height, pattern_type)
