defmodule ContractorWeb.Schema.ContractTypes do
  use Absinthe.Schema.Notation

  @desc "A Users Contract"
  object :contract do
    field :id, :id
    field :cost, :float
    field :end_date, :date
    field :person_id, :id
    field :vendor_id, :id
    field :category_id, :id
  end

  @desc "A Contract Vendor"
  object :vendor do
    field :id, :string
    field :name, :string
  end

  @desc "A Contract Category"
  object :category do
    field :id, :id
    field :vendor_id, :id
    field :name, :string
  end

  @desc "A Contract Input Object"
  input_object :contract_input do
    field :vendor_id, non_null(:id)
    field :person_id, non_null(:id)
    field :category_id, non_null(:id)
    field :cost, non_null(:float)
    field :end_date, non_null(:date)
  end
end
