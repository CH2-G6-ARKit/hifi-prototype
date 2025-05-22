//
//  Fonts.swift
//  onetreasure
//
//  Created by Stephanie Staniswinata on 21/05/25.
//

import SwiftUI

extension Font {
    
    // MARK: - Londrina Solid Regular
    static var londrinaLargeTitle: Font {
        .custom("LondrinaSolid-Regular", size: 34)
    }
    
    static var londrinaTitle: Font {
        .custom("LondrinaSolid-Regular", size: 28)
    }
    
    static var londrinaHeadline: Font {
        .custom("LondrinaSolid-Regular", size: 17)
    }

    static var londrinaBody: Font {
        .custom("LondrinaSolid-Regular", size: 17)
    }

    static var londrinaCallout: Font {
        .custom("LondrinaSolid-Regular", size: 16)
    }

    static var londrinaFootnote: Font {
        .custom("LondrinaSolid-Regular", size: 13)
    }

    static var londrinaCaption: Font {
        .custom("LondrinaSolid-Regular", size: 12)
    }
    
    // MARK: - Londrina Solid Light
    static var londrinaLightTitle: Font {
        .custom("LondrinaSolid-Light", size: 28)
    }

    static var londrinaLightBody: Font {
        .custom("LondrinaSolid-Light", size: 17)
    }

    // MARK: - Londrina Solid Black
    static var londrinaBlackTitle: Font {
        .custom("LondrinaSolid-Black", size: 28)
    }

    static var londrinaBlackBody: Font {
        .custom("LondrinaSolid-Black", size: 17)
    }

    // MARK: - Londrina Solid Thin
    static var londrinaThinTitle: Font {
        .custom("LondrinaSolid-Thin", size: 28)
    }

    static var londrinaThinCaption: Font {
        .custom("LondrinaSolid-Thin", size: 12)
    }
}
