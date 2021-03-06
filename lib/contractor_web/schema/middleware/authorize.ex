defmodule ContractorWeb.Schema.Middleware.Authorize do
  @moduledoc """
  This module contains middleware that runs before any
  resolvers thay need authentication  
  """
  @behaviour Absinthe.Middleware

  @spec call(map(), map()) :: map()
  def call(resolution, role) do
    with %{current_user: current_user} <- resolution.context,
         true <- correct_role?(current_user, role) do
      resolution
    else
      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "unathorized"})
    end
  end

  defp correct_role?(%{}, :any), do: true
  defp correct_role?(%{}, _), do: false
end
