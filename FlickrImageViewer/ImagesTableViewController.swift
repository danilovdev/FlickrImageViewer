//
//  ImagesTableViewController.swift
//  FlickrImageViewer
//
//  Created by Alexey Danilov on 17/09/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import UIKit

class ImagesTableViewController: UITableViewController {
    
    var images = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        let flickrURLStr = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tagmode=any&nojsoncallback=1"
        
        let flickrURL = URL(string: flickrURLStr)
        
        let session = URLSession.shared
        
        session.dataTask(with: flickrURL!) { (data, response, error) in
            
            guard error == nil else {
                return print(error!.localizedDescription)
            }
            guard let data = data else {
                return print(error?.localizedDescription ?? "There are no new Items to show")
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                    
                    guard let itemsJsonArray = json["items"] as? [[String: AnyObject]] else {
                        return print("There are no new Items to show")
                    }
                    
                    for item in itemsJsonArray {
                        let itemDictionary = item as Dictionary<String, AnyObject>
                        let title = itemDictionary["title"] as! String
                        self.images.append(title)
                    }
                    
//                    print(itemsJsonArray)
                    DispatchQueue.main.async {
//                        completion(.Success(itemsJsonArray))
                        self.tableView.reloadData()
                    }
                    
                    
                }
                
            } catch let error {
                return print(error.localizedDescription)
            }

            
        }.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)
        cell.textLabel?.text = self.images[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowImageDetails", sender: self)
    }

}
