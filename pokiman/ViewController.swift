//
//  ViewController.swift
//  pokiman
//
//  Created by Kirk Brown on 11/12/18.
//  Copyright © 2018 Kirk Brown. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    // outlets for storyBoard
    @IBOutlet weak var pokimonNameTextField: UITextField!
    @IBOutlet weak var infoTextView: UITextView!
    
    override func viewDidLoad() {
        // base url for the pokimon api
        let pokiApiBaseURL = "https://pokeapi.co/api/v2/"
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    @IBAction func submitTapped(_ sender: Any) {
        // dismissing keyboard
        pokimonNameTextField.resignFirstResponder()
        
        //checking to make sure the field has value
        guard let pokiName = pokimonNameTextField.text
            else {
                return
        }
        //clearing the text field
        pokimonNameTextField.text = ""
        
        //replacing spaces in name/title with + so they can be used as part of the url
        let pokiNameURLComponent = pokiName.replacingOccurrences(of: " ", with: "+")
    }
    
}
