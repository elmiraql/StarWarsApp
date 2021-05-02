//
//  ElementsTableViewController.swift
//  StarWars
//
//  Created by Elmira on 02.04.21.
//

import UIKit

class ElementsTableViewController: UITableViewController {
    
    var netWorkViewController = NetWorkViewController()
    var spinner = UIActivityIndicatorView(style: .large)
    var elements: [Any] = []
    var sentButtonTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(named: "DarkGray")
        netWorkViewController.delegate = self
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        spinner.startAnimating()
        
        self.refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .white
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl!)
        }
        doSomething()
        refreshControl?.addTarget(self, action: #selector(doSomething), for: .valueChanged)
        
      //  tableView.reloadData()
    }
    @objc func doSomething (){
        if let sentTitle = sentButtonTitle{
            title = sentTitle.uppercased()
            netWorkViewController.fetchList(name: sentTitle)
            netWorkViewController.sentEntity = sentButtonTitle
        }
        tableView.reloadData()
        refreshControl?.endRefreshing()
        spinner.stopAnimating()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        switch sentButtonTitle {
        case "people":
            cell.textLabel?.text = (elements[indexPath.row] as? Person)?.name
        case "planets":
            cell.textLabel?.text = (elements[indexPath.row] as? Planet)?.name
        case "starships":
            cell.textLabel?.text = (elements[indexPath.row] as? Starship)?.name
        case "species":
            cell.textLabel?.text = (elements[indexPath.row] as? Species)?.name
        default:
            cell.textLabel?.text = "nothing"
        }
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Courier", size: 25)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToElement", sender: self)
    }

    
    // MARK: - Navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destination = segue.destination as! ElementViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destination.sentButtonTitle = sentButtonTitle
                destination.element = elements[indexPath.row]
        }
    }
}

extension ElementsTableViewController: NetWorkViewControllerDelegate {
    func didSendImage(_ netWorkViewController: NetWorkViewController, data: UIImage) {
        
    }
    func didUpdateData(_ netWorkViewController: NetWorkViewController, data: [Any]) {
        DispatchQueue.main.async {
            self.elements = data
            self.tableView.reloadData()
           // self.spinner.stopAnimating()
        }
    }
    
}
