//
//  ViewController.swift
//  Protect-RestAPI
//
//  Created by Amit Bhujbal on 25/02/2026.
//

import UIKit

struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let category: String
    let description: String
    let image: String
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        fetchProducts()
    }

    //MARK: Fetch URL Link
    func fetchProducts() {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decodeData = try JSONDecoder().decode([Product].self, from: data)
                    self.products = decodeData
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }

    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as!
            ProductTableViewCell
        
        let product = products[indexPath.row]
        cell.titleLabel.text = product.title
        cell.priceLabel.text = "$\(product.price)"
        cell.categoryLabel.text = product.category
        
        if let imageURL = URL(string: product.image) {
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.productImageView.image = image
                    }
                }
            }.resume()
        }
        return cell
    }
}

