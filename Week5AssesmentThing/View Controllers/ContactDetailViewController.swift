//
//  ContactDetailViewController.swift
//  Week5AssesmentThing
//
//  Created by Jackson Tubbs on 8/30/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - Properties
    
    var contact: Contact? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Custom Funcions
    
    func updateViews() {
        loadViewIfNeeded()
        guard let contact = contact else {return}
        self.title = contact.name
        nameTextField.text = contact.name
        if let phoneNumber = contact.phoneNumber {
            phoneNumberTextField.text = phoneNumber
        }
        if let email = contact.email {
            emailTextField.text = email
        }
    }
    
    // MARK: - Actions
    
    @IBAction func saveContactButtonTapped(_ sender: Any) {
        guard let nameText = nameTextField.text,
        !nameText.isEmpty else {return}
        if let contact = contact {
            contact.name = nameText
            contact.phoneNumber = phoneNumberTextField.text
            contact.email = emailTextField.text
            ContactController.shared.updateContact(contact: contact) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        } else {
            ContactController.shared.createContact(name: nameText, email: emailTextField.text, phoneNumber: phoneNumberTextField.text) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        nameTextField.text = ""
        phoneNumberTextField.text = ""
        emailTextField.text = ""
    }
    
}
