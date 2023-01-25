defmodule Convexhull do

  import ElixirMath
  import Stack

  def find_lowestleftmost_point(points) do
    Enum.min(points, &is_first_one_lowest/2)
  end

  def is_first_one_lowest({x1, y1}, {x2, y2}) do
    cond do
      y1 < y2 -> true
      y1 > y2 -> false
      true -> x1 < x2
    end
  end

  def angle({x1, y1}, {x2, y2}) do
    ElixirMath.atan2((y2 - y1), (x2 - x1))
  end

  def compare_angles(ref, p1, p2) do
    angle(ref, p1) <= angle(ref, p2)
  end

  def sort_points(points) do
    lowest = points
      |> find_lowestleftmost_point
    points
      |> Enum.filter(&(&1 != lowest))
      |> Enum.sort(&(compare_angles(lowest, &1, &2)))
      |> filter_colinear(lowest)
      |> List.insert_at(0, lowest)
  end

  def filter_colinear([{x1, y1} = p1, {x2, y2} = p2 | rest], {refx, refy} = ref) do
    if (y1 - refy) * (x2 - refx) == (y2 - refy) * (x1 - refx) do
      if abs(x1-refx) + abs(y1 - refy) < abs(x2 - refx) + abs(y2 - refy) do
        filter_colinear([p2 | rest], ref)
      else
        filter_colinear([p1 | rest], ref)
      end
    else
      [p1 | filter_colinear([p2 | rest], ref)]
    end
  end
  def filter_colinear(points, _), do: points

  def convexhull(points) do
    points
    |> sort_points
    |> Enum.reduce(empty(), &step/2)
  end

  def step(p, st) do
    if larger_than_1(st) && ccw(next_to_top(st), top(st), p) <= 0 do
      step(p, pop(st))
    else
      push(st, p)
    end
  end

  def ccw({x1, y1}, {x2, y2}, {x3, y3}) do
    (x2 - x1) * (y3 - y1) - (y2 - y1) * (x3 - x1)
  end

  def perimeter([p0|points] = all) do
    # Enum.reduce(points, {p0, distance(p0, List.last(points))},
    #   fn p, {pant, d} -> {p, d + distance(pant, p)} end)
    #   |> elem(1)

    (Enum.zip_with(all, points, &distance/2)
    |> Enum.sum) + distance(p0, List.last(points))
  end

  def distance({x1, y1}, {x2, y2}) do
    sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
  end
      
end
