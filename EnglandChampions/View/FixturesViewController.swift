//
//  SecondViewController.swift
//  EnglandChampions
//
//  Created by Admin on 29/06/2019.
//  Copyright © 2019 Cowboy. All rights reserved.
//

import UIKit

class FixturesViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var fixtures: [FixtureModel] = [FixtureModel].init()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reload()
    }
    
    override func selectLeague(leagueId: Int) {
        super.selectLeague(leagueId: leagueId)
        reload()
    }

    func reload() {
        self.showLoadingAnim()
        APIClient.getFixtures(leagueId: selectedLeague, completionHandler: { (res: FixturesResposne?, succ: Bool) in
            if (succ) {
                self.fixtures = res!.api!.fixtures!
                self.collectionView.reloadData()
            }
            self.hideLoadingAnim()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fixtures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fixture_cell", for: indexPath) as! FixtureCell
        let fixture = fixtures[indexPath.item]
        cell.homeName.text = fixture.homeTeam!.teamName!
        cell.homeLogo.setImageFromUrl(urlStr: fixture.homeTeam!.teamLogo!)
        
        cell.awayName.text = fixture.awayTeam!.teamName!
        cell.awayLogo.setImageFromUrl(urlStr: fixture.awayTeam!.teamLogo!)
        cell.scores.text = "" + String(fixture.goalsHomeTeam!) + " : " + String(fixture.goalsAwayTeam!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: collectionView.frame.width, height: 180)
        return size
    }
}

class FixtureCell: UICollectionViewCell {
    @IBOutlet weak var homeLogo: UIImageView!
    @IBOutlet weak var homeName: UILabel!
    @IBOutlet weak var awayLogo: UIImageView!
    @IBOutlet weak var awayName: UILabel!
    @IBOutlet weak var scores: UILabel!
}
