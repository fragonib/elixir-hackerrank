defmodule ConvexhullTest do
  use ExUnit.Case
  doctest Convexhull

  test "sorting" do
    assert Convexhull.sort_points([
     {1, 1},
     {2, 5},
     {3, 3},
     {5, 3},
     {3, 2},
     {2, 2}
    ]) == [
     {1, 1},
     {5, 3},
     {3, 3},
     {2, 5}
    ]
  end

end
