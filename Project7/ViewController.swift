//
//  ViewController.swift
//  Project7
//
//  Created by Edson Neto on 17/04/21.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Title goes here" //Muda o Title da cell(porque tem style subtitle com title e detail)
        cell.detailTextLabel?.text = "Subtitle goes here" //muda o Detail da cell
        return cell
    }
    
}

