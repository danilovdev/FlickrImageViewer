//
//  ImagesTableViewController.swift
//  FlickrImageViewer
//
//  Created by Alexey Danilov on 17/09/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import UIKit

class ImagesTableViewController: UITableViewController {
    
    var images = [ImageEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTableView()
        self.configureNavBar()
        self.loadData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
        cell.configure(imageEntity: self.images[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowImageDetails", sender: self)
    }
    
    func configureTableView() {
        self.tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
    }
    
    func loadData() {
        self.images.removeAll()
        
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
                        let mediaDict = item["media"] as! Dictionary<String, AnyObject>
                        let imageURLStr = mediaDict["m"] as! String
                        let title = item["title"] as! String
                        let imageEntity = ImageEntity()
                        imageEntity.title = title
                        imageEntity.imageUrlStr = imageURLStr
                        
                        self.images.append(imageEntity)
                    }
                    
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                    
                }
                
            } catch let error {
                return print(error.localizedDescription)
            }
            
            
            }.resume()
    }
    
    func configureNavBar() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        let refreshButton = UIButton(type: .system)
        refreshButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let refreshImage = UIImage(named: "ic_refresh_white_48pt")
        refreshButton.setImage(refreshImage, for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        let refreshBarButton = UIBarButtonItem(customView: refreshButton)
        self.navigationItem.setRightBarButtonItems([refreshBarButton], animated: false)
    }
    
    @objc func refreshButtonTapped() {
        self.loadData()
    }

}
