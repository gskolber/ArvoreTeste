# How to run

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

# Desafio Arvore - Desenvolvedor Elixir JR.
Níveis Estagiário e Júnior

Deploy em: https://challenge-arvore.herokuapp.com/
Documentação em: https://challenge-arvore.herokuapp.com/api/swagger/index.html#/


# Objetivo:
Construir uma API usando Phoenix (elixir) e banco de dados MySQL visando permitir a um parceiro da Árvore replicar a sua estrutura de Redes, Escolas, Turmas e administrá-la conforme necessário. 

A modelagem deverá utilizar apenas uma entidade (Entity), que poderá representar qualquer nível da estrutura hierárquica.

# Tipos:

As entidades serão identificadas pelos seguintes tipos:

Network - é o mais alto nível permitido para criação de entidades, representando uma rede de escolas - Não é um nível obrigatório;
School - representa uma escola, podendo ou não estar relacionada a uma rede;
Class - representa uma turma e deve obrigatoriamente ser relacionado a uma escola.


# Atributos:

name:  nome;
entity_type: tipo da entidade;
inep: código INEP, usado apenas para entity_type com valor school.
parent_id: identificador da entidade antecessora na hierarquia.

A entidade mais alta da hierarquia (network ou school), terá parent_id nulo.

# Alguns exemplos de requisições e retornos esperados seguem a seguir.


## Criação de uma entidade:

No exemplo abaixo uma escola sem um antecessor hierárquico está sendo criado.

*Request*:
POST /api/v2/partners/entities

*Headers*:
Content-Type:application/json

Body:

`{
  "name": "Escola Exemplo",
  "entity_type": "school",
  "inep": "123456",
  "parent_id": null
}`

*Response*:

*Headers*:
Content-Type:application/json; charset=utf-8

Body:



`{
  "data": {
    "id": 2,
    "entity_type": "school",
    "inep": "123456",
    "name": "Escola Exemplo",
    "parent_id": null,
    "subtree_ids": []
  }
}`

> A chave subtree_ids deverá trazer uma lista com os IDs de todas as entidades relacionadas à entidade retornada. 

## Exibição de uma entidade:

*Request*

GET /api/v2/partners/entities/id-da-entidade

*Headers:*
Content-Type:application/json

**Parameters**:
id: integer - ex: 2

*Response*

*Headers*:
Content-Type:application/json; charset=utf-8

Body:

`{
  "data": {
    "id": 2,
    "entity_type": "school",
    "inep": "123456",
    "name": "Escola Exemplo",
    "parent_id": null,
    "subtree_ids": [3, 4]
  }
}`

## Edição de uma entidade:

*Request:*
PUT /api/v2/partners/entities/id-da-entidade

*Headers:*
Content-Type:application/json

**Parameters**:
id: integer - ex: 2

Body:

`{
  "name": "Escola Exemplo",
  "entity_type": "school",
  "inep": "789123",
  "parent_id": null
}`

*Response*:

*Headers:*
Content-Type:application/json; charset=utf-8

Body:

`{
  "data": {
    "id": 2,
    "entity_type": "school",
    "inep": "789123",
    "name": "Escola Exemplo",
    "parent_id": null,
    "subtree_ids": [3, 4]
  }
}`


Requisitos mínimos:
- Documentação do repositório git
- Histórico de commits
- Testes unitários

Requisitos desejáveis:
- Deploy em qualquer serviço para consumo durante avaliação


