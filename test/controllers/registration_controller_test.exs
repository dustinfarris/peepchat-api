defmodule Peepchat.RegistrationControllerTest do
  use Peepchat.ConnCase

  alias Peepchat.User

  @valid_attrs %{
    "email" => "mike@example.com",
    "password" => "abcdefg12345",
    "password-confirmation" => "abcdefg12345"
  }

  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    data = %{data: %{type: "users", attributes: @valid_attrs}}

    conn = post conn, registration_path(conn, :create), data

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(User, %{email: @valid_attrs["email"]})
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    data = %{data: %{type: "users", attributes: @invalid_attrs}}

    assert_error_sent 400, fn ->
      post conn, registration_path(conn, :create), data
    end
  end
end
