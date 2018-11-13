//
//  DatabaseMockManager.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 06/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import RealmSwift

class DatabaseMockManager {
    
    public static var shared = DatabaseMockManager()
    private init(){}
    
    public func install() {
        
        // --------------------------------------------
        // - CREATING ATHLETES
        // --------------------------------------------
        
        let athlete1 = Athlete()
        athlete1.id = "1"
        athlete1.firstName = "Jonathan"
        athlete1.lastName = "Arnal"
        
        let athlete2 = Athlete()
        athlete2.id = "2"
        athlete2.firstName = "Mégane"
        athlete2.lastName = "Moreira"
        
        let athlete3 = Athlete()
        athlete3.id = "3"
        athlete3.firstName = "Kibin"
        athlete3.lastName = "Machado"
        
        // --------------------------------------------
        // - CREATING MOVEMENTS
        // --------------------------------------------
        
        let muscleUP = Movement()
        muscleUP.name = "Muscle-up"
        muscleUP.categories = List<Int>()
        muscleUP.amountType = 1
        
        let pushUp = Movement()
        pushUp.name = "Push-up"
        pushUp.categories = List<Int>()
        pushUp.amountType = 1
        
        let run = Movement()
        run.name = "Run"
        run.categories = List<Int>()
        run.amountType = 1
        
        // --------------------------------------------
        // - CONFIGURING MOVEMENTS
        // --------------------------------------------
        
        let muConf = MovementConfiguration()
        muConf.amount = 20
        muConf.movement = muscleUP
        
        let puConf = MovementConfiguration()
        puConf.amount = 20
        puConf.movement = pushUp
        
        let runConf = MovementConfiguration()
        runConf.amount = 1000
        runConf.movement = run
        
        // --------------------------------------------
        // - CREATING WOD
        // --------------------------------------------
        
        let movements = List<MovementConfiguration>()
        movements.append(objectsIn: [muConf, puConf, runConf])
        
        let amrap = Wod()
        amrap.id = "1"
        amrap.wodType = WodType.amrap.rawValue
        amrap.name = "AMRAP WOD"
        amrap.movements = movements
        amrap.timeCap = 20
        
        let forTime = Wod()
        forTime.wodType = WodType.forTime.rawValue
        forTime.id = "2"
        forTime.name = "FORTIME WOD"
        forTime.movements = movements
        forTime.timeCap = 20
        
        let emom = Wod()
        emom.wodType = WodType.emom.rawValue
        emom.id = "3"
        emom.name = "EMOM WOD"
        emom.movements = movements
        emom.timeCap = 20
        
        let finisher = Wod()
        finisher.wodType = WodType.finisher.rawValue
        finisher.id = "4"
        finisher.name = "FINISHER WOD"
        finisher.movements = movements
        finisher.timeCap = 20
        
        // --------------------------------------------
        // - CREATING RESULTS
        // --------------------------------------------
        
        let result1 = TimeResult()
        result1.athlete = athlete2
        result1.time = 2000
        
        let result2 = TimeResult()
        result2.athlete = athlete2
        result2.time = 3000
        
        let result3 = TimeResult()
        result3.athlete = athlete2
        result3.time = 4000
        
        // --------------------------------------------
        // - CREATING RESULTS
        // --------------------------------------------
        
        let session = Session()
        session.date = Date()
        session.wod = amrap
        
        let session1 = SessionAmrap()
        session1.date = Date()
        session1.wod = amrap
        
        let session2 = SessionForTime()
        session2.date = Date()
        session2.wod = forTime
        
        let session3 = SessionAmrap()
        session3.date = Date()
        session3.wod = amrap
        
        let session4 = SessionEmom()
        session4.date = Date()
        session4.wod = amrap
        
        // --------------------------------------------
        // - Saving into DB
        // --------------------------------------------
        
        let realm = try! Realm()
        try! realm.safeWrite(withoutNotifying: []) {
            realm.deleteAll()
            
            realm.add(athlete1)
            realm.add(athlete2)
            realm.add(athlete3)
            
            realm.add(muscleUP)
            realm.add(puConf)
            realm.add(runConf)
            
            realm.add(amrap)
            realm.add(forTime)
            realm.add(emom)
            realm.add(finisher)
            
            realm.add(session1)
            realm.add(session2)
            realm.add(session3)
            realm.add(session4)
        }
        
        let sessions: [Session] = realm.loadObjects(withParentType: Session.self, subclasses: [SessionAmrap.self, SessionForTime.self, SessionEmom.self])
        print(sessions.count)
        
    }
    
}
