import Foundation
import Combine

class ChatManager: ObservableObject {
    @Published var messages: [Message] = []

    private var cancellables = Set<AnyCancellable>()
    private let connectivityManager: ConnectivityManager

    init(connectivityManager: ConnectivityManager) {
        self.connectivityManager = connectivityManager

        connectivityManager.receivedData
            .sink { [weak self] data in
                if let text = try? EncryptionHelper.decrypt(data: data) {
                    let message = Message(text: text, isSentByMe: false, timestamp: Date())
                    self?.messages.append(message)
                }
            }
            .store(in: &cancellables)
    }

    func sendMessage(_ text: String) {
        if let encryptedData = try? EncryptionHelper.encrypt(message: text) {
            connectivityManager.send(data: encryptedData)
            let message = Message(text: text, isSentByMe: true, timestamp: Date())
            messages.append(message)
        }
    }
}
