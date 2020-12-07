//
//  ViewController.swift
//  CatchEmAll
//
//  Created by Bryan on 02/12/2020.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PokePIDelegate, UISearchBarDelegate
{
    
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint?
    @IBOutlet weak var collectionView: UICollectionView?
    var pokeBases = [PokeBase]()
    var filterPokeBases = [PokeBase]()
    
    // UIViewController //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("request")
        let api = PokePIRequestHandler(delegate: self)
        api.requestMainList()
        
        let nib = UINib(nibName:"PokeCollectionViewCell",
                        bundle: .main)
        
        self.collectionView?.register(nib,
                                      forCellWithReuseIdentifier: "pokeCollectionViewCell")
        self.collectionView?.delegate = self
    }
    
    
    // PokePIDelegate //
    func requestSuccess(response: Data,
                        requestType: PokePIRequestHandler.RequestType)
    {
        print("requestSuccess")
        do {
            let decoder = JSONDecoder()
            let pokeRes = try decoder.decode(PokeResponse.self,
                                             from: response)
            for base in pokeRes.results
            {
                print("base \(base.name) \(base.url)")
            }
            self.pokeBases = pokeRes.results
            self.filterPokeBases = pokeRes.results
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
        catch let error as NSError
        {
            print("error \(error.localizedDescription)")
            requestFailed()
        }
    
    }
    
    func requestFailed()
    {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "An Error Occured",
                                          message: "Something went wrong. Please try again later. Thanks",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK",
                                                                   comment: "Default action"),
                                          style: .default,
                                          handler: { _ in
                                            
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }

    // UICollectionViewDelegate/ DataSource //
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
        print("count \(self.filterPokeBases.count)")
        return self.filterPokeBases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCollectionViewCell",
                                                      for: indexPath) as? PokecollectionViewCell
        
        cell?.update(base: self.filterPokeBases[indexPath.row])
        
        return cell!
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as? PokecollectionViewCell
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main",
                                                    bundle: nil)
        
        let moreInfoVC = storyBoard.instantiateViewController(withIdentifier: "moreInfoViewController") as? MoreInfoViewController
        
        moreInfoVC?.set(poke: cell?.poke)
        let transitionDelegate = SmallTransitioningDelegate()
        moreInfoVC?.transitioningDelegate = transitionDelegate
        moreInfoVC?.modalPresentationStyle = .custom
        self.present(moreInfoVC!, animated: true, completion: nil)
//        present fun and cool popover UI with cell?.poke
    }

    // UICollectionViewDelegateFlowLayout //
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: collectionView.frame.width, height: 120)
    }
    
    // UISearchBarDelegate - Filter Pokémon by name on search //
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText)
        if(searchText == "")
        {
            self.filterPokeBases = self.pokeBases
        }
        else
        {
            for p in filterPokeBases
            {
                print(p.name)
            }
            self.filterPokeBases = self.filterPokeBases.filter({$0.name.localizedCaseInsensitiveContains(searchText)})
            
            print(self.filterPokeBases.count)
        }
    
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    // UIScrollViewDelegate - Hide/ show search bar on scroll //
    private var lastContentOffset: CGFloat = 0

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    {
       lastContentOffset = scrollView.contentOffset.y
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if lastContentOffset > scrollView.contentOffset.y
        {
            UIView.animate(withDuration: 0.25,
                           animations: { [weak self] in
                self?.searchBarHeightConstraint?.constant = 50
            }, completion: nil)
        }
        else if lastContentOffset < scrollView.contentOffset.y
        {
            UIView.animate(withDuration: 0.25,
                           animations: { [weak self] in
                self?.searchBarHeightConstraint?.constant = 0
            }, completion: nil)
        }
    }
}

