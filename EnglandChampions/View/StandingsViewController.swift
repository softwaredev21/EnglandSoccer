//
//  FirstViewController.swift
//  EnglandChampions
//
//  Created by Admin on 29/06/2019.
//  Copyright © 2019 Cowboy. All rights reserved.
//

import UIKit

class StandingsViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var standings: [StandingModel] = [StandingModel].init()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        reload()
    }
    
    override func selectLeague(leagueId: Int) {
        super.selectLeague(leagueId: leagueId)
        reload()
    }
    
    func reload() {
        self.showLoadingAnim()
        APIClient.getStandings(leagueId: selectedLeague, completionHandler: { (res: StandingsResponse?, succ: Bool) in
            if (succ) {
                self.standings.removeAll()
                for item in res!.api!.standings! {
                    for model in item {
                        self.standings.append(model)
                    }
                }
                self.collectionView.reloadData()
            }
            self.hideLoadingAnim()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: collectionView.frame.width, height: 120)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return standings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StandingViewCell
        let standing = standings[indexPath.item]
        cell.logo.setImageFromUrl(urlStr: standing.logo!)
        cell.name.text = standing.teamName!
        cell.rank.text = String.init(format: "%d", standing.rank!)
        cell.standing = standing
        return cell
    }
}

class StandingViewCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var players: UIButton!
    
    weak var standing: StandingModel!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "text_cell", for: indexPath) as! TextViewCell
        //cell.txtView.text = standing.points
        let sectionNames = ["Win", "Draw", "Lose", "PTS"]
        let rowNames = ["Total", "Home", "Away"]
        if (indexPath.item > 0) {
            if (indexPath.item<5) {
                cell.txtView.text = sectionNames[indexPath.item-1]
            } else {
                if (indexPath.item%5 == 0) {
                    cell.txtView.text = rowNames[indexPath.item/5-1]
                } else {
                    cell.txtView.text = String(standing.points!)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: (collectionView.frame.width-18)/5, height: (collectionView.frame.height-16)/4)
        return size
    }
}

class TextViewCell: UICollectionViewCell {
    @IBOutlet weak var txtView: UILabel!
}
