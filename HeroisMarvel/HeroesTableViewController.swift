//
//  HeroesTableViewController.swift
//  HeroisMarvel
//
//  Created by Vinicius Mangueira on 16/07/18.
//  Copyright © 2018 Vinicius Mangueira. All rights reserved.
//

import UIKit

class HeroesTableViewController: UITableViewController {

    var heroes: [Hero] = []
    var name: String?
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var loadingHeroes: Bool = false
    var currentPage: Int = 0
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Buscando herois. Aguarde..."
        loadHeroes()
    }
    
    
    func loadHeroes() {
        loadingHeroes = true
        MarvelAPI.loadHeroes(name: name, page: currentPage) { (info) in
            if let info = info {
                self.heroes += info.data.results
                self.total = info.data.total
                print(self.total)
                print(self.heroes.count)
                DispatchQueue.main.async {
                    self.loadingHeroes = false
                    self.label.text = "Nao foram encontrado herois com o nome \(self.name!)."
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! HeroViewController
        vc.hero = heroes[tableView.indexPathForSelectedRow!.row]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = heroes.count == 0 ? label : nil
        return heroes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeroTableViewCell
        
        let hero = heroes[indexPath.row]
        cell.prepareHero(with: hero)
        
        
        return cell
    }
    
    
}
