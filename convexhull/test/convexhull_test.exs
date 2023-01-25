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
  
  test "convex hull" do
    assert Convexhull.convexhull([
     {1, 1},
     {2, 5},
     {3, 3},
     {5, 3},
     {3, 2},
     {2, 2}
    ]) == [
     {2, 5},
     {5, 3},
     {1, 1}
    ]
  end

  test "perimeter" do
    assert abs(Convexhull.perimeter([
     {2, 5},
     {5, 3},
     {1, 1}
    ]) - 12.20079) < 0.00001
  end

end
