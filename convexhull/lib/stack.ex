defmodule Stack do
  def empty, do: []

  def push(st, elem), do: [elem|st]

  def top([t|_]), do: t

  def next_to_top([_, nt|_]), do: nt

  def pop([_|st]), do: st

  def larger_than_1([_,_|_]), do: true
  def larger_than_1(_), do: false
end
