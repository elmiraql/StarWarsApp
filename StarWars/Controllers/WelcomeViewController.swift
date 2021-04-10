//
//  ViewController.swift
//  StarWars
//
//  Created by Elmira on 01.04.21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    var currentButtonTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in buttons {
            button.layer.cornerRadius = 15
            button.backgroundColor = UIColor(named: "DarkGray")
            button.titleLabel?.font = UIFont(name: "Courier", size: 25)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func categoryButtonPressed(_ sender: UIButton) {
        guard let buttonTitle = sender.currentTitle?.lowercased() else {
            return
        }
        currentButtonTitle = buttonTitle
        performSegue(withIdentifier: "goToList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ElementsTableViewController
        destinationVC.sentButtonTitle = currentButtonTitle
        
    }
}


