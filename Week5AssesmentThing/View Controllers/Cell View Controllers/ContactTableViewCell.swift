//
//  ContactTableViewCell.swift
//  Week5AssesmentThing
//
//  Created by Jackson Tubbs on 8/30/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    
    // MARK: - Properties
    
    var contact: Contact? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Custom Functions
    
    func updateViews() {
        guard let contact = contact else {return}
        contactNameLabel.text = contact.name
        if let phoneNumber = contact.phoneNumber, !phoneNumber.isEmpty {
            contactPhoneLabel.text = "Phone Number: \(phoneNumber)"
        } else {
            contactPhoneLabel.text = "Phone Number: None"
        }
        if let email = contact.email, !email.isEmpty {
            contactEmailLabel.text = "Email: \(email)"
        } else {
            contactEmailLabel.text = "Email: None"
        }
    }
}
