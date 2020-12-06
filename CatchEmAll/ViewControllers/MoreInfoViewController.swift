//
//  MoreInfoViewController.swift
//  CatchEmAll
//
//  Created by Bryan on 04/12/2020.
//

import UIKit

class MoreInfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPickerViewDelegate, UIPickerViewDataSource, DetailsDelegate
{
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var pickerView: UIPickerView?
    
    var poke: Pokemon?
    
    // This enum can be used to manage the picker options and reload the collectionView according to it
    public enum Selection: String
    {
        case moves = "Moves"
        case abilities = "Abilities"
    }
    
    var pickerArr = [Selection.moves, Selection.abilities]
    var selection: Selection = .moves
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName:"MoveCollectionViewCell",
                        bundle: .main)
        
        self.collectionView?.register(nib,
                                      forCellWithReuseIdentifier: "moveCollectionViewCell")
        
        self.collectionView?.delegate = self
        
        self.imageView?.layer.cornerRadius = 8.0
        self.imageView?.layer.borderWidth = 1.0
        self.imageView?.layer.borderColor = UIColor.black.cgColor
        self.imageView?.clipsToBounds = true
        
        self.pickerView?.layer.cornerRadius = 8.0
        self.pickerView?.layer.borderWidth = 1.0
        self.pickerView?.layer.borderColor = UIColor.black.cgColor
        self.pickerView?.clipsToBounds = true
        
        self.collectionView?.layer.cornerRadius = 8.0
        self.collectionView?.layer.borderWidth = 1.0
        self.collectionView?.layer.borderColor = UIColor.black.cgColor
        self.collectionView?.clipsToBounds = true
    }
    
    public func set(poke: Pokemon?)
    {
        if(poke != nil)
        {
            updateTraits(poke: poke!)
        }
    }
    
    // Prepare the Pokemon details to update the display
    func updateTraits(poke: Pokemon)
    {
        self.poke = poke
        if(poke.sprites.frontDefault != "")
        {
            let imageUrl = URL(string: poke.sprites.frontDefault)!

            let imageData = try! Data(contentsOf: imageUrl)

            let image = UIImage(data: imageData)?.resizableImage(withCapInsets: UIEdgeInsets.zero,
                                                                 resizingMode: .stretch)
            
            DispatchQueue.main.async {
                self.imageView?.image = image
            }
        }
        DispatchQueue.main.async {
            self.nameLabel?.text = "INFO: \(poke.name.uppercased())"
        }
    }
    
    // UICollectionViewDelegate/ DataSource //
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
        switch self.selection {
        case .moves:
            return self.poke?.moves.count ?? 0
        case .abilities:
            return self.poke?.abilities.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moveCollectionViewCell",
                                                      for: indexPath) as? MoveCollectionViewCell
        
        switch self.selection
        {
            case .moves:
                if(self.poke?.moves[indexPath.row] != nil)
                {
                    cell?.update(moveGroup: (self.poke?.moves[indexPath.row])!)
                }
            case .abilities:
                if(self.poke?.moves[indexPath.row] != nil)
                {
                    cell?.update(abilityGroup: (self.poke?.abilities[indexPath.row])!)
                }
            
        }
        
        return cell ?? UICollectionViewCell()
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // TODO: Load move description
        // move URL > effect entries > effect
        var url = ""
        switch selection {
            case .moves:
                let moveGroup = (self.poke?.moves[indexPath.row])!
                url = moveGroup.move.url
                break
        case .abilities:
                let abilityGroup = (self.poke?.abilities[indexPath.row])!
                url = abilityGroup.ability.url
                break
        }
        
        if(url != "")
        {
            let handler = RequestDetailsHandler()
            handler.makeRequest(url: url,
                                selection: self.selection,
                                delegate: self)
            
        }
    }

    // UICollectionViewDelegateFlowLayout //
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: collectionView.frame.width, height: 30)
    }
    
    // UIPickerView Delegate/ DataSource //
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String?
    {
        return self.pickerArr[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int)
    {
        self.selection = self.pickerArr[row]
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    // DetailsDelegate //
    func detailsRequestSuccess(name: String, string: String)
    {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: name,
                                          message: string,
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK",
                                                                   comment: "Default action"),
                                          style: .default,
                                          handler: { _ in
                                            
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func detailsRequestFailed() {
        // Failed
        
    }
}
