# BudgetsApp

`BudgetsApp` is a simple iOS app built with SwiftUI for budget tracking by category, with local persistence using Core Data.

## Purpose

This repository is a compact practical reference to learn:

- SwiftUI + Core Data integration
- Using `@FetchRequest` to display persisted data
- Entity relationships (`BudgetCategory` -> `Transaction`)
- State-driven UI updates

## What this app does

- Creates budget categories with title and total amount
- Lists categories with total and remaining balance
- Edits a category (long press on a row)
- Deletes a category
- Opens category details to add transactions
- Lists and deletes transactions
- Shows a summary with **Remaining** or **Overspent** status

## Main structure

- `BudgetsApp/BudgetsAppApp.swift`: app entry point and Core Data context injection
- `BudgetsApp/Managers/CoreDataManager.swift`: Core Data stack (`NSPersistentContainer`)
- `BudgetsApp/Models/`: `BudgetCategory` and `Transaction` entities
- `BudgetsApp/Views/`: list, form, and detail screens

## Data model (Core Data)

- `BudgetCategory`
  - `title`
  - `total`
  - `dateCreated`
  - relationship to many `Transaction` items
- `Transaction`
  - `title`
  - `total`
  - `dateCreated`
  - relationship to one `BudgetCategory`

## How to run

1. Open `BudgetsApp.xcodeproj` in Xcode.
2. Select an iOS simulator.
3. Run the project with `Cmd + R`.

## Stack

- Swift
- SwiftUI
- Core Data

## Note

All data is local (this project does not use API calls).
