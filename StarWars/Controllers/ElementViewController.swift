//
//  ElementViewController.swift
//  StarWars
//
//  Created by Elmira on 03.04.21.
//

import UIKit

class ElementViewController: UIViewController {
    
    var netWork = NetWorkViewController()
    
    var element: Any!
    var sentButtonTitle: String?
    var elemintID: Int?
    
    var personInfo: [String] = []
    var planetInfo: [String] = []
    var starshipInfo: [String] = []
    var speciesInfo: [String] = []
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var elementImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        netWork.delegate = self
        view.backgroundColor = UIColor(named: "DarkGray")
        table.dataSource = self
        getArray()
        getImage()
    }
    
    func getImage(){
        switch sentButtonTitle {
        case "people":
            if let url = (element as? Person)?.url {
                let id = getId(text: url)
                netWork.getImage(entity: "characters", id: id )
            }
       case "species":
            if let url = (element as? Species)?.url {
                let id = getId(text: url)
                netWork.getImage(entity: "species", id: id)
            }
           
        case "planets":
            if let url = (element as? Planet)?.url {
            let id = getId(text: url)
            netWork.getImage(entity: "planets", id: id)
            }
        case "starships":
            if let url = (element as? Starship)?.url {
            let id = getId(text: url)
            netWork.getImage(entity: "starships", id: id)
            }
        default:
            return
        }
    }

    func getId(text: String) -> String  {
        let string = text as NSString
        let searchPattern = "[0-9]+" //https://swapi.dev/api/species/2/
        let regex = try? NSRegularExpression(pattern: searchPattern)
        let result = regex?.matches(in: text, options: [], range: NSRange(location: 0, length: string.length)).map({
            string.substring(with: $0.range)
        })
        if let id = result {
            return id[0]
        }
        return ""
    }
    
    func getArray(){
        switch sentButtonTitle {
        case "people":
            getPersonData()
        case "planets":
            getPLanetData()
        case "starships":
            getStarshipData()
        case "species":
            getSpeciesData()
        default:
            return
        }
    }
    
    func getPersonData () {
        personInfo.append("Name: " + (element as?  Person)!.name)
        personInfo.append("Gender: " + (element as? Person)!.gender)
        personInfo.append("Birth Year: " + (element as? Person)!.birth_year)
        personInfo.append("Height: " + (element as? Person)!.height)
        personInfo.append("Mass: " + (element as? Person)!.mass)
        personInfo.append("Eye color: " + (element as? Person)!.eye_color)
        personInfo.append("Hair color: " + (element as? Person)!.hair_color)
        personInfo.append("Skin color: " + (element as? Person)!.skin_color)
    }
    
    func getPLanetData(){
        planetInfo.append("Name: " + (element as? Planet)!.name)
        planetInfo.append("Climate: " + (element as? Planet)!.climate)
        planetInfo.append("Population: " + (element as? Planet)!.population)
        planetInfo.append("Diameter: " + (element as? Planet)!.diameter)
        planetInfo.append("Gravity: " + (element as? Planet)!.gravity)
        planetInfo.append("Orbital period: " + (element as? Planet)!.orbital_period)
        planetInfo.append("Rotation period: " + (element as? Planet)!.rotation_period)
        planetInfo.append("Terrain: " + (element as? Planet)!.terrain)
        planetInfo.append("Surface water: " + (element as? Planet)!.surface_water)
    }
    
    func getStarshipData()  {
        starshipInfo.append("Name: " + (element as? Starship)!.name)
        starshipInfo.append("Model: " + (element as? Starship)!.model)
        starshipInfo.append("Starship-class: " + (element as? Starship)!.starship_class)
        starshipInfo.append("Length: " + (element as? Starship)!.length)
        starshipInfo.append("Manufacturer: " + (element as? Starship)!.manufacturer)
        starshipInfo.append("Max atmosphering speed: " + (element as? Starship)!.max_atmosphering_speed)
        starshipInfo.append("Cargo capacity: " + (element as? Starship)!.cargo_capacity)
        starshipInfo.append("Hyperdrive rating: " + (element as? Starship)!.hyperdrive_rating)
        starshipInfo.append("Consumables: " + (element as? Starship)!.consumables)
        starshipInfo.append("Crew: " + (element as? Starship)!.crew)
        starshipInfo.append("Passengers: " + (element as? Starship)!.passengers)
    }
    
    func getSpeciesData() {
        speciesInfo.append("Name: " + (element as? Species)!.name)
        speciesInfo.append("Language: " + (element as? Species)!.language)
        speciesInfo.append("Classification: " + (element as? Species)!.classification)
        speciesInfo.append("Skin colors: " + (element as? Species)!.skin_colors)
        speciesInfo.append("Hair colors: " + (element as? Species)!.hair_colors)
        speciesInfo.append("Eye colors: " + (element as? Species)!.eye_colors)
        speciesInfo.append("Average height: " + (element as? Species)!.average_height)
        speciesInfo.append("Average lifespan: " + (element as? Species)!.average_lifespan)
        speciesInfo.append("Designation: " + (element as? Species)!.designation)
    }
}


extension ElementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sentButtonTitle {
        case "people":
            return personInfo.count
        case "planets":
            return planetInfo.count
        case "starships":
            return starshipInfo.count
        case "species":
            return speciesInfo.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath)
        switch sentButtonTitle {
        case "people":
            cell.textLabel?.text = personInfo[indexPath.row]
        case "planets":
            cell.textLabel?.text = planetInfo[indexPath.row]
        case "starships":
            cell.textLabel?.text = starshipInfo[indexPath.row]
        case "species":
            cell.textLabel?.text = speciesInfo[indexPath.row]
        default:
            cell.textLabel?.text = "nothing"
        }
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Courier", size: 23)
        cell.textLabel!.numberOfLines = 0
        
        return cell
    }
}
extension ElementViewController: NetWorkViewControllerDelegate {
    func didUpdateData(_ netWorkViewController: NetWorkViewController, data: [Any]) {
        
    }
    
    func didSendImage(_ netWorkViewController: NetWorkViewController, data: UIImage) {
        DispatchQueue.main.async {
            self.elementImage.image = data
        }
    }
}
