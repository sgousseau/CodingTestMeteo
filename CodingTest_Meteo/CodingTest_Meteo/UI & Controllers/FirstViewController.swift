//
//  FirstViewController.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    @IBOutlet weak var refreshButton:       UIButton!
    @IBOutlet weak var globalWeatherImage:  UIImageView!
    @IBOutlet weak var tempValueLabel:      UILabel!
    @IBOutlet weak var windValueLabel:      UILabel!
    @IBOutlet weak var cloudsValueLabel:    UILabel!
    @IBOutlet weak var humidityValueLabel:  UILabel!
    @IBOutlet weak var pressureValueLabel:  UILabel!
    @IBOutlet weak var globalInfosView:     UIView!
    @IBOutlet weak var collectionView:      UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    
    }
    
    // MARK: - Collection Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
    }
}
