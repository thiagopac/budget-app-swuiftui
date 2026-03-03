# BudgetsApp

`BudgetsApp` é um app iOS simples em SwiftUI para controle de orçamento por categorias, com persistência local usando Core Data.

## Objetivo

Este projeto serve como referência prática e enxuta para aprender:

- Integração de SwiftUI com Core Data
- Uso de `@FetchRequest` para listar dados persistidos
- Relacionamento entre entidades (`BudgetCategory` -> `Transaction`)
- Atualização de UI orientada a estado

## O que o app faz

- Cria categorias de orçamento com título e valor total
- Lista categorias com valor total e saldo restante
- Permite editar categoria (toque longo na célula)
- Permite excluir categoria
- Abre detalhes da categoria para adicionar transações
- Lista e exclui transações
- Mostra resumo com status **Remaining** ou **Overspent**

## Estrutura principal

- `BudgetsApp/BudgetsAppApp.swift`: inicialização do app e injeção do contexto Core Data
- `BudgetsApp/Managers/CoreDataManager.swift`: stack do Core Data (`NSPersistentContainer`)
- `BudgetsApp/Models/`: entidades `BudgetCategory` e `Transaction`
- `BudgetsApp/Views/`: telas de listagem, formulário e detalhe

## Modelo de dados (Core Data)

- `BudgetCategory`
  - `title`
  - `total`
  - `dateCreated`
  - relacionamento com várias `Transaction`
- `Transaction`
  - `title`
  - `total`
  - `dateCreated`
  - relacionamento com uma `BudgetCategory`

## Como executar

1. Abra `BudgetsApp.xcodeproj` no Xcode.
2. Selecione um simulador iOS.
3. Rode o projeto com `Cmd + R`.

## Stack

- Swift
- SwiftUI
- Core Data

## Observação

Todos os dados são locais (não há chamadas de API neste projeto).
