//
//  ViewController.swift
//  Contacts
//
//  Created by Angel Avila on 12/19/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class ViewController: GenericTableViewController<ContactCell, Contact> {

    let contacts = [Contact(firstName: "Ángel", lastName: "Ávila", dateOfBirth: "", addresses: [""], phoneNumbers: ["3313610519", "555555555"], emails: ["aangel.aac96@gmail.com", "is697755@iteso.mx", "test@test.com"]),
                    Contact(firstName: "Marcel", lastName: "Castiello"),
                    Contact(firstName: "Sandy", lastName: "Matthew")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = contacts
        setupNavigationItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Contacts"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = items[indexPath.row]
        let contactDetailsVC = ContactDetailsVC(contact: contact, viewController: self, isAddingAContact: false)
        contactDetailsVC.title = contact.firstName + " " + contact.lastName
        let nc = UINavigationController(rootViewController: contactDetailsVC)
        nc.navigationBar.prefersLargeTitles = true
        present(nc, animated: true, completion: nil)
    }
    
    @objc fileprivate func addButtonTapped() {
        let contact = Contact(firstName: "", lastName: "")
        let contactDetailsVC = ContactDetailsVC(contact: contact, viewController: self, isAddingAContact: true)
        contactDetailsVC.title = "New Contact"
        let nc = UINavigationController(rootViewController: contactDetailsVC)
        nc.navigationBar.prefersLargeTitles = true
        present(nc, animated: true, completion: nil)
    }
    
    @objc fileprivate func updateButtonTapped() {
        items = contacts
        let set = IndexSet(integersIn: 0...0)
        tableView.reloadSections(set, with: .fade)
    }

    fileprivate func setupNavigationItem() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.navigationItem.rightBarButtonItem = addButton
        
        let updateButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateButtonTapped))
        self.navigationItem.leftBarButtonItem = updateButton
    }
}
