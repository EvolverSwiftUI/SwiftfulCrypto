//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by Sivaram Yadav on 11/28/21.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailDataService.$coinDetails
            .sink { (returnedCoinDetails) in
                print("RECEIVED COIN DETAIL DATA.")
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
    }
}
