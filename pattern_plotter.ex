

defmodule PatternPlotter do
  # Alias the Canvas and Color modules from the Gaz library for convenience
  alias Gaz.{Canvas, Color}

  # Function to generate and plot a repeating geometric pattern
  def plot_pattern(width, height, pattern_type) when is_integer(width) and is_integer(height) do
    # Generate the pattern based on the specified width, height, and pattern type
    pattern = generate_pattern(width, height, pattern_type)

    # Create a new canvas with the specified width and height
    canvas = Canvas.new(width, height)

    # Plot each pixel of the pattern on the canvas
    Enum.each(0..height-1, fn y ->
      Enum.each(0..width-1, fn x ->
        # Find the color of the current pixel in the pattern
        color = pattern |> List.keyfind({x, y}, 0)
        # Plot the pixel on the canvas with the determined color
        Canvas.pixel(canvas, {x, y}, color)
      end)
    end)

    # Display the canvas with the plotted pattern
    Canvas.display(canvas)
  end

  # Function to generate a repeating geometric pattern based on the specified parameters
  defp generate_pattern(width, height, pattern_type) do
    # Determine which type of pattern to generate
    case pattern_type do
      :checkerboard ->
        generate_checkerboard(width, height)
      :fractal ->
        generate_fractal_pattern(width, height)
      :stripes ->
        generate_stripes(width, height)
      _ ->
        generate_default_pattern(width, height)
    end
  end

  # Function to generate a checkerboard pattern
  defp generate_checkerboard(width, height) do
    # Generate a checkerboard pattern with alternating black and white squares
    checkerboard = for i <- 0..height-1, do: for j <- 0..width-1, do: (i + j) |> rem(2)
    # Map the checkerboard pattern to colors (black or white)
    Enum.map(checkerboard, &(if &1 == 0, do: Color.white(), else: Color.black()))
  end

  # Function to generate a fractal pattern
  defp generate_fractal_pattern(width, height) do
    # Implement fractal pattern generation algorithm here
    # For now, generate a random fractal pattern
    fractal = for _ <- 1..height, do: for _ <- 1..width, do: if :rand.uniform() < 0.5, do: Color.black(), else: Color.white()
    Enum.to_list(fractal)
  end

  # Function to generate a stripes pattern
  defp generate_stripes(width, height) do
    # Determine the width of each stripe
    stripe_width = div(width, 10) # Adjust the stripe width according to the pattern size
    # Generate a stripes pattern with alternating black and white stripes
    stripes = for _ <- 1..height, do: Enum.map(1..width, fn(i) -> if rem(i, stripe_width) < div(stripe_width, 2), do: Color.black(), else: Color.white() end)
    Enum.to_list(stripes)
  end

  # Default pattern generation function
  defp generate_default_pattern(width, height) do
    # Implement a default pattern generation algorithm here
    # For now, generate a simple random pattern
    default_pattern = for _ <- 1..height, do: for _ <- 1..width, do: if :rand.uniform() < 0.5, do: Color.black(), else: Color.white()
    Enum.to_list(default_pattern)
  end
end

# Example usage:
# Define the width, height, and type of pattern to generate
width = 300
height = 300
pattern_type = :checkerboard

# Call the plot_pattern function to generate and plot the specified pattern
PatternPlotter.plot_pattern(width, height, pattern_type)
