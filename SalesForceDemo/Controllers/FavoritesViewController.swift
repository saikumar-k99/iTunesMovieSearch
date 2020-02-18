//
//  FavoritesViewController.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/15/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet var noResultsLabel: UILabel!
    @IBOutlet var favoritesTableView: UITableView!
    
    let viewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Favorites"
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFavoriteMoviesFromUserDefaults { (isSuccess) in
            self.favoritesTableView.reloadData()
            if isSuccess {
                self.noResultsLabel.isHidden = true
            } else {
                self.noResultsLabel.isHidden = false
            }
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = viewModel.favoriteModel?.favorites else {
            return 0
        }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell
        guard let dataSource = viewModel.favoriteModel?.favorites else {
            return ListTableViewCell()
        }
        cell?.setupUI(data: dataSource[indexPath.row])
        
        return cell ?? ListTableViewCell()
    }
}
