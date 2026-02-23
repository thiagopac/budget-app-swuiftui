//
//  ContentView.swift
//  BudgetsApp
//
//  Created by Thiago Castro on 19/02/26.
//


import SwiftUI

enum SheetAction: Identifiable {
    
    var id: UUID {
        UUID()
    }
    
    case add
    case edit(BudgetCategory)
}

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: BudgetCategory.all) private var budgetCategoryResults: FetchedResults<BudgetCategory>
    
    
    @State private var sheetAction: SheetAction?
    
    var total: Double {
        budgetCategoryResults.reduce(0) { partialResult, budgetCategory in
            return partialResult + budgetCategory.total
        }
    }
    
    private func deleteBudgetCategory(budgetCategory: BudgetCategory) {
        viewContext.delete(budgetCategory)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    private func editBudgetCategory(budgetCategory: BudgetCategory) {
        sheetAction = .edit(budgetCategory)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                HStack {
                    Text("Total Budget - ")
                    Text(total as NSNumber, formatter: NumberFormatter.currency)
                        .fontWeight(.bold)
                }
                
                BudgetListView(budgetCategoryResults: budgetCategoryResults, onDeleteBudgetCategory: deleteBudgetCategory, onEditBudgetCategory: editBudgetCategory)
            }.toolbar {
                ToolbarItem {
                    Button("Add Category") {
                        sheetAction = .add
                    }
                }
            }
            .sheet(item: $sheetAction) { sheetAction in
                switch sheetAction {
                case .add:
                    AddBudgetCategoryView()
                case .edit(let budgetCategory):
                    AddBudgetCategoryView(budgetCategory: budgetCategory)
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
}
