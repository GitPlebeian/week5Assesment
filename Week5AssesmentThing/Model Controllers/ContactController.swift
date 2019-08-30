//
//  Contact Controller.swift
//  Week5AssesmentThing
//
//  Created by Jackson Tubbs on 8/30/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    static let shared = ContactController()
    
    var contacts: [Contact] = []
    
    // MARK: - CRUD
    
    func createContact(name: String, email: String?, phoneNumber: String?, completion: @escaping (Bool) -> Void) {
        let contact = Contact(name: name, phoneNumber: phoneNumber, email: email)
        let record = CKRecord(contact: contact)
        publicDB.save(record) { (record, error) in
            if let error = error {
                print("Error at: \(#function)\nError: \(error)\nSmall Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let record = record, let contact = Contact(record: record) else {completion(false); return}
            self.contacts.append(contact)
            completion(true)
        }
    }
    
    func fetchAllContacts(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: ContactConstants.recordTypeKey, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error at: \(#function)\nError: \(error)\nSmall Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let records = records else {completion(false); return}
            let contacts = records.compactMap({Contact(record: $0)})
            self.contacts = contacts
            completion(true)
        }
    }
    
    func updateContact(contact: Contact, completion: @escaping (Bool) -> Void) {
        let modificationOP = CKModifyRecordsOperation(recordsToSave: [CKRecord(contact: contact)], recordIDsToDelete: nil)
        modificationOP.savePolicy = .changedKeys
        modificationOP.queuePriority = .veryHigh
        modificationOP.qualityOfService = .userInteractive
        
        modificationOP.modifyRecordsCompletionBlock = { (_, _, error) in
            if let error = error {
                print("Error at: \(#function)\nError: \(error)\nSmall Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        }
        publicDB.add(modificationOP)
    }
}
