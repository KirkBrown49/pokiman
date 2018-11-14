//
//  allPokemonViewController.swift
//  pokiman
//
//  Created by Kirk Brown on 11/14/18.
//  Copyright © 2018 Kirk Brown. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class allPokemonViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    func tableView(_ View: UITableView, numberOfRowsInSection section : Int) -> Int {
        return pokemonNames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell")
        cell?.textLabel?.text = pokemonNames[indexPath.row]
        return cell!
    }
    // an array to hold the pokemon names from the api
    var pokemonNames: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // url for alamoFire request to get back all pokemon
        let url = "https://pokeapi.co/api/v2/pokemon/"
        
        // alamofire request made from url
        let alamofireRequest = Alamofire.request(url)
        
        alamofireRequest.responseJSON { response in
       // switch statement for results of request from api
            switch response.result {
            case .success(let value):
                print(value)
                
                //convert our response to Json into a SwiftyJson object
                let json = JSON(value)
                if let results = json["results"].array{
                    for result in results{
                        if let pokemonName = result["name"].string {
                            self.pokemonNames.append(pokemonName)
                        }
                    }
                    //reload the tabel view
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
