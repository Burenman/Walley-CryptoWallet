import SwiftUI

struct Dashboard: View {
    @State private var isSheetPresented = false
    @State private var selectedCrypto: Cryptocurrency?
    @ObservedObject var userPortfolio = UserPortfolio()
    @State private var isCryptoSelected = false

    
    let cryptocurrencies: [Cryptocurrency] = [
        Cryptocurrency(name: "Bitcoin", logo: "Bitcoin", price: "$50,000", monthlyGrowth: -35),
        Cryptocurrency(name: "Ethereum", logo: "Ethereum", price: "$3,500", monthlyGrowth: 50),
        Cryptocurrency(name: "Litecoin", logo: "Litecoin", price: "$180", monthlyGrowth: -29),
        Cryptocurrency(name: "Xrp", logo: "Xrp", price: "$0.75", monthlyGrowth: 30),
        Cryptocurrency(name: "Cardano", logo: "Cardano", price: "$200", monthlyGrowth: 25),
        Cryptocurrency(name: "Dogecoin", logo: "dogecoin", price: "$0.30", monthlyGrowth: 7)
    ]
    
    
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(cryptocurrencies.sorted {$0.price > $1.price}, id: \.name) { crypto in
                                CryptocurrencyView(cryptocurrency: crypto)
                                    .onTapGesture {
                                        isCryptoSelected = true
                                        selectedCrypto = crypto
                                        
                                    }
                            }
                        }
                        .padding()
                    }
                   
                    
                   
                    HStack {
                        Text("Your Portfolio:")
                            .padding([.top, .leading], 20)
                            .font(.title2.bold())
                            Spacer()
                    }
                    .padding(.bottom, -10)
                    
                    ZStack {
                        
                        Rectangle()
                                .foregroundColor(Color.white.opacity(0.4))
                                .cornerRadius(20)
                        
                        VStack {
                           
                            if !userPortfolio.portfolioItems.isEmpty {
                                List {
                                    ForEach(userPortfolio.portfolioItems, id: \.id) { portfolioItem in
                                        UserPortfolioRow(userPortfolio: userPortfolio, cryptocurrency: portfolioItem.cryptocurrency)
                                            .listRowBackground(Color.clear)
                                            .cornerRadius(20)
                                            .onTapGesture {
                                                selectedCrypto = portfolioItem.cryptocurrency
                                            }
                                    }
                                    .onDelete { indices in
                                        userPortfolio.portfolioItems.remove(atOffsets: indices)
                                        userPortfolio.savePortfolio()
                                    }
                                }
                                .scrollIndicators(.hidden)
                                .listStyle(.plain)
                            } else {
                                Image(systemName: "bag.badge.plus")
                                           .resizable()
                                           .aspectRatio(contentMode: .fit)
                                           .frame(width: 70, height: 70)
                                           .foregroundColor(.gray)
                                           
                                       Text("Add your first Crypto")
                                           .font(.title3.bold())
                                           .foregroundColor(.gray)
                                
                            }
                            
                            
                        }
                    }
                    .padding()
                        Spacer()
                    }
                
            }
            .navigationTitle("Hello, you!")
            .onChange(of: selectedCrypto) { newValue in
                            if newValue != nil {
                                isSheetPresented = true
                            }
                        }
        }
        .sheet(isPresented: $isSheetPresented) {
            if let crypto = selectedCrypto {
                CryptoDetailsView(sum: userPortfolio, cryptocurrency: crypto)
                    .presentationDetents([.medium])
                    .transition(.slide)
                    .onDisappear {
                        selectedCrypto = nil // Set selectedCrypto to nil when the sheet disappears
                        isCryptoSelected = false
                        print("Sheet is closed")
                    }
            } 
        }


    }
    
    
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
