# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rockelivery.Repo.insert!(%Rockelivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rockelivery.{Item, Order, Repo, User}

user = %User{
  age: 27,
  address: "Rua das Bananeiras, 15",
  cep: "12345678",
  cpf: "12345678991",
  email: "mauricio@teste1.com",
  password: "123456",
  name: "Maurício Rinardo"
}

%User{id: user_id} = Repo.insert!(user)

item1_data = %Item{
  category: :food,
  description: "Fígado acebolado",
  price: Decimal.new("15.80"),
  photo: "priv/photos/figado_acebolado.png"
}

item2_data = %Item{
  category: :food,
  description: "Feijoada completa",
  price: Decimal.new("25.50"),
  photo: "priv/photos/feijoada_completa.png"
}

item1 = Repo.insert!(item1_data)
item2 = Repo.insert!(item2_data)

order = %Order{
  user_id: user_id,
  items: [item1, item1, item2],
  address: "Rua das Bananeiras, 15",
  comments: "fígado ao ponto",
  payment_method: :money
}

Repo.insert!(order)
