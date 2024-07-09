//
//  DegreeAndNameView.swift
//  Aispl-Task
//
//  Created by Karthi on 08/07/24.
//

import Foundation
import UIKit

class DegreeAndNameView: UIView {
    
    lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "22°c"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 45)
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    lazy var wishLabel: UILabel = {
        let label = UILabel()
        label.text = "GOOD MORNING"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "WASIM"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    lazy var dashLabel: UILabel = {
        let label = UILabel()
        label.text = "---"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupUi()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUi()
        backgroundColor = .clear
    }
    
    func setupUi() {
        addSubviews(with: [degreeLabel, wishLabel, nameLabel, dashLabel])
        
        degreeLabel.top == top + .ratioHeightBasedOniPhoneX(20)
        degreeLabel.centerX == centerX
        degreeLabel.height == .ratioHeightBasedOniPhoneX(60)
        degreeLabel.width == .ratioHeightBasedOniPhoneX(225)
        
        wishLabel.top == degreeLabel.bottom
        wishLabel.centerX == centerX
        wishLabel.height == .ratioHeightBasedOniPhoneX(30)
        wishLabel.width == .ratioHeightBasedOniPhoneX(225)
        
        nameLabel.top == wishLabel.bottom
        nameLabel.centerX == centerX
        nameLabel.height == .ratioHeightBasedOniPhoneX(30)
        nameLabel.width == .ratioHeightBasedOniPhoneX(225)
        
        dashLabel.top == nameLabel.bottom + .ratioHeightBasedOniPhoneX(20)
        dashLabel.centerX == centerX
        dashLabel.height == .ratioHeightBasedOniPhoneX(30)
        dashLabel.width == .ratioHeightBasedOniPhoneX(225)
        
    }
 
    func updateWishLabel(with time: String) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            if let date = formatter.date(from: time) {
                let hour = Calendar.current.component(.hour, from: date)
                
                if hour >= 6 && hour < 12 {
                    wishLabel.text = "GOOD MORNING"
                } else if hour >= 12 && hour < 18 {
                    wishLabel.text = "GOOD AFTERNOON"
                } else {
                    wishLabel.text = "GOOD EVENING"
                }
            } else {
                wishLabel.text = "TIME ERROR"
            }
        }
}
