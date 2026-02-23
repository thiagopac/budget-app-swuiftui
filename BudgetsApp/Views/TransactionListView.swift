//
//  TransactionListView.swift
//  BudgetsApp
//
//  Created by Thiago Castro on 20/02/26.
//


import SwiftUI
import CoreData

struct TransactionListView: View {
    
    @FetchRequest var transactions: FetchedResults<Transaction>
    
    let onDeleteTransaction: (Transaction) -> Void
    
    init(request: NSFetchRequest<Transaction>, onDeleteTransaction: @escaping (Transaction) -> Void) {
        _transactions = FetchRequest(fetchRequest: request)
        self.onDeleteTransaction = onDeleteTransaction
    }
    
    var body: some View {
        
        if transactions.isEmpty {
            Text("No transactions yet")
        } else {
            List {
                ForEach(transactions) { transaction in
                    HStack {
                        Text(transaction.title ?? "-")
                        Spacer()
                        Text(transaction.total as NSNumber, formatter: NumberFormatter.currency)
                    }
                }.onDelete { offsets in
                    offsets.map { transactions[$0] }.forEach(onDeleteTransaction)
                }
            }
        }
    }
}
