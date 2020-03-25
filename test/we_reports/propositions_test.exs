defmodule WeReports.PropositionsTest do
  use WeReports.DataCase

  alias WeReports.Propositions

  describe "propositions" do
    alias WeReports.Propositions.Proposition

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def proposition_fixture(attrs \\ %{}) do
      {:ok, proposition} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Propositions.create_proposition()

      proposition
    end

    test "list_propositions/0 returns all propositions" do
      proposition = proposition_fixture()
      assert Propositions.list_propositions() == [proposition]
    end

    test "get_proposition!/1 returns the proposition with given id" do
      proposition = proposition_fixture()
      assert Propositions.get_proposition!(proposition.id) == proposition
    end

    test "create_proposition/1 with valid data creates a proposition" do
      assert {:ok, %Proposition{} = proposition} = Propositions.create_proposition(@valid_attrs)
      assert proposition.description == "some description"
      assert proposition.name == "some name"
    end

    test "create_proposition/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Propositions.create_proposition(@invalid_attrs)
    end

    test "update_proposition/2 with valid data updates the proposition" do
      proposition = proposition_fixture()
      assert {:ok, %Proposition{} = proposition} = Propositions.update_proposition(proposition, @update_attrs)
      assert proposition.description == "some updated description"
      assert proposition.name == "some updated name"
    end

    test "update_proposition/2 with invalid data returns error changeset" do
      proposition = proposition_fixture()
      assert {:error, %Ecto.Changeset{}} = Propositions.update_proposition(proposition, @invalid_attrs)
      assert proposition == Propositions.get_proposition!(proposition.id)
    end

    test "delete_proposition/1 deletes the proposition" do
      proposition = proposition_fixture()
      assert {:ok, %Proposition{}} = Propositions.delete_proposition(proposition)
      assert_raise Ecto.NoResultsError, fn -> Propositions.get_proposition!(proposition.id) end
    end

    test "change_proposition/1 returns a proposition changeset" do
      proposition = proposition_fixture()
      assert %Ecto.Changeset{} = Propositions.change_proposition(proposition)
    end
  end
end
