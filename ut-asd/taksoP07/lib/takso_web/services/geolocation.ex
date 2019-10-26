defmodule Takso.Geolocation do

  def distance(origin, destination) do
    [o1, o2] = find_location(origin)
    [d1, d2] = find_location(destination)
    uri = "https://dev.virtualearth.net/REST/v1/Routes/DistanceMatrix?origins=#{o1},#{o2}&destinations=#{d1},#{d2}&travelMode=driving&key=#{get_key()}"
    response = HTTPoison.get! uri
    matches = Regex.named_captures(~r/travelD\D+(?<dist>\d+\.\d+)\D+(?<dur>\d+\.\d+)/,response.body)
    [{v1, _}, {v2, _}] = [matches["dist"] |> Float.parse, matches["dur"] |> Float.parse]
    [v1, v2]
 end

  def find_location(address) do
    uri = "http://dev.virtualearth.net/REST/v1/Locations?q=1#{URI.encode(address)}%&key=#{get_key()}"
    response = HTTPoison.get! uri
    matches = Regex.named_captures(~r/coordinates\D+(?<lat>-?\d+.\d+)\D+(?<long>-?\d+.\d+)/, response.body)
    [{v1, _}, {v2, _}] = [matches["lat"] |> Float.parse, matches["long"] |> Float.parse]
    [v1, v2]
  end

  defp get_key(), do: "AusWHdnv29I8PARcZHTJyqdGsS-Q2OI4Gbngmq5dcoYGI9A97mjWWoeOIenKQYAf"
end
