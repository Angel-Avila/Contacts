//
//  Contact.swift
//  Contacts
//
//  Created by Angel Avila on 12/19/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import Foundation

struct Contact: Equatable {
    var firstName: String
    var lastName: String
    var dateOfBirth: String
    var addresses: [String]
    var phoneNumbers: [String]
    var emails: [String]
    
    init(firstName: String, lastName: String, dateOfBirth: String = "", addresses: [String] = [String](), phoneNumbers: [String] = [String](), emails: [String] = [String]()) {
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.addresses = addresses
        self.phoneNumbers = phoneNumbers
        self.emails = emails
    }
    
    init(firstName: String, lastName: String, phoneNumbers: [String], emails: [String]) {
        self.init(firstName: firstName, lastName: lastName, dateOfBirth: "", addresses: [String](), phoneNumbers: phoneNumbers, emails: emails)
    }
    
    init(firstName: String, lastName: String) {
        self.init(firstName: firstName, lastName: lastName, dateOfBirth: "", addresses: [String](), phoneNumbers: [String](), emails: [String]())
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }

}
