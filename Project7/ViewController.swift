//
//  ViewController.swift
//  Project7
//
//  Created by Edson Neto on 17/04/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json" //aponta para os dados em json online
        
        if let url = URL(string: urlString){ //converte em URL
            if let data = try? Data(contentsOf: url){ //Converte o url em Data
                //ok to parse data
                parse(json: data)
            }
        }
        
    }
    
    func parse(json: Data){ //recebe json do tipo DATA
        let decoder = JSONDecoder() //Cria um decoder
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){ //pede ao decoder para converter em um unico objeto petitions. o self é acha aquele tipo e faz uma instancia daquele objeto no nosso json
            petitions = jsonPetitions.results //atribui o resultado ao array de petitions(esse result vem do struct que equivale ao results do JSON)
            tableView.reloadData()
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title //Muda o Title da cell(porque tem style subtitle com title e detail)
        cell.detailTextLabel?.text = petition.body //muda o Detail da cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

