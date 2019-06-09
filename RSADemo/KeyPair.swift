//
//  KeyPair.swift
//  RSADemo
//
//  Created by Prathamesh Kowarkar on 10/06/19.
//  Copyright © 2019 Prathamesh Kowarkar. All rights reserved.
//

import Foundation

struct KeyPair {
    
    let title: String
    let publicKey: SecKey
    let privateKey: SecKey
    
}

extension KeyPair {
    
    init?(withTitle title: String) {
        self.title = title
        var error: Unmanaged<CFError>? = nil
        let tag =  "\(Bundle.main.bundleIdentifier ?? "").keys.\(title)".data(using: .utf8)!
        let attributes: [CFString: Any] = [
            kSecAttrType: kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits: 2048,
            kSecPrivateKeyAttrs: [
                kSecAttrIsPermanent: true,
                kSecAttrApplicationTag: tag
            ]
        ]
        do {
            guard let privateKey = SecKeyCreateRandomKey(attributes as CFDictionary, &error) else {
                if let error = error {
                    throw error.takeRetainedValue()
                }
                return nil
            }
            guard let publicKey = SecKeyCopyPublicKey(privateKey) else {
                if let error = error {
                    throw error.takeRetainedValue()
                }
                return nil
            }
            self.publicKey = publicKey
            self.privateKey = privateKey
            return
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
}

