//
//  ViewController.swift
//  Project7
//
//  Created by Edson Neto on 17/04/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(apiInfoAlert))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filterPetitions))
        
        /*
         Busca:
         ao apertar a lupa criar um alerta com um espaço de texto e um botão(olhar no word scramble)
         pega a palavra percorrer o array petitions verificando se contains a palavra buscada(colocar tudo em minusculo para não ter esse problema
         Criar um array vazio para adicionar os que bateram com a busca
         fazer reload data só com o array novo
         
         
         */
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json" //aponta para os dados em json online
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString){ //converte em URL
            if let data = try? Data(contentsOf: url){ //Converte o url em Data
                //ok to parse data
                parse(json: data)
                return
            }
        }
            showError()
                
    }
    
    @objc func apiInfoAlert(){
        let ac = UIAlertController(title: nil, message: "This is the We the people API from the White House", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .default))
        present(ac, animated: true)
    }
    
    @objc func filterPetitions(){
        let ac = UIAlertController(title: "Search Petitions", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Search", style: .default){
            [weak self, weak ac] _ in
            guard let filter = ac?.textFields?[0].text else {return}
            self?.searchPetitions(filter)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func searchPetitions(_ filter: String){
        filteredPetitions.removeAll()
        for petition in petitions{
            if petition.title.lowercased().contains(filter.lowercased()){
                filteredPetitions.append(petition)
            }
        }
        tableView.reloadData()
    }
        
    
    func showError(){
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
    func parse(json: Data){ //recebe json do tipo DATA
        let decoder = JSONDecoder() //Cria um decoder
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){ //pede ao decoder para converter em um unico objeto petitions. o self é acha aquele tipo e faz uma instancia daquele objeto no nosso json
            petitions = jsonPetitions.results //atribui o resultado ao array de petitions(esse result vem do struct que equivale ao results do JSON)
            filteredPetitions = petitions
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title //Muda o Title da cell(porque tem style subtitle com title e detail)
        cell.detailTextLabel?.text = petition.body //muda o Detail da cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

