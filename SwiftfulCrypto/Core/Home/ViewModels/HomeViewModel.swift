//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Sivaram Yadav on 11/25/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
/*
     =
        [
            StatisticModel(title: "title", value: "value", percentageChange: 1),
            StatisticModel(title: "title", value: "value"),
            StatisticModel(title: "title", value: "value"),
            StatisticModel(title: "title", value: "value", percentageChange: -7)
        ]
*/
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let coinDataService     = CoinDataService()
    private let marketDataService   = MarketDataService()
    private var cancellables        = Set<AnyCancellable>()
    
    init() {
        
       // DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
       //     self.allCoins.append(DeveloperPreview.instance.coin)
       //     self.portfolioCoins.append(DeveloperPreview.instance.coin)
       // }
        
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        // as below subscriber will work like same way as:
        // to update allcoins array
        // so put comment this code, no need to write twice here
        /*
        coinDataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        */
        
        // updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink(receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            })
            .store(in: &cancellables)
        
        // updates marketData
        marketDataService.$marketData
            .map(mapMarketGlobalData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
    }
    
    func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        // make code little cleaner like below:
        /*
        let lowercasedText = text.lowercased()

        let filteredCoins = startingCoins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
                coin.symbol.lowercased().contains(lowercasedText) ||
                coin.id.lowercased().contains(lowercasedText)
        }

        return filteredCoins
         */
        
        let lowercasedText = text.lowercased()

        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
                coin.symbol.lowercased().contains(lowercasedText) ||
                coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    func mapMarketGlobalData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
        
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap       = StatisticModel(title: "Market Cap",
                                             value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume          = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance    = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolio       = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        return stats
    }
    
    
    
    
    
    
    
    
    
    
}
