//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

class Athlete: CustomStringConvertible {
    
    var id: String!
    var firstName: String!
    var lastName: String!
    var email: String!
    var age: Int!
    
    var fullName: String {
        return firstName
    }
    
    var description: String {
        guard let first = firstName, let last = lastName else { return "" }
        return "\(first) \(last)"
    }
}

class WOD {
    
    enum WODType: Int {
        case amrap
        case emom
        case for_time
        case finisher
    }
    
    var id: String!
    var name: String!
    var type: WODType!
    var timeCap: TimeInterval!
    var movements: [MovementConfiguration]?
}

protocol Resultable {
    var resultRepresentation: String { get }
}

class Result {
    var athlete: Athlete!
    var wod: WOD!
}

class RoundResult: Result, Resultable {
    
    var repetitions: Int!
    var rounds: Int!
    
    var resultRepresentation: String {
        return "\(repetitions) + \(rounds)"
    }
}

class EmomResult {
    
    // EMOM
}

class Movement: CustomStringConvertible {
    
    enum MovementCategory {
        case weightLifting
        case bodyWeight
        case endurance
    }
    
    enum MovementAmoutType {
        
        case meters
        case repetitions
        
        var format: String {
            return "reps"
        }
    }
    
    var name: String?
    var categories: [MovementCategory]?
    var amountType: MovementAmoutType?
    
    var description: String {
        return name != nil ? name! : ""
    }
}

class MovementConfiguration: CustomStringConvertible {
    
    var movement: Movement?
    var amount: Int?
    
    var description: String {
        guard let mov = movement, let am = amount else { return "" }
        return "\(mov) x \(am)"
    }
}

class TimedResult: Result, Resultable {
    
    var time: TimeInterval!
    
    var resultRepresentation: String {
        return String(time)
    }
}

class Session {
    
    var date: Date!
//    var results: [??]
}

// --------------------------------------------
// - CREATING ATHLETES
// --------------------------------------------

let athlete1 = Athlete()
athlete1.firstName = "Jonathan"
athlete1.lastName = "Arnal"

let athlete2 = Athlete()
athlete2.firstName = "Mégane"
athlete2.lastName = "Moreira"

let athlete3 = Athlete()
athlete3.firstName = "Kibin"
athlete3.lastName = "Machado"

// --------------------------------------------
// - CREATING MOVEMENTS
// --------------------------------------------

let muscleUP = Movement()
muscleUP.name = "Muscle-up"
muscleUP.categories = [.bodyWeight]
muscleUP.amountType = .repetitions

let pushUp = Movement()
pushUp.name = "Push-up"
pushUp.categories = [.bodyWeight]
pushUp.amountType = .repetitions

let run = Movement()
run.name = "Run"
run.categories = [.endurance]
run.amountType = .meters

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

let wod = WOD()
wod.name "The first WOD"
wod.movements = [muConf, puConf, runConf]
wod.timeCap = 20
wod.id = ""
