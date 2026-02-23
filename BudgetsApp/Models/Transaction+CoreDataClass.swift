//
//  Transaction+CoreDataClass.swift
//  BudgetsApp
//
//  Created by Thiago Castro on 19/02/26.
//


import Foundation
import CoreData

@objc(Transaction)
public class Transaction: NSManagedObject {
 
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
}
