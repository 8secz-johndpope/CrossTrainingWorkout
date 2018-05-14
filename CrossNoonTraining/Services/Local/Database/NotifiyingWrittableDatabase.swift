//
//  NotifiyingDatabase.swift
//  efitbackPraticien
//
//  Created by Jonathan Arnal on 16/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation

protocol NotifiyingWrittableDatabase {
    
    /// Save a storable object into database
    ///
    /// - Parameters:
    ///   - object: object to store
    ///   - update: defines if object needs to be updated or just added
    ///   - tokens: tokens that doesn't need to be aware of updates
    /// - Throws: database errors
    func save<T: Storable>(_ object: T, updateIfExisting update: Bool, withoutNotifying tokens: [NotifiyingToken]) throws
    
    /// Save a list of storable objects into database
    ///
    /// - Parameters:
    ///   - objects: list of objects to store
    ///   - update: defines if objects needs to be updated or just added
    ///   - tokens: tokens that doesn't need to be aware of updates
    /// - Throws: database errors
    func save<T: Storable>(_ objects: [T], updateIfExisting update: Bool, withoutNotifying tokens: [NotifiyingToken]) throws
    
    /// Update specifically and object
    /// Called when the operation on the object is a bit complexe
    ///
    /// - Parameters:
    ///   - tokens: tokens that doesn't need to be aware of updates
    ///   - block: block containing the update logic
    /// - Throws: database errors
    func update(withoutNotifying tokens: [NotifiyingToken], withBlock block: @escaping () -> Void) throws
}

enum NotifiyingDatabaseError: Error {
    case invalidTokenType
}
