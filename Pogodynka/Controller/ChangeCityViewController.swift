//
//  ChangeCityViewController.swift
//  Pogodynka
//
//  Created by Filip on 01/10/2018.
//  Copyright © 2018 Filip. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
    
    func userEnteredANewCityName(city: String)
    
}

class ChangeCityViewController: UIViewController {
    
    var delegate: ChangeCityDelegate?
    
    @IBOutlet weak var ChangeCityTextField: UITextField!
    
    @IBAction func getWeatherPressed(_ sender: Any) {
        
        if ChangeCityTextField.text!.isEmpty {
            
                popUp()
            
        } else {
            
            let cityName = ChangeCityTextField.text!
        
            delegate?.userEnteredANewCityName(city: cityName)
        
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func popUp() {
        
        let alert = UIAlertController(title: "Fill The City Name", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .default, handler: nil )
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    
    
}



