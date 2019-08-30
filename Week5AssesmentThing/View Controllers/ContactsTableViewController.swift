//
//  ContactsTableViewController.swift
//  Week5AssesmentThing
//
//  Created by Jackson Tubbs on 8/30/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 115
        fetchContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Custom Functions
    
    func fetchContacts() {
        ContactController.shared.fetchAllContacts { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactController.shared.contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell else {return UITableViewCell()}
        
        let contact = ContactController.shared.contacts[indexPath.row]
        cell.contact = contact

        return cell
    }
    // MARK: - Navigation
    
    //NOT DONE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContactDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? ContactDetailViewController else {return}
            
            let contact = ContactController.shared.contacts[indexPath.row]
            destinationVC.contact = contact
        }
    }
}
