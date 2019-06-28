//
//  Card.swift
//  Novus
//
//  Created by Reuben Catchpole on 28/06/19.
//  Copyright © 2019 PolarTeam. All rights reserved.
//

import SwiftUI

struct Card : View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8).foregroundColor(Color("BlankCardColors"))
    }
}

#if DEBUG
struct Card_Previews : PreviewProvider {
    static var previews: some View {
        Card()
    }
}
#endif
