//
//  CryptoCurrency.swift
//  Walley
//
//  Created by Viktor on 2023-11-02.
//

import Foundation

struct Cryptocurrency: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var logo: String
    var price: String
    var monthlyGrowth: Int
    
    
    var numericPrice: Double {
          let cleanedPrice = price.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: "")
          return Double(cleanedPrice) ?? 0.0
      }
}

