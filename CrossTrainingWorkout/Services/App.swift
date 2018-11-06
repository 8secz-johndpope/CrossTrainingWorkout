//
//  App.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 06/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation
import RealmSwift


/// Class responsible to share services logic to the entire app
/// You don't like singletons ?
/// 🎦 Go see: https://vimeo.com/291588126 
class App {
    
    //****************************************************
    // MARK: - Singleton
    //****************************************************
    
    static let shared = App()
    private init() {
         database = try! Realm()
    }
    
    //****************************************************
    // MARK: - Database
    //****************************************************
    
    public var database: Database!
}
