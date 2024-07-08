//
//  WeatherViewController.swift
//  Aispl-Task
//
//  Created by Karthi on 08/07/24.
//

import UIKit
import Foundation

class WeatherViewController: UIViewController {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var optionImage: UIImageView = {
        let optionView = UIImageView()
        optionView.contentMode = .scaleAspectFill
        optionView.image = UIImage(named: "option")
        return optionView
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.borderStyle = .roundedRect
        
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchButtonTapped))
        imageView.addGestureRecognizer(tapGesture)
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageView.center = rightView.center
        rightView.addSubview(imageView)
        textField.rightView = rightView
        textField.rightViewMode = .always
        
        return textField
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Karachi"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    lazy var dayDateLabel: UILabel = {
        let label = UILabel()
        label.text = "MONDAY 7:00 PM"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    lazy var weatherImage: UIImageView = {
        let optionView = UIImageView()
        optionView.contentMode = .scaleAspectFill
        optionView.backgroundColor = .red
        return optionView
    }()
    
    lazy var degreeAndNameView = DegreeAndNameView()
    lazy var bottomView = BottomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        
        setupUi()
    }
    
    func setupUi() {
        view.addSubview(containerView)
        containerView.addSubviews(with: [optionImage, searchTextField, locationLabel, dayDateLabel, weatherImage, degreeAndNameView, bottomView])
        
        containerView.top == view.safeAreaLayoutGuide.topAnchor
        containerView.bottom == view.bottom
        containerView.leading == view.leading
        containerView.trailing == view.trailing
        
        optionImage.top == containerView.top + .ratioHeightBasedOniPhoneX(15)
        optionImage.leading == containerView.leading + .ratioHeightBasedOniPhoneX(15)
        optionImage.height == .ratioHeightBasedOniPhoneX(25)
        optionImage.width == .ratioHeightBasedOniPhoneX(25)
        
        searchTextField.top == containerView.top + .ratioHeightBasedOniPhoneX(15)
        searchTextField.leading == optionImage.trailing + .ratioHeightBasedOniPhoneX(15)
        searchTextField.height == .ratioHeightBasedOniPhoneX(30)
        searchTextField.trailing == containerView.trailing - .ratioHeightBasedOniPhoneX(15)
        
        locationLabel.top == containerView.top + .ratioHeightBasedOniPhoneX(60)
        locationLabel.centerX == containerView.centerX
        locationLabel.height == .ratioHeightBasedOniPhoneX(50)
        locationLabel.width == .ratioHeightBasedOniPhoneX(150)
        
        dayDateLabel.top == locationLabel.bottom + .ratioHeightBasedOniPhoneX(5)
        dayDateLabel.centerX == containerView.centerX
        dayDateLabel.height == .ratioHeightBasedOniPhoneX(30)
        dayDateLabel.width == .ratioHeightBasedOniPhoneX(150)
        
        weatherImage.top == dayDateLabel.bottom + .ratioHeightBasedOniPhoneX(25)
        weatherImage.centerX == containerView.centerX
        weatherImage.height == .ratioHeightBasedOniPhoneX(200)
        weatherImage.width == .ratioHeightBasedOniPhoneX(200)
        
        degreeAndNameView.height == .ratioHeightBasedOniPhoneX(200)
        degreeAndNameView.width == .ratioHeightBasedOniPhoneX(200)
        degreeAndNameView.top == weatherImage.bottom + .ratioHeightBasedOniPhoneX(10)
        degreeAndNameView.centerX == containerView.centerX
        
        bottomView.height == .ratioHeightBasedOniPhoneX(200)
        bottomView.top == degreeAndNameView.bottom + .ratioHeightBasedOniPhoneX(10)
        bottomView.leading == containerView.leading
        bottomView.trailing == containerView.trailing
        bottomView.centerX == containerView.centerX
    }
    
    @objc func searchButtonTapped() {
        print("search button tapped")
    }
}
