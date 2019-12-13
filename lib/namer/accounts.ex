defmodule Namer.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Changeset
  alias Namer.Accounts.{User, UserPrefs}
  alias Namer.Repo
  alias Strava.Auth

  @doc """
  Gets a single user by the strava user id.

  Returns nil if the User does not exist.

  ## Examples

  iex> get_user!(123)
  %User{}

  iex> get_user!(456)
  nil

  """
  def get_user_by_uid(uid) when is_integer(uid), do: get_user_by_uid("#{uid}")
  def get_user_by_uid(uid) do
    query = from u in User,
      where: u.strava_uid == ^uid
    query
    |> Repo.one()
    |> Repo.preload([:user_prefs])
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    User
    |> Repo.get!(id)
    |> Repo.preload([:user_prefs])
  end

  def refresh_token(%User{refresh_token: refresh_token} = user) do
    case Auth.get_token(grant_type: "refresh_token", refresh_token: refresh_token) do
      {:ok, client} -> update_user(user, Map.from_struct(client.token))
      _ -> :error
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{user_prefs: %{}}) do
    attrs = Map.put_new(attrs, :user_prefs, %{})

    %User{}
    |> User.changeset(attrs)
    |> Changeset.cast_assoc(:user_prefs, with: &UserPrefs.changeset/2)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Changeset.cast_assoc(:user_prefs, with: &UserPrefs.changeset/2)
    |> Repo.update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
