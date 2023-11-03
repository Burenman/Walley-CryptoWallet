//
//  File.swift
//  Walley
//
//  Created by Viktor on 2023-11-02.
//

import Foundation


struct PortfolioItem: Identifiable, Codable {
    let id = UUID()
    let cryptocurrency: Cryptocurrency
    var quantity: Int
    
    enum CodingKeys: String, CodingKey {
        case id, cryptocurrency, quantity
    }
}

class UserPortfolio: ObservableObject {
    @Published var portfolioItems: [PortfolioItem] = []
    
    init() {
           loadPortfolio()
       }

    func buy(cryptocurrency: Cryptocurrency, quantity: Int) {
        if let index = portfolioItems.firstIndex(where: { $0.cryptocurrency.name == cryptocurrency.name }) {
            portfolioItems[index].quantity += quantity
        } else {
            let newItem = PortfolioItem(cryptocurrency: cryptocurrency, quantity: quantity)
            portfolioItems.append(newItem)
        }
        savePortfolio()
    }

    func sell(cryptocurrency: Cryptocurrency, quantity: Int) {
        if let index = portfolioItems.firstIndex(where: { $0.cryptocurrency.name == cryptocurrency.name }) {
            portfolioItems[index].quantity -= quantity
            if portfolioItems[index].quantity <= 0 {
                portfolioItems.remove(at: index)
            }
            savePortfolio()
        }
    }

    func savePortfolio() {
        // Convert portfolioItems to Data and save to UserDefaults
        if let encodedData = try? JSONEncoder().encode(portfolioItems) {
            UserDefaults.standard.set(encodedData, forKey: "portfolioItems")
        }
    }

    // Function to load portfolioItems from UserDefaults
    func loadPortfolio() {
        if let savedData = UserDefaults.standard.data(forKey: "portfolioItems"),
           let loadedItems = try? JSONDecoder().decode([PortfolioItem].self, from: savedData) {
            portfolioItems = loadedItems
        }
    }
}
