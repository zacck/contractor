defmodule Contractor.AuthenticationTestHelpers do
  @moduledoc """
  This module contains helper functions for adding an authentication token to a conn struct
  """
  use Phoenix.ConnTest
  import Contractor.Factory

  @doc """
  when given a connection to authenticate 
  create a user call auth with the created user and conn
  """
  def authenticate(conn) do
    user = insert(:person)

    conn
    |> authenticate(user)
  end

  def authenticate(conn, user) do
    # get the token for the user
    {:ok, token, _} = user |> Contractor.Auth.Guardian.encode_and_sign()

    # add the users token to the request header
    conn
    |> put_req_header("authorization", "Bearer #{token}")
  end
end
