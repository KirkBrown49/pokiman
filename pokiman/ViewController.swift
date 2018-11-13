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
import SDWebImage
class ViewController: UIViewController {
    // outlets for storyBoard
    @IBOutlet weak var pokimonNameTextField: UITextField!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var pokeImage: UIImageView!
    
    // base url for the pokimon api
    var pokiApIBaseURL = "https://pokeapi.co/api/v2/pokemon/"

    override func viewDidLoad() {
        // base url for the pokimon api
      
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    @IBAction func submitTapped(_ sender: Any) {
        // dismissing keyboard
        pokimonNameTextField.resignFirstResponder()
        
        //checking to make sure the field has value
        guard let pokiName = pokimonNameTextField.text,
                pokimonNameTextField.text != ""
            else {
                return
        }
        //clearing the text field
        pokimonNameTextField.text = ""
        
       
        //replacing spaces in name with + so it can be used as part of the url
        let pokiNameURLComponent = pokiName.replacingOccurrences(of: " ", with: "")
       
        
        //building our complete request url with name
        let requestURL = pokiApIBaseURL + pokiNameURLComponent + "/"
        
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.infoTextView.text = json["name"].stringValue
                if let spriteURL = json["sprites"]["front_default"].string {
                    if let url = URL(string: spriteURL) {
                        self.pokeImage.sd_setImage(with: url, completed: nil)
                    }
                }
            case .failure(let error):
                self.infoTextView.text = "Invalid selection entered or an error occured.Please try again!"
                print(error.localizedDescription)
            }
        }
        
    }
    
}
