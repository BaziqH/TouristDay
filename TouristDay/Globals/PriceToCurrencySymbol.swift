//********** Developed by Drudots Technology **********//
//******* https://www.drudotstech.com **********//

class PriceToCurrencySymbol{
    
    func priceString(level: Int?, regionCode: String?) -> String? {
        guard let level, level > 0 else { return nil }

        var symbol = "$"
        if let region = regionCode {
            switch region {
            case "CN": symbol = "¥"   // English locale gives "CN¥"
            case "PK": symbol = "₹"
            default:
                if let s = Locale(identifier: "en_\(region)").currencySymbol,
                   s.count == 1, s != "¤" {
                    symbol = s
                }
            }
        }
        return String(repeating: symbol, count: level)
    }
    
}
