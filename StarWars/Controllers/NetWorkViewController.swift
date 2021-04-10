//
//  NetWorkViewController.swift
//  StarWars
//
//  Created by Elmira on 02.04.21.
//

import UIKit

protocol NetWorkViewControllerDelegate {
    func didUpdateData(_ netWorkViewController: NetWorkViewController, data: [Any])
    func didSendImage(_ netWorkViewController: NetWorkViewController, data: UIImage)
}

class NetWorkViewController: UIViewController {
    
    let baseUrl = "https://swapi.dev/api/"
    let baseImageUrl = "https://starwars-visualguide.com/assets/img/"
    var delegate: NetWorkViewControllerDelegate?
    var sentEntity: String?
    var data: [Any] = []
    
    func fetchList (name: String) {
        //   let urlString = "\(baseUrl)\(name)/?page=2"
        //  performeRequest(urlString: urlString)
        sentEntity = name
        let strings: [String] = [
            "\(baseUrl)\(name)/?page=1",
            "\(baseUrl)\(name)/?page=2",
            "\(baseUrl)\(name)/?page=3",
            "\(baseUrl)\(name)/?page=4",
            "\(baseUrl)\(name)/?page=5",
            "\(baseUrl)\(name)/?page=6",
            "\(baseUrl)\(name)/?page=7",
            "\(baseUrl)\(name)/?page=8",
            "\(baseUrl)\(name)/?page=9"
 ]
            for string in strings {
                self.performeRequest(urlString: string)
            }
    }

    func getImage(entity: String, id: String) {
        let urlString = "\(baseImageUrl)\(entity)/\(id).jpg"
        if let url = URL(string: urlString) {
            do {
                let data = try Data(contentsOf: url)
                guard let imageData = UIImage(data: data) else { return }
                self.delegate?.didSendImage(self, data: imageData)
            } catch {
                print(error)
            }
        }
    }
    
    func performeRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                if let safeData = data {
                    if let entityData = self.parseJson( data: safeData) {//entData is an array of 10 elements
                        //self.delegate?.didUpdateData(self, data: entityData )
                        for el in entityData {
                            if el != nil {
                                self.data.append(el)
                            }
                        }
                        self.delegate?.didUpdateData(self, data: self.data)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(data: Data) -> [Any]? {
        let decoder = JSONDecoder()
        if sentEntity == "people" {
            do {
                let results = try decoder.decode(PersonData.self, from: data)
                return results.results
            } catch {
                print(error)
                return nil
            }
        } else if sentEntity == "planets" {
            do {
                let results = try decoder.decode(PlanetData.self, from: data)
                return results.results
            } catch {
                print(error)
                return nil
            }
        } else if sentEntity == "species" {
            do {
                let results = try decoder.decode(SpeciesData.self, from: data)
                return results.results
            } catch {
                print(error)
                return nil
            }
        } else if sentEntity == "starships" {
            do {
                let results = try decoder.decode(StarshipsData.self, from: data)
                return results.results
            } catch {
                print(error)
                return nil
            }
        } else {
            return nil
        }
    }
}
