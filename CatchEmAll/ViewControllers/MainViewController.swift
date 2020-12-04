//
//  ViewController.swift
//  CatchEmAll
//
//  Created by Bryan on 02/12/2020.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PokePIDelegate
{
    
    @IBOutlet weak var collectionView: UICollectionView?
    var pokeBases = [PokeBase]()
    
    // UIViewController //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("request")
        let api = PokePIRequestHandler(delegate: self)
        api.makeRequest(requestType: .fullList)
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
    
    func requestFailed() {
        
    }

    // UICollectionViewDelegate/ DataSource //
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
        print("count \(self.pokeBases.count)")
        return self.pokeBases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCollectionViewCell",
                                                      for: indexPath) as? PokecollectionViewCell
        
        cell?.update(base: self.pokeBases[indexPath.row])
        
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
        let transitionDelegate = SmallAlertTransitioningDelegate()
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
}

