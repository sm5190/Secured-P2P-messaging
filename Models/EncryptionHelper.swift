import Foundation
import CryptoKit

struct EncryptionHelper {
    static let symmetricKey = SymmetricKey(size: .bits256)

    static func encrypt(message: String) throws -> Data {
        let data = message.data(using: .utf8)!
        let sealedBox = try AES.GCM.seal(data, using: symmetricKey)
        return sealedBox.combined!
    }

    static func decrypt(data: Data) throws -> String {
        let box = try AES.GCM.SealedBox(combined: data)
        let decryptedData = try AES.GCM.open(box, using: symmetricKey)
        return String(data: decryptedData, encoding: .utf8)!
    }
}
