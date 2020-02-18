//
//  SearchViewController.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/15/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var searchCollectionView: UICollectionView!
    @IBOutlet var spinnerView: UIActivityIndicatorView!
    @IBOutlet var noResultsLabel: UILabel!
    
    let searchController = UISearchController(searchResultsController: nil)
    let searchViewModel = SearchResultsViewModel()
    
    lazy var listLayout: ListLayout = {
        var listLayout = ListLayout(itemHeight: 200)
        return listLayout
    }()
    
    lazy var gridLayout: GridLayout = {
        var gridLayout = GridLayout(numberOfColumns: 2)
        return gridLayout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.delegate = self
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        
        searchCollectionView.collectionViewLayout = listLayout
        searchCollectionView.register(UINib.init(nibName: "GridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GridCollectionViewCell")
        searchCollectionView.register(UINib.init(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ListCollectionViewCell")
    }
    
    @IBAction func toggleSwitchTapped(_ layoutToggle: UISwitch) {
        spinnerView.isHidden = false
        
        if(layoutToggle.isOn) {
            UIView.animate(withDuration: 0.1, animations: {
                self.searchCollectionView.collectionViewLayout.invalidateLayout()
                self.searchCollectionView.setCollectionViewLayout(self.listLayout, animated: false)
            })
        } else {
            UIView.animate(withDuration: 0.1, animations: {
                self.searchCollectionView.collectionViewLayout.invalidateLayout()
                self.searchCollectionView.setCollectionViewLayout(self.gridLayout, animated: false)
            })
        }
        searchCollectionView.reloadData()
        spinnerView.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndex = searchCollectionView.indexPathsForSelectedItems?.first else {
            return
        }
        
        if segue.identifier == "MovieDetailSegue" {
            if let targetVC = segue.destination as? MovieDetailsViewController, let movie = searchViewModel.dataSourceArray?[selectedIndex.row] {
                targetVC.movieDetail = movie
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "We are unable to perform your request\n Please Try Again!!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchString = searchBar.text, searchString != "" else {
            return
        }
        
        spinnerView.isHidden = false
        searchViewModel.searchForMovie(queryString: searchString) { (isSuccess) in
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                searchBar.text = searchString
                self.spinnerView.isHidden = true
                
                if isSuccess {
                    self.searchCollectionView.reloadData()
                    guard let dataSource = self.searchViewModel.dataSourceArray else {
                        return
                    }
                    self.noResultsLabel.isHidden =  dataSource.count > 0 ? true : false
                } else {
                    self.showAlert()
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        noResultsLabel.isHidden = true
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.dataSourceArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.collectionViewLayout == listLayout {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as? ListCollectionViewCell ?? ListCollectionViewCell()
            if let movie = searchViewModel.dataSourceArray?[indexPath.row] {
                cell.cellDelegate = self
                cell.setupUI(data: movie)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCollectionViewCell", for: indexPath) as? GridCollectionViewCell ?? GridCollectionViewCell()
            if let movie = searchViewModel.dataSourceArray?[indexPath.row] {
                cell.setupUI(data: movie)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MovieDetailSegue" , sender: self)
    }
}

extension SearchViewController: ListCollectionViewCellDelegate {
    func favoriteButtonTapped(sender: Movie) {
            FavoriteUtility.saveToFavourites(movie: sender) { (isSuccess) in
                if isSuccess {
                    searchViewModel.favoriteButtonTapped(movie: sender) } else {
                    print("saving to user defaults failed")
                }
            }
    }
}
