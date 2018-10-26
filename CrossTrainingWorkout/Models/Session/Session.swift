//
//  Session.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 03/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

protocol SessionResultable {
    
    associatedtype T:RealmCollectionValue
    var results: List<T>! { get set }
}

class Session: Object, Mappable, SessionResultable {
    
    typealias T = Object
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    @objc dynamic var wod: Wod?
    @objc dynamic var date = Date()
    
    var results: List<T>!
    
    // **************************************************************
    // MARK: - Realm
    // **************************************************************
    
//    override class func primaryKey() -> String? {
//        return "username"
//    }
    
    // **************************************************************
    // MARK: - ObjectMapper
    // **************************************************************
    
//    convenience init?<WodType: Wod<T>>(_ wod: WodType, map: Map) {
//        self.init(map: map)
////        self.wod = wod
//    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
    }
    
    override var description: String {
        guard let unwrappedWod = wod, let name = unwrappedWod.name else { return "" }
        return name
    }
}

class SessionAmrap: Session {
    
    typealias T = RoundResult
    
    required convenience init?(map: Map) {
        self.init()
    }
}

class SessionFinisher: Session {
    
    typealias T = RoundResult
    
    required convenience init?(map: Map) {
        self.init()
    }
}

class SessionForTime: Session {
    
    typealias T = RoundResult
    
    required convenience init?(map: Map) {
        self.init()
    }
}

class SessionEmom: Session {
    
    typealias T = RoundResult
    
    required convenience init?(map: Map) {
        self.init()
    }
}