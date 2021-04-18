defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      age: 35,
      address: "Rua 0",
      cep: "01234567",
      cpf: "12345678910",
      email: "mauricio@m.com.br",
      password: "123456",
      name: "Maurício"
    }
  end

  def user_factory do
    %User{
      age: 35,
      address: "Rua 0",
      cep: "01234567",
      cpf: "12345678910",
      email: "mauricio@m.com.br",
      password: "123456",
      name: "Maurício",
      id: "8bc5419c-b47d-4de2-9024-8436444f4b51"
    }
  end
end
