//
//  PokedexTableViewController.swift
//  Pokedex_Codable
//
//  Created by Milo Kvarfordt on 6/21/23.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var pokedex: PokedexTopLevel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // fetch the pokedex
        NetworkingController.fetchPokedex { [weak self] result in
            switch result {
            case .success(let pokedex):
                DispatchQueue.main.async {
                    self?.pokedex = pokedex
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.errorDescription!)
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokedex?.results.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokedexCell", for: indexPath) as? PokedexTableViewCell else { return UITableViewCell()}
        
        guard let pokedex = pokedex else { return UITableViewCell()}
        
        let resultsDict = pokedex.results[indexPath.row]
        
        cell.updateViews(pokemonResult: resultsDict)
        
        return cell
    }
    

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard segue.identifier == "toDetailVC",
               let destination = segue.destination as? PokemonViewController,
               let indexPath = tableView.indexPathForSelectedRow,
               let cell = tableView.cellForRow(at: indexPath) as? PokedexTableViewCell else { return }
         
         destination.pokemon = cell.pokemon
         destination.pokemonSprite = cell.pokemonSprite
         
     }

    
}
