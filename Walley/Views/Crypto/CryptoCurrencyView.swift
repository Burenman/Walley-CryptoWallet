//
//  CryptoCurrencyView.swift
//  Walley
//
//  Created by Viktor on 2023-11-02.
//

import SwiftUI

struct CryptocurrencyView: View {
    var cryptocurrency: Cryptocurrency
    
    var body: some View {
        VStack {
            Image(cryptocurrency.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 10)
            
            Text(cryptocurrency.name)
                .font(.headline)
                .padding(.top, 10)
            
            Text(cryptocurrency.price)
                .font(.subheadline)
                .foregroundColor(.green)
        }
        .frame(width: 150, height: 200)
        .background(RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color.white.opacity(0.3)))
    }
}



#Preview {
    CryptocurrencyView(cryptocurrency: Cryptocurrency(name: "Bitcoin", logo: "bitcoin_logo", price: "$50,000", monthlyGrowth: 20))
}
