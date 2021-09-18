//
//  ColorTheme.swift
//  Concentration
//
//  Created by Алексей Гребенкин on 05.08.2020.
//  Copyright © 2020 Alex Grebenkin. All rights reserved.
//

import Foundation
import UIKit

struct ColorTheme
{
    var backgroundColor: UIColor?
    var shirtCardColor: UIColor?
    
    var theme: ColorTheme.Theme {
        didSet {
            let (back, shirt) = ColorTheme.settings[theme]!
            self.backgroundColor = back
            self.shirtCardColor  = shirt
        }
    }
    
    var themeIndex: Int {
        var i = 0
        for (index, matchingTheme) in Theme.allCases.enumerated() {
            if self.theme == matchingTheme {
                i = index
            }
        }
        return i
    }
    
    static var themeCount: Int {
        Theme.allCases.count
    }
    
    init(_ theme: Theme? = nil) {
        if theme == nil {
            self.theme = Theme.Gray
            self.backgroundColor = ColorTheme.settings[Theme.Gray]?.0
            self.shirtCardColor = ColorTheme.settings[Theme.Gray]?.1
        } else {
            self.theme = theme!
            self.backgroundColor = ColorTheme.settings[theme!]?.0
            self.shirtCardColor = ColorTheme.settings[theme!]?.1
        }
    }
    
    init(after: Int) {
        if after >= ColorTheme.themeCount - 1 {
            self.init()
        } else {
            self.init(Theme.allCases[after + 1])
        }
    }
    
    enum Theme: CaseIterable {
        case Gray
        case Yellow
        case Winter
        case Animal
        case Transport
        case Stuff
    }
    
    static let settings = [
        Theme.Yellow: (#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) , #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)),
        Theme.Gray: (#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) , #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)),
        Theme.Winter: (#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1) , #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)),
        Theme.Animal: (#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) , #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)),
        Theme.Transport: (#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1) , #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)),
        Theme.Stuff: (#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) , #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1))
    ]
}
