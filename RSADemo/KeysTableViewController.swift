//
//  KeysTableViewController.swift
//  RSADemo
//
//  Created by Prathamesh Kowarkar on 09/06/19.
//  Copyright © 2019 Prathamesh Kowarkar. All rights reserved.
//

import UIKit

class KeysTableViewController: UITableViewController {
    
    var keyPairs = [KeyPair]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "Cell"
        )
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keyPairs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = keyPairs[indexPath.row].title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyPair = keyPairs[indexPath.row]
        let alertController = UIAlertController(
            title: keyPair.title,
            message: """
            Public Key:
            \(String(describing: keyPair.publicKey))
            
            Private Key:
            \(String(describing: keyPair.privateKey))
            """,
            preferredStyle: .alert)
        let dismissAction = UIAlertAction(
            title: "Dismiss",
            style: .default
        ) { [weak tableView = self.tableView] _ in
            tableView?.deselectRow(at: indexPath,animated: true)
        }
        alertController.addAction(dismissAction)
        alertController.preferredAction = dismissAction
        present(alertController, animated: true)
    }
    
    @IBAction func didTouchUp(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(
            title: "Add New Key",
            message: "Enter title",
            preferredStyle: .alert
        )
        alertController.addTextField { $0.placeholder = "Title" }
        let addAction = UIAlertAction(
            title: "Add",
            style: .default) { [weak self, weak alertController] action in
                
                guard
                    let self = self,
                    let titleText = alertController?.textFields?.first?.text,
                    !self.keyPairs.contains(where: { $0.title == titleText }),
                    let keyPair = KeyPair(withTitle: titleText)
                else { return }
                
                self.keyPairs.append(keyPair)
                self.tableView?.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel",style: .cancel)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        alertController.preferredAction = addAction
        
        present(alertController, animated: true)
    }

}
