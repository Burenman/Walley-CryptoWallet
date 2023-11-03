//
//  UserPortfolio.swift
//  Walley
//
//  Created by Viktor on 2023-11-02.
//


import SwiftUI

struct UserPortfolioRow: View {
    @ObservedObject var userPortfolio: UserPortfolio
    var cryptocurrency: Cryptocurrency
    
    var body: some View {
        HStack {
            Image(cryptocurrency.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 1)
            VStack(alignment: .leading){
                Text("You own")
                if let portfolioItem = userPortfolio.portfolioItems.first(where: { $0.cryptocurrency.name == cryptocurrency.name }) {
                    let quantity = portfolioItem.quantity
                    let cryptocurrencyName = quantity == 1 ? "\(cryptocurrency.name)" : "\(cryptocurrency.name)s"
                    Text("\(portfolioItem.quantity) \(cryptocurrencyName)")
                        .foregroundStyle(.secondary)
                } else {
                    Text("0 of \(cryptocurrency.name)")
                        .foregroundStyle(.secondary)
                }
                
            }
            
            Spacer()
            VStack(alignment: .trailing) {
                Text("Total Amount")
                if let portfolioItem = userPortfolio.portfolioItems.first(where: { $0.cryptocurrency.name == cryptocurrency.name }) {
                    let totalAmount = Double(portfolioItem.quantity) * cryptocurrency.numericPrice
                    Text("$\(totalAmount, specifier: "%.2f")")
                        .font(.subheadline.bold())
                        .foregroundStyle(.green)
                } else {
                    Text("0.00")
                        .font(.subheadline.bold())
                        .foregroundStyle(.green)
                }
            }
        }
        .padding()
    }
}

struct UserPortfolioRow_Previews: PreviewProvider {
    static var previews: some View {
        let userPortfolio = UserPortfolio()
        userPortfolio.portfolioItems = [
            PortfolioItem(cryptocurrency: Cryptocurrency(name: "Bitcoin", logo: "Bitcoin", price: "$50,000", monthlyGrowth: -20), quantity: 1)
        ]
        
        return UserPortfolioRow(userPortfolio: userPortfolio, cryptocurrency: Cryptocurrency(name: "bitcoin", logo: "Bitcoin", price: "$50,000", monthlyGrowth: -20))
    }
}


//struct UserPortfolioRow: View {
//    @ObservedObject var sum = UserPotfolioSum()
//    var cryptocurrency: Cryptocurrency
//    
//    var totalAmount: Double {
//        return Double(sum.amount) * cryptocurrency.numericPrice
//        }
//    
//    var currencyFormatter: NumberFormatter {
//            let formatter = NumberFormatter()
//            formatter.numberStyle = .currency
//            return formatter
//        }
//        
//        var formattedTotalAmount: String {
//            return currencyFormatter.string(from: NSNumber(value: totalAmount)) ?? ""
//        }
//    
//    var body: some View {
//        
//        HStack {
//            Image(cryptocurrency.logo)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 40, height: 40)
//                .clipShape(Circle())
//                .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                .shadow(radius: 1)
//            VStack(alignment: .leading){
//                Text("You own")
//                Text ("\(sum.amount) of \(cryptocurrency.name)")
//                    .foregroundStyle(.secondary)
//            }
//            
//            Spacer()
//            VStack(alignment: .trailing) {
//                Text("Total Amount")
//                Text(formattedTotalAmount)
//                    .font(.subheadline.bold())
//                    .foregroundStyle(.green)
//            }
//        }
//        .padding()
//    }
//    
//    
//}

