defmodule Contractor.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :token, :string
      add :hash, :string
      add :email, :string

      timestamps(inserted_at: :joined_on, updated_at: :updated_on)
    end

    create unique_index(:people, [:email])
  end
end
