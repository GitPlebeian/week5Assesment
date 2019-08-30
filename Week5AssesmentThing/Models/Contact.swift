//
//  Contact.swift
//  Week5AssesmentThing
//
//  Created by Jackson Tubbs on 8/30/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import Foundation
import CloudKit

struct ContactConstants {
    static let recordTypeKey = "Contact"
    fileprivate static let recordNameKey = "name"
    fileprivate static let recordPhoneNumberKey = "phoneNumber"
    fileprivate static let recordEmailKey = "email"
}

class Contact {
    
    var name: String
    var phoneNumber: String?
    var email: String?
    
    let recordID: CKRecord.ID

    init(name: String, phoneNumber: String?, email: String?, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.recordID = recordID
    }
}

extension Contact {
    convenience init?(record: CKRecord) {
        guard let name = record[ContactConstants.recordNameKey] as? String else {return nil}
        let phoneNumber = record[ContactConstants.recordPhoneNumberKey] as? String
        let email = record[ContactConstants.recordEmailKey] as? String
        
        self.init(name: name, phoneNumber: phoneNumber, email: email, recordID: record.recordID)
    }
}

extension CKRecord {
    convenience init(contact: Contact) {
        self.init(recordType: ContactConstants.recordTypeKey, recordID: contact.recordID)
        self.setValue(contact.name, forKey: ContactConstants.recordNameKey)
        self.setValue(contact.phoneNumber, forKey: ContactConstants.recordPhoneNumberKey)
        self.setValue(contact.email, forKey: ContactConstants.recordEmailKey)
    }
}
