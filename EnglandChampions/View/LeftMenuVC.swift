//
//  LeftMenuVC.swift
//  EnglandChampions
//
//  Created by Admin on 30/06/2019.
//  Copyright © 2019 Cowboy. All rights reserved.
//

import UIKit
import SideMenuSwift

class LeftMenuVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var leaguesView: UITableView!
    
    var leagueIds = [2, 3]
    var leagueLogoBasePath = "https://www.api-football.com/public/leagues/"
    var leagueNames = ["Premier League (2018-2019)", "Championship (2018-2019)"]
    var lastSelected: IndexPath?
    
    override func viewDidLoad() {
        lastSelected = IndexPath.init(row: 0, section:0)
        leaguesView.selectRow(at: lastSelected, animated: false, scrollPosition: .top)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "league_cell") as! LeagueCell
        cell.leagueName.text = leagueNames[indexPath.item]
        cell.leagueLogo.setImageFromUrl(urlStr: leagueLogoBasePath + String(leagueIds[indexPath.item]) + ".png")
        if (indexPath.item == tableView.indexPathForSelectedRow?.item) {
            cell.leagueName.textColor = UIColor.black
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let sideMenu = appDelegate.window?.rootViewController as! SideMenuController
        let tabVC = sideMenu.contentViewController as! UITabBarController
        let navVC = tabVC.selectedViewController as! UINavigationController
        let contentVC = navVC.visibleViewController as! BaseViewController
        contentVC.selectLeague(leagueId: leagueIds[indexPath.item])
        sideMenu.hideMenu()
        if (lastSelected != nil) {
            let cell = tableView.cellForRow(at: lastSelected!) as! LeagueCell
            cell.leagueName.textColor = UIColor.white
        }
        let cell = tableView.cellForRow(at: indexPath) as! LeagueCell
        cell.leagueName.textColor = UIColor.black
        lastSelected = indexPath
    }
}

class LeagueCell: UITableViewCell {
    @IBOutlet weak var leagueLogo: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
}
