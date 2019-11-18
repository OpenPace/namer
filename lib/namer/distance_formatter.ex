defmodule Namer.DistanceFormatter do
  @moduledoc """
  This module formats the distance
  """

  @mile_in_meters 1_609 # 1 mile == 1609 meters

  def mile_in_meters, do: @mile_in_meters

  def to_float(distance, [imperial: true]), do: round_distance(distance / mile_in_meters())
  def to_float(distance, [imperial: _]), do: round_distance(distance / 1_000)

  def format(distance, opts), do: "#{to_float(distance, opts)} #{label(opts)}"
  def format(distance), do: format(distance, imperial: false)

  def label([imperial: true]), do: "mi"
  def label([imperial: _]), do: "km"

  defp round_distance(num), do: Float.round(num, 2)
end
