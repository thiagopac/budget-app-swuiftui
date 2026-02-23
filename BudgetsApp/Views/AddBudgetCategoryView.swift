//
//  AddBudgetCategoryView.swift
//  BudgetsApp
//
//  Created by Thiago Castro on 19/02/26.
//


import SwiftUI

struct AddBudgetCategoryView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.dismiss) private var dismiss
    
    private var budgetCategory: BudgetCategory? = nil
    
    init(budgetCategory: BudgetCategory? = nil) {
        self.budgetCategory = budgetCategory
    }
    
    @State private var title: String = ""
    @State private var total: Double = 0
    @State private var messages: [String] = []
    
    var isFormValid: Bool {
        
        messages.removeAll()
        
        if title.isEmpty {
            messages.append("The title is required")
        }
        
        if total <= 0 {
            messages.append("Total should be greater than 0")
        }
        
        return messages.count == 0
    }
    
    private func saveOrUpdate() {
        
        if let budgetCategory {
            let found = BudgetCategory.byId(budgetCategory.objectID)
            found.title = title
            found.total = total
        } else {
            let budgetCategory = BudgetCategory(context: viewContext)
            budgetCategory.title = title
            budgetCategory.total = total
        }
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                Slider(value: $total, in: 0...500, step: 50) {
                    Text("Total")
                } minimumValueLabel: {
                    Text("$\(0)")
                } maximumValueLabel: {
                    Text("$\(500)")
                }
                
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ForEach(messages, id: \.self) { message in
                    Text(message)
                        .foregroundStyle(.red)
                }
                
            }
            .onAppear {
                if let budgetCategory {
                    title = budgetCategory.title ?? ""
                    total = budgetCategory.total
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if isFormValid {
                            saveOrUpdate()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddBudgetCategoryView()
}
