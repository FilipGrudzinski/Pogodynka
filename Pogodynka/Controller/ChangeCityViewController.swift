//
//  ChangeCityViewController.swift
//  Pogodynka
//
//  Created by Filip on 01/10/2018.
//  Copyright © 2018 Filip. All rights reserved.
//

import UIKit

class ChangeCityViewController: UIViewController {
    
    @IBOutlet weak var ChangeCityTextField: UITextField!
    
    @IBAction func getWeatherPressed(_ sender: Any) {
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
