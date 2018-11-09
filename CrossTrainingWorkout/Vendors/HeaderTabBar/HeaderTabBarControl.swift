//
//  HeaderTabBarControl.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 08/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit
import SnapKit

enum HeaderTabBarElementPosition {
    case left, middle(previous: Int), right(previous: Int)
}

@IBDesignable
class HeaderTabBarControl: UIControl {
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    var selectedIndex: Int?
    
    private var highlightView: UIView!
    
    private var buttons: [HeaderTabBarElementView] = []
    
    // **************************************************************
    // MARK: - Inspectable
    // **************************************************************
    
    @IBInspectable
    public var highlightColor: UIColor = UIColor(hexString: "#00D2A9")
    
    @IBInspectable
    public var highlightHeight: Int = 5
    
    // **************************************************************
    // MARK: - Life Cycle
    // **************************************************************
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // **************************************************************
    // MARK: - Private Business
    // **************************************************************
    
    /// ⚙️ Setup view elements
    private func setupView() {
        buildHighlightView()
    }
    
    private func getPosition(forIndex index: Int, inTotalIndexes total: Int) -> HeaderTabBarElementPosition {
        
        switch (index == 0, index == total) {
        case (true, _):
            return .left
        case (_, true):
            return .right(previous: index-1)
        default:
            return .middle(previous: index-1)
        }
    }
    
    /// 🔄 Update control buttons depending on elements passed in parameter
    ///
    /// - Parameter elements: models allowing to create buttons
    func update(elements: [HeaderTabBarElement]) {
        
        buttons.forEach({$0.removeFromSuperview()})
        buttons.removeAll()
        
        let lastIndex = elements.count - 1
        for (index, element) in elements.enumerated() {
            
            let elementView = HeaderTabBarElementView()
            elementView.build(withData: element)
            elementView.isUserInteractionEnabled = false
            
            addSubview(elementView)
            buttons.append(elementView)
            
            let position = getPosition(forIndex: index, inTotalIndexes: lastIndex)
            setConstaints(forElementView: elementView, havingPosition: position)
            
            if doesViewNeedsToBeHighlighted(elementView, beingAtIndex: index) {
                alignHighlightView(toButton: elementView)
            }
        }
    }
    
    /// ⬆️ Returns if the the element needs to be highlighted
    ///
    /// - Parameters:
    ///   - elementView: element view concerned
    ///   - index: index of the element in array
    /// - Returns: does element need to be highlighted
    private func doesViewNeedsToBeHighlighted(_ elementView: HeaderTabBarElementView, beingAtIndex index: Int) -> Bool {
        guard let previousSelectedIndex = selectedIndex, previousSelectedIndex == index else { return index == 0 }
        return true
    }
    
    /// ↔️ Set constraints for specific element view depending on his position in array (left, middle, middle, right)
    ///
    /// - Parameters:
    ///   - elementView: element needing constraints
    ///   - position: position of the element
    private func setConstaints(forElementView elementView: HeaderTabBarElementView, havingPosition position: HeaderTabBarElementPosition) {
        
        elementView.snp.makeConstraints { (make) in
            
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            
            switch position {
            case .left:
                make.left.equalToSuperview()
            case .middle(let previousIndex):
                let previous = buttons[previousIndex]
                make.left.equalTo(previous.snp.right)
                make.width.equalTo(previous)
            case .right(let previousIndex):
                let previous = buttons[previousIndex]
                make.left.equalTo(previous.snp.right)
                make.width.equalTo(previous)
                make.right.equalToSuperview()
            }
        }
    }
    
    /// 🚧 Builds hightlight view
    private func buildHighlightView() {
        
        highlightView = UIView()
        highlightView.backgroundColor = highlightColor
        addSubview(highlightView)
    }
    
    /// Aligns the highlight view bellow a specific element view
    ///
    /// - Parameter button: element view to highlight
    private func alignHighlightView(toButton button: HeaderTabBarElementView) {
        
        highlightView.snp.remakeConstraints({make in
            make.height.equalTo(highlightHeight)
            make.width.equalTo(button)
            make.bottom.equalTo(self)
            make.centerX.equalTo(button)
        })
    }
    
    /// Returns the index of the button that is uppon the passed location
    ///
    /// - Parameter location: location where the user is touching screen
    /// - Returns: index of the button
    private func calculateIndexForLocation(location: CGPoint) -> Int? {
        
        var calculatedIndex : Int?
        for (index, item) in buttons.enumerated() {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        return calculatedIndex
    }
    
    // **************************************************************
    // MARK: - User Interaction
    // **************************************************************
    
    /// 👆 Handles when the user is moving through the screen
    ///
    /// - Parameters:
    ///   - touch: touch object
    ///   - event: event sent by system
    private func handleTracking(_ touch: UITouch, with event: UIEvent?) {
        
        let location = touch.location(in: self)
        if let calculatedIndex = calculateIndexForLocation(location: location) {
            
            let selectedView = buttons[calculatedIndex]
            alignHighlightView(toButton: selectedView)
            
            selectedIndex = calculatedIndex
            sendActions(for: .valueChanged)
        }
    }
    
    // :nodoc:
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        handleTracking(touch, with: event)
        return true
    }
    
    // :nodoc:
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        handleTracking(touch, with: event)
        return true
    }
}
