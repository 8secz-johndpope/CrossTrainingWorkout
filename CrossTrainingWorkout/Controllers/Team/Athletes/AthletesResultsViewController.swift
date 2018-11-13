//
//  AthletesResultsViewController.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 07/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

struct AthleteSessionResultsCountViewModel {
    
    var wodType: WodType
    var wodTypeAmount: Int
}

class AthleteSessionResultsCountView: UIView {
    
    @IBOutlet weak var topLine: UIView! {
        didSet {
            topLine.layer.cornerRadius = 2
        }
    }
    
    @IBOutlet weak var resultTypeLable: UILabel!
    
    @IBOutlet weak var resultsCount: UILabel!
    
    public var viewModel: AthleteSessionResultsCountViewModel? {
        didSet {
            guard let unwrappedModel = viewModel else { return }
            updateUI(withModel: unwrappedModel)
        }
    }
    
    private func updateUI(withModel model: AthleteSessionResultsCountViewModel) {
        
        layer.cornerRadius = 4
        
        topLine.backgroundColor = model.wodType.color
        resultTypeLable.text = model.wodType.title
        resultsCount.text = "\(model.wodTypeAmount)"
    }
    
}

struct AthleteSesionTypeResults {
    var amrapCount: Int
    var forTimeCount: Int
    var finisherCount: Int
    var emomCount: Int
    
    var total: Int {
        return amrapCount + forTimeCount + finisherCount + emomCount
    }
}

struct AthletesResultsLogicController: AppDependent {
    
    
    /// Returns the number of results of each type done by the specified user
    ///
    /// - Parameter id: user id
    /// - Returns: AthleteSesionTypeResults model
    public func loadResultsData(forUserWithId id: String) -> AthleteSesionTypeResults {
        
        let amrapCount = database.loadObjects(withParentType: Session.self, subclasses: [SessionAmrap.self]).count
        let forTimeCount = database.loadObjects(withParentType: Session.self, subclasses: [SessionForTime.self]).count
        let finisherCount = database.loadObjects(withParentType: Session.self, subclasses: [SessionFinisher.self]).count
        let emomCount = database.loadObjects(withParentType: Session.self, subclasses: [SessionEmom.self]).count
        
//        Bundle.main.loadNibNamed(<#T##name: String##String#>, owner: <#T##Any?#>, options: <#T##[UINib.OptionsKey : Any]?#>)
        
        return AthleteSesionTypeResults(amrapCount: amrapCount, forTimeCount: forTimeCount, finisherCount: finisherCount, emomCount: emomCount)
    }
    
}

class AthletesResultsViewController: UIViewController {
    
    var userID: String!
    
    var logicController: AthletesResultsLogicController!
    
    @IBOutlet weak var totalWodNumber: UILabel!
    
    @IBOutlet weak var amrapView: AthleteSessionResultsCountView!
    @IBOutlet weak var forTimeView: AthleteSessionResultsCountView!
    @IBOutlet weak var finisherView: AthleteSessionResultsCountView!
    @IBOutlet weak var emomResults: AthleteSessionResultsCountView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logicController = AthletesResultsLogicController()
        updateResults()
    }
    
    private func updateResults() {
        
        guard let athlete = logicController.database.loadObjects(ofType: Athlete.self, matching: nil).first else { fatalError("No athlete found") }
        let athleteResults = logicController.loadResultsData(forUserWithId: athlete.id)
        
        totalWodNumber.text = "\(athleteResults.total)"
        
        amrapView.viewModel = AthleteSessionResultsCountViewModel(wodType: .amrap, wodTypeAmount: athleteResults.amrapCount)
        forTimeView.viewModel = AthleteSessionResultsCountViewModel(wodType: .forTime, wodTypeAmount: athleteResults.forTimeCount)
        finisherView.viewModel = AthleteSessionResultsCountViewModel(wodType: .finisher, wodTypeAmount: athleteResults.finisherCount)
        emomResults.viewModel = AthleteSessionResultsCountViewModel(wodType: .emom, wodTypeAmount: athleteResults.emomCount)
        
    }
    
}
