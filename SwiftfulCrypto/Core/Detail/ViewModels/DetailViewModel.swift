//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by Sivaram Yadav on 11/28/21.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics   : [StatisticModel]   = []
    @Published var additionalStatistics : [StatisticModel]   = []

    @Published var coin: CoinModel
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailDataService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStats)
            .sink { [weak self] (returnedArrays) in
                guard let self = self else { return }
                self.overviewStatistics    = returnedArrays.overview
                self.additionalStatistics  = returnedArrays.additional
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStats(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        
        let overviewArray   = createOverviewArray(coinModel: coinModel)
        let additionalArray = createAdditionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
        
        return (overviewArray, additionalArray)
    }
    
    private func createOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
        
        let price                   = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange      = coinModel.priceChangePercentage24H
        let priceStat               = StatisticModel(title: "Price Change", value: price, percentageChange: pricePercentChange)
                
        let marketCap               =  "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange  = coinModel.marketCapChangePercentage24H
        let marketStat              = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)

        let rank                    = "\(coinModel.rank)"
        let rankStat                = StatisticModel(title: "Rank", value: rank)
                
        let volume                  = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat              = StatisticModel(title: "Volume", value: volume)
            
        let overviewArray: [StatisticModel] = [
            priceStat, marketStat, rankStat, volumeStat
        ]
        
        return overviewArray
    }
    
    private func createAdditionalArray(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> [StatisticModel] {
        
        let high                    = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat                = StatisticModel(title: "24h High", value: high)
                
        let low                     = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat                 = StatisticModel(title: "24h Low", value: low)
                
        let priceChange             = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange      = coinModel.priceChangePercentage24H
        let priceChangeStat         = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)

        let marketCapChange         = "$" + (coinModel.marketCapChange24H?.asCurrencyWith6Decimals() ?? "")
        let marketCapPercentChange  = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat     = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
        
        let blockTime               = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString         = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockTimeStat           = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing                 = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat             = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray: [StatisticModel] = [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockTimeStat, hashingStat
        ]
        
        return additionalArray
    }
}
