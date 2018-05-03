//
//  HighScoreTableViewController.swift
//  dream-puff
//
//  Created by Makenzie Elliott on 5/2/18.
//  Copyright © 2018 Makenzie Elliott. All rights reserved.
//

import UIKit

class HighScoreTableViewController: UITableViewController {
    
    var highScores: [String] = ["300", "200", "100"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "High Scores"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create the table view by pulling what is in the alarm list
        let tableViewCell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: String("id: \(indexPath.row)"))
        tableViewCell.textLabel?.text = highScores[indexPath.row]
        return tableViewCell
    }
}
