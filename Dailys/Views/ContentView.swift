/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing the list of landmarks.
*/

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var dolarState: Result<[DolarData]>?
    @State private var bipState: Result<BipData>?
    @State private var bitcoinState: Result<BitcoinData>?
    @State private var covidState: Result<CovidData>?
    @State private var covidStats: CovidStats?
    
    var body: some View {
        NavigationView {
            ScrollView {
                PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                    dolarState = nil
                    bipState = nil
                    bitcoinState = nil
                    covidState = nil
                }
                
                VStack(spacing: 25) {
                    switch dolarState {
                    case .success(let data):
                        InfoCard(name: "Dólar", value: data[0].cp, variation: data[0].variacion_porcentual / 100)
                    case .failure(let error):
                        ErrorCard(name: "Dólar", error: error.localizedDescription)
                    case nil:
                        ProgressView().onAppear(perform: loadDolar)
                            .frame(width: 200, height: 100)
                            .padding(25)
                            .background(Color(UIColor.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    
                    switch bitcoinState {
                    case .success(let data):
                        InfoCard(name: "Bitcoin", value: Double(data.ticker.last_price[0])!, variation: Double(data.ticker.price_variation_24h)!)
                    case .failure(let error):
                        ErrorCard(name: "Bitcoin", error: error.localizedDescription)
                    case nil:
                        ProgressView().onAppear(perform: loadBitcoin)
                            .frame(width: 200, height: 100)
                            .padding(25)
                            .background(Color(UIColor.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    
                    switch bipState {
                    case .success(let data):
                        InfoCard(name: "Saldo Bip", value: data.balance, customEmoji: "💳")
                    case .failure(let error):
                        ErrorCard(name: "Saldo Bip", error: error.localizedDescription)
                    case nil:
                        ProgressView().onAppear(perform: loadBip)
                            .frame(width: 200, height: 100)
                            .padding(25)
                            .background(Color(UIColor.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    
                    
                    switch covidState {
                    case .success(_):
                        InfoCard(name: "Casos Covid", value: covidStats!.value, variation: covidStats!.variation, currency: false, customEmoji: "🦠")
                    case .failure(let error):
                        ErrorCard(name: "Casos Covid", error: error.localizedDescription)
                    case nil:
                        ProgressView().onAppear(perform: loadCovid)
                            .frame(width: 200, height: 100)
                            .padding(25)
                            .background(Color(UIColor.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    
                    Spacer()
                }.padding(.top)
            }
            .coordinateSpace(name: "pullToRefresh")
            .navigationTitle("Cool indicators 😎")
        }
    }
    
    private func loadDolar() {
        dataRequest(with: "https://apps.bolchile.com/api/v1/dolarstatd2", objectType: [DolarData].self) { (result: Result) in
            dolarState = result
        }
    }
    
    private func loadBip() {
        dataRequest(with: "https://api.xor.cl/red/balance/67386943", objectType: BipData.self) { (result: Result) in
            bipState = result
        }
    }
    
    private func loadBitcoin() {
        dataRequest(with: "https://www.buda.com/api/v2/markets/btc-clp/ticker", objectType: BitcoinData.self) { (result: Result) in
            bitcoinState = result
        }
    }
    
    private func loadCovid() {
        dataRequest(with: "https://atlas.jifo.co/api/connectors/bd112518-e1e6-47da-9b2e-d51c6b866e6e", objectType: CovidData.self) { (result: Result) in
            switch result {
            case .success(let data):
                let values = data.data[0]
                let last = Double((values.last![1]))
                let penultimate = Double(values[values.count - 2][1])
                
                covidStats = CovidStats(value: last!, variation: (last! - penultimate!) / last! / 100)

            default: break
            }
            
            covidState = result
        }
    }
}
