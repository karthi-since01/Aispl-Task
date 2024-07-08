//
//  BottomView.swift
//  Aispl-Task
//
//  Created by Karthi on 08/07/24.
//

import Foundation
import UIKit

class BottomView: UIView {
    
   // MARK: - Sunrise View
    
    lazy var sunRiseView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var sunsetImage: UIImageView = {
        let sunsetView = UIImageView()
        sunsetView.contentMode = .scaleAspectFill
        sunsetView.image = UIImage(named: "sunset")
        return sunsetView
    }()
    
    lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.text = "SUNRISE"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    lazy var sunsetMeasureLabel: UILabel = {
        let label = UILabel()
        label.text = "7:00"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    // MARK: - Wind View
    
    lazy var windView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var windImage: UIImageView = {
        let windView = UIImageView()
        windView.contentMode = .scaleAspectFill
        windView.image = UIImage(named: "wind")
        return windView
    }()
    
    lazy var windLabel: UILabel = {
        let label = UILabel()
        label.text = "WIND"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    lazy var windMeasureLabel: UILabel = {
        let label = UILabel()
        label.text = "4m/s"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    // MARK: - Temperature View
    
    lazy var tempView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tempImage: UIImageView = {
        let tempView = UIImageView()
        tempView.contentMode = .scaleAspectFill
        tempView.image = UIImage(named: "temperature")
        return tempView
    }()
    
    lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.text = "TEMPERATURE"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    lazy var tempMeasureLabel: UILabel = {
        let label = UILabel()
        label.text = "23°"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
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
        
        addSubviews(with: [sunRiseView, windView, tempView])
        sunRiseView.addSubviews(with: [sunsetImage, sunsetLabel, sunsetMeasureLabel])
        windView.addSubviews(with: [windImage, windLabel, windMeasureLabel])
        tempView.addSubviews(with: [tempImage, tempLabel, tempMeasureLabel])
        
        sunRiseView.top == top
        sunRiseView.width == .ratioWidthBasedOniPhoneX(110)
        sunRiseView.bottom == bottom
        sunRiseView.trailing == windView.leading
        
        sunsetImage.top == sunRiseView.top + .ratioHeightBasedOniPhoneX(15)
        sunsetImage.centerX == sunRiseView.centerX
        sunsetImage.height == .ratioHeightBasedOniPhoneX(30)
        sunsetImage.width == .ratioHeightBasedOniPhoneX(30)
        
        sunsetLabel.centerX == sunRiseView.centerX
        sunsetLabel.height == .ratioHeightBasedOniPhoneX(30)
        sunsetLabel.leading == sunRiseView.leading
        sunsetLabel.trailing == sunRiseView.trailing
        sunsetLabel.top == sunsetImage.bottom
        
        sunsetMeasureLabel.centerX == sunRiseView.centerX
        sunsetMeasureLabel.height == .ratioHeightBasedOniPhoneX(30)
        sunsetMeasureLabel.leading == sunRiseView.leading
        sunsetMeasureLabel.trailing == sunRiseView.trailing
        sunsetMeasureLabel.top == sunsetLabel.bottom
        
        windView.centerX == centerX
        windView.bottom == bottom
        windView.top == top
        windView.width == .ratioWidthBasedOniPhoneX(110)
        
        windImage.top == sunRiseView.top + .ratioHeightBasedOniPhoneX(15)
        windImage.centerX == windView.centerX
        windImage.height == .ratioHeightBasedOniPhoneX(30)
        windImage.width == .ratioHeightBasedOniPhoneX(30)
        
        windLabel.centerX == windView.centerX
        windLabel.height == .ratioHeightBasedOniPhoneX(30)
        windLabel.leading == windView.leading
        windLabel.trailing == windView.trailing
        windLabel.top == sunsetImage.bottom
        
        windMeasureLabel.centerX == windView.centerX
        windMeasureLabel.height == .ratioHeightBasedOniPhoneX(30)
        windMeasureLabel.leading == windView.leading
        windMeasureLabel.trailing == windView.trailing
        windMeasureLabel.top == windLabel.bottom
        
        tempView.top == top
        tempView.width == .ratioWidthBasedOniPhoneX(110)
        tempView.bottom == bottom
        tempView.leading == windView.trailing
        
        tempImage.top == sunRiseView.top + .ratioHeightBasedOniPhoneX(15)
        tempImage.centerX == tempView.centerX
        tempImage.height == .ratioHeightBasedOniPhoneX(30)
        tempImage.width == .ratioHeightBasedOniPhoneX(30)
        
        tempLabel.centerX == tempView.centerX
        tempLabel.height == .ratioHeightBasedOniPhoneX(30)
        tempLabel.leading == tempView.leading
        tempLabel.trailing == tempView.trailing
        tempLabel.top == sunsetImage.bottom
        
        tempMeasureLabel.centerX == tempView.centerX
        tempMeasureLabel.height == .ratioHeightBasedOniPhoneX(30)
        tempMeasureLabel.leading == tempView.leading
        tempMeasureLabel.trailing == tempView.trailing
        tempMeasureLabel.top == tempLabel.bottom
    }
}
