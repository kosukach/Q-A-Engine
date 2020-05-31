defmodule QaEngine.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  require Pbkdf2
  schema "credentials" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    belongs_to :user, QaEngine.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def registration_changeset(credential, attrs \\ %{}) do
    credential
    |> changeset(attrs)
    |> cast(attrs, [:password, :password_confirmation])
    |> validate_required([:password, :password_confirmation])
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> hash_password()
  end


  def hash_password(%{valid?: false} = changeset), do: changeset

  def hash_password(%{valid?: true, changes: %{password: pass}} = changeset) do
    put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))
  end
    

end
