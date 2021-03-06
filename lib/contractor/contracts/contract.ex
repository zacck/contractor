defmodule Contractor.Contracts.Contract do
  @moduledoc """
  Module to handle Contract Records on the system
  Use this module to create and Validate changesets
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Contractor.{
    Accounts.Person,
    Contracts.Category,
    Contracts.Contract,
    Contracts.Vendor
  }

  @type t :: %__MODULE__{}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "contracts" do
    field(:cost, :float)
    field(:end_date, :date)
    timestamps(inserted_at: :created_at, updated_at: :updated_at)
    belongs_to(:person, Person, foreign_key: :person_id, type: :binary_id)
    belongs_to(:vendor, Vendor, foreign_key: :vendor_id, type: :binary_id)
    belongs_to(:category, Category, foreign_key: :category_id, type: :binary_id)
  end

  @spec create_changeset(Person.t(), Vendor.t(), Category.t(), map) :: Ecto.Changeset.t()
  def create_changeset(%Person{} = person, %Vendor{} = vendor, %Category{} = category, attrs) do
    %Contract{}
    |> cast(attrs, [:cost, :end_date])
    |> validate_required([:cost, :end_date])
    |> validate_number(:cost, greater_than: 0)
    |> validate_future_date(:end_date)
    |> put_assoc(:person, person)
    |> put_assoc(:vendor, vendor)
    |> put_assoc(:category, category)
  end

  @spec update_changeset(Contract.t(), Vendor.t(), Category.t(), map) :: Ecto.Changeset.t()
  def update_changeset(%Contract{} = contract, %Vendor{} = vendor, %Category{} = category, attrs) do
    contract
    |> cast(attrs, [:cost, :end_date])
    |> validate_required([:cost, :end_date])
    |> validate_number(:cost, greater_than: 0)
    |> validate_future_date(:end_date)
    |> put_change(:vendor_id, vendor.id)
    |> put_change(:category_id, category.id)
  end

  @spec validate_future_date(Ecto.Changeset.t(), atom(), list()) :: Ecto.Changeset.t()
  def validate_future_date(changeset, field, opts \\ []) do
    validate_change(changeset, field, fn _, end_date ->
      case Date.compare(end_date, Date.utc_today()) do
        :gt -> []
        :lt -> [{field, opts[:message] || "end_date has to be later than today"}]
      end
    end)
  end
end
