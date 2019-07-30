defmodule WhiteBreadContext do
    use WhiteBread.Context
    use Hound.Helpers
    
    feature_starting_state fn  ->
      Application.ensure_all_started(:hound)
      %{}
    end
    scenario_starting_state fn _state ->
      Hound.start_session
      %{}
    end
    scenario_finalize fn _status, _state -> 
    #   Hound.end_session
        nil
    end
  
    # The skeleton of the steps would be here
  end
  
  

# given_ ~r/^the following taxis are on duty$/, fn state ->
#     {:ok, state}
# end

# and_ ~r/^I want to go from "(?<pickup_address>[^"]+)" to "(?<dropoff_address>[^"]+)"$/,
# fn state, %{pickup_address: pickup_address, dropoff_address: dropoff_address} ->
#     {:ok, state |> Map.put(:pickup_address, pickup_address) |> Map.put(:dropoff_address, dropoff_address)}
# end

# and_ ~r/^I open STRS' web page$/, fn state ->
#     navigate_to "/bookings/new"
#     {:ok, state}
# end

