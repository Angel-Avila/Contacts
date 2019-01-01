//
//  ViewController.swift
//  Contacts
//
//  Created by Angel Avila on 12/19/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class ViewController: GenericTableViewController<ContactCell, Contact>, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let tintColor = UIColor(white: 0.25, alpha: 1)
    
    let contacts = [Contact(firstName: "Ángel", lastName: "Ávila", dateOfBirth: "June 15, 1996", addresses: ["Unidad Nacional 3165"], phoneNumbers: ["3313610519", "555555555"], emails: ["aangel.aac96@gmail.com", "is697755@iteso.mx", "test@test.com"]),
                    Contact(firstName: "Marcel", lastName: "Castiello"),
                    Contact(firstName: "Sandy", lastName: "Matthew")]
    
    var filtered = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = contacts
        setupNavigationItem()
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Contacts"
    }
    
    // MARK: - Search results
    
    func updateSearchResults(for searchController: UISearchController) {

        let searchBar = searchController.searchBar
        
        if searchBar.text == nil || searchBar.text == "" {
            filtered.removeAll()
            tableView.reloadData()
        } else if let text = searchBar.text, text.count > 2 {

            let lower = searchBar.text!.lowercased()
            filtered = items.filter { ($0.firstName.lowercased() + " " +  $0.lastName.lowercased()).contains(lower) }
            
            tableView.reloadData()
        }
    }
    
    // MARK: - Tableview
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactCell
        
        cell.item = items[indexPath.row]
    
        if !searchController.isActive {
            cell.item = items[indexPath.row]
        } else if let text = searchController.searchBar.text, text.count > 2 {
            cell.item = filtered[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let text = searchController.searchBar.text, text.count > 2, searchController.isActive {
            return filtered.count
        } else {
            return items.count
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let text = searchController.searchBar.text, text.count > 2, searchController.isActive {
            
            searchController.dismiss(animated: true, completion: nil)
            searchController.isActive = false
            
            let contact = filtered[indexPath.row]
            let title = contact.firstName + " " + contact.lastName
            presentDetails(withContact: contact, isAddingAContact: false, title: title)
            
            return
        }
        
        let contact = items[indexPath.row]
        let title = contact.firstName + " " + contact.lastName
        presentDetails(withContact: contact, isAddingAContact: false, title: title)
    }
    
    // MARK: - Actions
    
    @objc fileprivate func addButtonTapped() {
        let contact = Contact(firstName: "", lastName: "")
        presentDetails(withContact: contact, isAddingAContact: true, title: "New Contact")
    }
    
    @objc fileprivate func updateButtonTapped() {
        items = contacts
        let set = IndexSet(integersIn: 0...0)
        tableView.reloadSections(set, with: .fade)
    }
    
    // MARK: - Utils
    
    fileprivate func presentDetails(withContact contact: Contact, isAddingAContact adding: Bool, title: String) {
        let contactDetailsVC = ContactDetailsVC(contact: contact, viewController: self, isAddingAContact: adding)
        contactDetailsVC.title = title
        let nc = UINavigationController(rootViewController: contactDetailsVC)
        nc.navigationBar.prefersLargeTitles = true
        present(nc, animated: true, completion: nil)
    }

    // MARK: - Setup
    
    fileprivate func setupNavigationItem() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        addButton.tintColor = tintColor
        self.navigationItem.rightBarButtonItem = addButton
        
        let updateButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateButtonTapped))
        updateButton.tintColor = tintColor
        self.navigationItem.leftBarButtonItem = updateButton
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
    }
}
