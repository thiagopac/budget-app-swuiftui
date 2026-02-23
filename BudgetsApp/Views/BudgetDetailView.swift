//
//  BudgetDetailView.swift
//  BudgetsApp
//
//  Created by Thiago Castro on 20/02/26.
//


import SwiftUI
import CoreData

struct BudgetDetailView: View {
    
    let budgetCategory: BudgetCategory
    
    @State private var title: String = ""
    @State private var total: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var isTitleFocused: Bool
    @FocusState private var isTotalFocused: Bool
    
    private var isFormValid: Bool {
        
        guard let totalAsDouble:Double = Double(total) else { return false }
        return !title.isEmpty && !total.isEmpty && totalAsDouble > 0
    }
    
    private func saveTransaction() {
        
        let transaction = Transaction(context: viewContext)
        transaction.title = title
        transaction.total = Double(total)!
        budgetCategory.addToTransactions(transaction)
        
        do {
            try viewContext.save()
            
            isTotalFocused = false
            
            title = ""
            total = ""
            
            isTitleFocused = true
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private func deleteTransaction(_ transaction: Transaction) -> Void {
        viewContext.delete(transaction)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(budgetCategory.title ?? "-")
                        .font(.largeTitle)
                    Text("Budget: \(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)")
                        .fontWeight(.bold)
                }
            }.padding(20)
            
            Form {
                Section {
                    TextField("Title", text: $title)
                        .focused($isTitleFocused)
                    TextField("Total", text: $total)
                        .focused($isTotalFocused)
                } header: {
                    Text("Add Transaction")
                }
                
                HStack {
                    Spacer()
                    Button("Save Transaction") {
                        saveTransaction()
                    }.disabled(!isFormValid)
                    Spacer()
                }
                

            }.frame(maxHeight: 280)
                .padding([.bottom], 20)
            
            VStack {
                BudgetSummaryView(budgetCategory: budgetCategory)
                
                TransactionListView(request: BudgetCategory.transactionsByCategoryRequest(budgetCategory), onDeleteTransaction: deleteTransaction)
            }
            
            Spacer()
        }
    }
}

#Preview {
    BudgetDetailView(budgetCategory: BudgetCategory())
}
