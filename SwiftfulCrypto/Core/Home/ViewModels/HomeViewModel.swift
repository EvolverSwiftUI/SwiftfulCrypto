//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Sivaram Yadav on 11/25/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
       // DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
       //     self.allCoins.append(DeveloperPreview.instance.coin)
       //     self.portfolioCoins.append(DeveloperPreview.instance.coin)
       // }
        
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
