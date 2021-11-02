//
//  InfoCard.swift
//  Dailys
//
//  Created by Caco Ossandon on 01-11-21.
//  Copyright © 2021 Apple. All rights reserved.
//

import SwiftUI

struct InfoCard: View {
    var name: String
    var value: Double
    var variation: Double = 0
    var currency: Bool = true
    var customEmoji: String = ""
    
    func formatCurrency(for value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currencyPlural
        numberFormatter.locale = Locale(identifier: "es_CL@currency=CLP")
        
        let number = NSNumber(value: value)
        return (numberFormatter.string(from: number)?.components(separatedBy: " ")[0])!
    }
    
    fileprivate func conditionalValue() -> Text {
        let number = formatCurrency(for: value)
        
        if currency {
            return Text("$\(number)")
        }
        
        return Text("\(number)")
    }
    
    fileprivate func conditionalVariation() -> Text {
        let number = NSString(format: "%.3f", variation)

        if variation > 0 {
            return Text("+\(number)%")
                .foregroundColor(.green)
        } else {
            return Text("-\(number)%")
                .foregroundColor(.red)
        }
    }
    
    var body: some View {
        let symbol = variation > 0 ? "📈" : "📉"
        let text = customEmoji != "" ? "\(customEmoji) \(name)" : "\(symbol) \(name)"

        VStack {
            Text(text)
                .font(.title)
                .fontWeight(.medium)
                .padding(.bottom, 5)
            HStack {
                conditionalValue().font(.headline).padding(.bottom, 1)
                if variation != 0 {
                    conditionalVariation().font(.callout)
                }
            }

        }
        .frame(width: 200, height: 100)
        .padding(25)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}
    
struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InfoCard(name: "Dólar", value: 800.01, variation: 0.03)
            InfoCard(name: "Saldo BIP", value: 12220)
        }
    }
}
