//
//  ContactDetailsVC.swift
//  Contacts
//
//  Created by Angel Avila on 12/19/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class ContactDetailsVC: UIViewController {

    var contact: Contact!
    var isAddingAContact: Bool!
    let cellId = "contactCell"
    
    let tintColor = UIColor(white: 0.25, alpha: 1)
    
    let buttonWidth: CGFloat = 150
    let buttonHeight: CGFloat = 60
    
    weak var viewController: ViewController!
    
    var alertController = UIAlertController(nibName: nil, bundle: nil)
    
    lazy var scrollView: UIScrollView! = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.bounces = true
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    lazy var contentStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        return stackView
    }()
    
    lazy var firstNameLabel: UILabel! = {
        let label = UILabel()
        label.text = "First name"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var firstNameTextField: UITextField! = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = UIColor(white: 0.4, alpha: 1)
        tf.placeholder = "First Name"
        tf.delegate = self
        return tf
    }()
    
    lazy var lastNameLabel: UILabel! = {
        let label = UILabel()
        label.text = "Last name"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lastNameTextField: UITextField! = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = UIColor(white: 0.4, alpha: 1)
        tf.placeholder = "Last Name"
        tf.delegate = self
        return tf
    }()
    
    lazy var dateOfBirthLabel: UILabel! = {
        let label = UILabel()
        label.text = "Date of birth"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateOfBirthTextField: UITextField! = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = UIColor(white: 0.4, alpha: 1)
        tf.placeholder = "MMMM d, yyyy"
        tf.delegate = self
        return tf
    }()
    
    lazy var dateOfBirthPicker: UIDatePicker! = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        return picker
    }()
    
    lazy var addressesLabel: UILabel! = {
        let label = UILabel()
        label.text = "Addresses"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var addressesTableView: UITableView! = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        
        tv.dataSource = self
        tv.delegate = self
        
        tv.layer.borderColor = UIColor.darkGray.cgColor
        tv.layer.borderWidth = 2
        tv.layer.cornerRadius = 5
        
        return tv
    }()
    
    lazy var phoneNumbersLabel: UILabel! = {
        let label = UILabel()
        label.text = "Phone numbers"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneNumberTableView: UITableView! = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        
        tv.dataSource = self
        tv.delegate = self
        
        tv.layer.borderColor = UIColor.darkGray.cgColor
        tv.layer.borderWidth = 2
        tv.layer.cornerRadius = 5
        
        return tv
    }()
    
    lazy var emailLabel: UILabel! = {
        let label = UILabel()
        label.text = "Emails"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTableView: UITableView! = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        
        tv.dataSource = self
        tv.delegate = self
        
        tv.layer.borderColor = UIColor.darkGray.cgColor
        tv.layer.borderWidth = 2
        tv.layer.cornerRadius = 5
        
        return tv
    }()
    
    lazy var saveButton: UIButton! = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = buttonHeight/2
        
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Init
    
    init(contact: Contact, viewController: ViewController, isAddingAContact: Bool) {
        self.contact = contact
        self.isAddingAContact = isAddingAContact
        self.viewController = viewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationController()
        setupBackButton()
        setupAddButton()
        setupDateOfBirthViews()
        setupViewUI()
        setupInfoFromContact()
    }
    
    // MARK: - Actions
    
    @objc fileprivate func dismissButtonTapped() {
        
        if isAddingAContact && (firstNameTextField.hasText || lastNameTextField.hasText) {
            let alert = UIAlertController(title: "Discarding new contact", message: "Do you wish to discard your changes or save them?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
                self.saveButtonTapped()
            }))
            
            self.present(alert, animated: true)
            
            return
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func saveButtonTapped() {

        let newContact = Contact(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, dateOfBirth: dateOfBirthTextField.text!, addresses: contact.addresses, phoneNumbers: contact.phoneNumbers, emails: contact.emails)
        
        if isAddingAContact {
            
            viewController.items.append(newContact)
            
            let set = IndexSet(integersIn: 0...0)
            viewController.tableView.reloadSections(set, with: .fade)
            
            dismiss(animated: true, completion: nil)
            
        } else {
            
            let index = viewController.items.firstIndex(where: {$0 == contact!})
            
            guard let i = index else { return }
            
            viewController.items[i] = newContact
            
            let set = IndexSet(integersIn: 0...0)
            viewController.tableView.reloadSections(set, with: .fade)
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc fileprivate func addButtonTapped() {
        
        let alert = UIAlertController(title: "What do you want to add?", message: "Please, choose one.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Address", style: .default, handler: { _ in
            self.addAnAddress()
        }))
        
        alert.addAction(UIAlertAction(title: "Phone number", style: .default, handler: { _ in
            self.addAPhoneNumber()
        }))
        
        alert.addAction(UIAlertAction(title: "Email", style: .default, handler: { _ in
            self.addAnEmail()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
    fileprivate func addSomething(alertTitle: String, placeHolder: String, handler: @escaping (UIAlertAction) -> Void) {
        alertController = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = placeHolder
        })
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        
        self.present(alertController, animated: true)
    }
    
    fileprivate func addAPhoneNumber() {
        
        addSomething(alertTitle: "Type the phone number here", placeHolder: "Phone number") { _ in
            
            if let number = self.alertController.textFields?.first?.text {
                self.contact.phoneNumbers.append(number)
                let set = IndexSet(integersIn: 0...0)
                self.phoneNumberTableView.reloadSections(set, with: .fade)
            }
        }
    }
    
    fileprivate func addAnEmail() {
        
        addSomething(alertTitle: "Type the email here", placeHolder: "Email") { _ in
            
            if let email = self.alertController.textFields?.first?.text {
                self.contact.emails.append(email)
                let set = IndexSet(integersIn: 0...0)
                self.emailTableView.reloadSections(set, with: .fade)
            }
        }
    }
    
    fileprivate func addAnAddress() {
        addSomething(alertTitle: "Type the address here", placeHolder: "Address") { _ in
            
            if let address = self.alertController.textFields?.first?.text {
                self.contact.addresses.append(address)
                let set = IndexSet(integersIn: 0...0)
                self.addressesTableView.reloadSections(set, with: .fade)
            }
        }
    }
    
    @objc fileprivate func dateOfBirthValueChanged(_ sender: UIDatePicker) {
        let f = DateFormatter()
        f.dateFormat = "MMMM d, yyyy"
        dateOfBirthTextField.text = f.string(from: sender.date)
    }
    
    @objc fileprivate func doneButtonPressed() {
        view.endEditing(true)
    }
    
    // MARK: - Setup
    
    fileprivate func setupNavigationController() {
        guard  let nc = self.navigationController  else { return }
        nc.navigationBar.isHidden = false
        nc.navigationBar.barTintColor = .white
        nc.navigationBar.tintColor = tintColor
        
        nc.navigationBar.layer.masksToBounds = false
        nc.navigationBar.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        nc.navigationBar.layer.shadowOpacity = 0.5
        nc.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        nc.navigationBar.layer.shadowRadius = 2
    }
    
    fileprivate func setupBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        backButton.setImage(#imageLiteral(resourceName: "iconoCerrar"), for: .normal)
        backButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        
        let item = UIBarButtonItem(customView: backButton)
        item.customView?.anchorSize(size: CGSize(width: 24, height: 24))
        
        navigationItem.leftBarButtonItem = item
    }
    
    fileprivate func setupAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    fileprivate func setupDateOfBirthViews() {
        dateOfBirthTextField.inputView = dateOfBirthPicker
        
        dateOfBirthPicker.addTarget(self, action: #selector(dateOfBirthValueChanged(_:)), for: .valueChanged)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = tintColor
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        
        toolBar.setItems([doneButton], animated: false)
        
        dateOfBirthTextField.inputAccessoryView = toolBar
    }
    
    fileprivate func setupViewUI() {
        phoneNumberTableView.register(StringCell.self, forCellReuseIdentifier: cellId)
        emailTableView.register(StringCell.self, forCellReuseIdentifier: cellId)
        addressesTableView.register(StringCell.self, forCellReuseIdentifier: cellId)
        
        let padding: CGFloat = 20
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        
        scrollView.addSubview(contentStackView)
        
        let width = view.bounds.width - padding * 2
        
        contentStackView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: 0), size: CGSize(width: width, height: 0))
        
        phoneNumberTableView.anchorSize(size: CGSize(width: width, height: 200))
        emailTableView.anchorSize(size: CGSize(width: width, height: 200))
        addressesTableView.anchorSize(size: CGSize(width: width, height: 200))
        
        [firstNameLabel, firstNameTextField, lastNameLabel, lastNameTextField, dateOfBirthLabel, dateOfBirthTextField, addressesLabel, addressesTableView, phoneNumbersLabel, phoneNumberTableView, emailLabel, emailTableView].forEach { contentStackView.addArrangedSubview($0) }
        
        scrollView.addSubview(saveButton)
        saveButton.anchor(top: contentStackView.bottomAnchor, leading: nil, bottom: scrollView.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: padding*2, left: 0, bottom: padding, right: 0), size: CGSize(width: buttonWidth, height: buttonHeight))
        
        saveButton.anchorCenterX(to: scrollView)
    }
    
    fileprivate func setupInfoFromContact() {
        firstNameTextField.text = contact.firstName
        lastNameTextField.text = contact.lastName
        dateOfBirthTextField.text = contact.dateOfBirth
    }
}

extension ContactDetailsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == phoneNumberTableView {
            return contact.phoneNumbers.count
        } else if tableView == emailTableView {
            return contact.emails.count
        } else if tableView == addressesTableView {
            return contact.addresses.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! StringCell
        
        if tableView == phoneNumberTableView {
           cell.item = contact.phoneNumbers[indexPath.row]
        } else if tableView == emailTableView {
            cell.item = contact.emails[indexPath.row]
        } else if tableView == addressesTableView {
            cell.item = contact.addresses[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if tableView == phoneNumberTableView && indexPath.row < contact.phoneNumbers.count {
            contact.phoneNumbers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
            
        } else if tableView == emailTableView && indexPath.row < contact.emails.count {
            contact.emails.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        } else if tableView == addressesTableView && indexPath.row < contact.addresses.count {
            contact.addresses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
    
}

extension ContactDetailsVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
