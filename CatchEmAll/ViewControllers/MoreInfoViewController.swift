//
//  MoreInfoViewController.swift
//  CatchEmAll
//
//  Created by Bryan on 04/12/2020.
//

import UIKit

class MoreInfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var collectionView: UICollectionView?
    
    var poke: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.delegate = self
    }
    
    public func set(poke: Pokemon?)
    {
        if(poke != nil)
        {
            updateTraits(poke: poke!)
        }
    }
    
    func updateTraits(poke: Pokemon)
    {
        self.poke = poke
        if(poke.sprites.frontDefault != "")
        {
            let imageUrl = URL(string: poke.sprites.frontDefault)!

            let imageData = try! Data(contentsOf: imageUrl)

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageView?.image = image
                self.nameLabel?.text = poke.name.uppercased()
            }
        }
    }
    
    // UICollectionViewDelegate/ DataSource //
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
        return self.poke?.moves.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if(cell.subviews
            .filter({ ($0 as? UILabel) != nil }).count > 0)
        {
            let label = cell.subviews
                .filter({ ($0 as? UILabel) != nil }).first as! UILabel
            
            label.text = self.poke?.moves[indexPath.row].move.name
        }
        else
        {
            let label = UILabel(frame: cell.frame)
            
            label.text = self.poke?.moves[indexPath.row].move.name
            cell.addSubview(label)
        }
        
        return cell
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // TODO: Load move description
        // move URL > effect entries > effect
        
    }

    // UICollectionViewDelegateFlowLayout //
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: collectionView.frame.width, height: 20)
    }
}
