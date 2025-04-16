//
//  Constants.swift
//  ChatApp
//
//  Created by Mehmet  Demir on 12.04.2025.
//

struct C {
        static let appName = "💬ChatApp💬"
        static let cellIdentifier = "ReusableCell"
        static let cellNibName = "MessageCell"
        static let registerSegue = "RegisterToChat"
        static let loginSegue = "LoginToChat"
        static let sendCodeSegue = "ForgotToEnterCode"
    
        struct BrandColors {
            static let purple = "ChatLila"
            static let lightPurple = "BrandLightLila"
            static let blue = "ChatBlue"
            static let lighBlue = "ChatBlueLight"
        }
        
        struct FStore {
            static let collectionName = "messages"
            static let senderField = "sender"
            static let bodyField = "body"
            static let dateField = "date"
        }

}
