//
//  BudgetListView.swift
//  BudgetsApp
//
//  Created by Thiago Castro on 20/02/26.
//


import SwiftUI

struct BudgetListView: View {
    
    var budgetCategoryResults: FetchedResults<BudgetCategory>
    
    let onDeleteBudgetCategory: (BudgetCategory) -> Void
    
    let onEditBudgetCategory: (BudgetCategory) -> Void
    
    var body: some View {
        List {
            if !budgetCategoryResults.isEmpty {
                
                ForEach(budgetCategoryResults) { budgetCategory in
                    NavigationLink(value: budgetCategory) {
                        HStack {
                            Text(budgetCategory.title ?? "-")
                            Spacer()
                            VStack(alignment: .trailing, spacing: 10) {
                                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                                
                                Text("\(budgetCategory.overSpent ? "Overspent": "Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .foregroundColor(budgetCategory.overSpent ? .red : .green)
                                    .font(.caption)
                            }
                        }.onLongPressGesture {
                            onEditBudgetCategory(budgetCategory)
                        }
                    }
                }.onDelete { indexSet in
                    indexSet.map {
                        budgetCategoryResults[$0]
                    }.forEach(onDeleteBudgetCategory)
                }
                
            } else {
                Text("No budget categories yet")
            }
        }.navigationDestination(for: BudgetCategory.self) { budgetCategory in
            BudgetDetailView(budgetCategory: budgetCategory)
        }.listStyle(.plain)
    }
}
