import SwiftUI

struct CryptoDetailsView: View {
    @ObservedObject var sum: UserPortfolio
    
    var cryptocurrency: Cryptocurrency
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack {
                Image(cryptocurrency.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 10)
                
                Text(cryptocurrency.name)
                    .font(.largeTitle.bold())
                    .padding(.bottom, -10)
                
                HStack {
                    Text("You now own:")
                        .font(.title3)
                    if let portfolioItem = sum.portfolioItems.first(where: { $0.cryptocurrency.name == cryptocurrency.name }) {
                        let quantity = portfolioItem.quantity
                        let cryptocurrencyName = quantity == 1 ? "\(cryptocurrency.name)" : "\(cryptocurrency.name)s"
                        Text("\(portfolioItem.quantity) of \(cryptocurrencyName)")
                            .font(.title3.bold())
                    } else {
                        Text("0 of \(cryptocurrency.name)s")
                            .font(.title3.bold())
                            
                    }
                    
                }
                .padding()
                
                VStack {
                    HStack {
                        Text("Current Price")
                            .font(.title3)
                        Spacer()
                        Text(cryptocurrency.price)
                            .foregroundStyle(.green)
                            .font(.title3.bold())
                    }
                    
                    HStack {
                        Text("Monthly Growth")
                            .font(.title3)
                        Spacer()
                        Text("\(cryptocurrency.monthlyGrowth) %")
                            .foregroundStyle(cryptocurrency.monthlyGrowth < 0 ? Color.red : Color.green)
                    }
                    .font(.title3.bold())
                }
                .padding(.horizontal)
                
                HStack(spacing: 20) {
                    Button(action: {
                        sum.buy(cryptocurrency: cryptocurrency, quantity: 1)
                        print("Bought \(cryptocurrency.name)")
                    }) {
                        Text("Buy Now")
                            .frame(width: 120)
                    }
                    .buttonStyle(GrowingButton(color: .green, width: 150))
                    
                    Button(action: {
                        sum.sell(cryptocurrency: cryptocurrency, quantity: 1)
                        print("Sold \(cryptocurrency.name)")
                    }) {
                        Text("Sell Now")
                            .frame(width: 120)
                    }
                    .buttonStyle(GrowingButton(color: .red, width: 150))
                }
                .padding()
                
                Spacer()
            }
            .padding(30)
        }
    }
    
    struct GrowingButton: ButtonStyle {
        let color: Color
        let width: CGFloat
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(15)
                .frame(width: width)
                .scaleEffect(configuration.isPressed ? 1.3 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let userPortfolioSum = UserPortfolio()
        return CryptoDetailsView(sum: userPortfolioSum, cryptocurrency: Cryptocurrency(name: "bitcoin", logo: "Bitcoin", price: "$50,000", monthlyGrowth: -20))
    }
}
