## Elixir Driver

A simple Elixir program that test drives the Neo4j Elixir Driver.

### Driver

[bolt_sips](https://github.com/florinpatrascu/bolt_sips) (**Community Driver**)

### Setup

```bash
cd social
mix deps.get
mix run ./insert_friends.exs
mix run ./common_friends.exs
mix run ./connecting_paths.exs
mix run ./friends_of_a_friend.exs
```