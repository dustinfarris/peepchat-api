defmodule Peepchat.UserTest do
  use Peepchat.ModelCase

  alias Peepchat.User

  @valid_attrs %{
    email: "mike@example.com",
    password: "abcde12345",
    password_confirmation: "abcde12345"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "mis-matched password_confirmation doesn't work" do
    attrs = %{@valid_attrs | password_confirmation: "wrongwrongwrong"}
    changeset = User.changeset(%User{}, attrs)
    refute changeset.valid?
  end

  test "short password doesn't match" do
    attrs = %{@valid_attrs | password: "short", password_confirmation: "short"}
    changeset = User.changeset(%User{}, attrs)
    refute changeset.valid?
  end
end
