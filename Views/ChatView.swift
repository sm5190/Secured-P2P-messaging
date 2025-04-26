import SwiftUI

struct ChatView: View {
    @StateObject var chatManager: ChatManager

    @State private var inputText: String = ""

    init(connectivityManager: ConnectivityManager) {
        _chatManager = StateObject(wrappedValue: ChatManager(connectivityManager: connectivityManager))
    }

    var body: some View {
        VStack {
            ScrollView {
                ForEach(chatManager.messages) { message in
                    HStack {
                        if message.isSentByMe {
                            Spacer()
                            Text(message.text)
                                .padding()
                                .background(Color.blue.opacity(0.7))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .padding(4)
                        } else {
                            Text(message.text)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(10)
                                .foregroundColor(.black)
                                .padding(4)
                            Spacer()
                        }
                    }
                }
            }

            HStack {
                TextField("Type a message", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Send") {
                    chatManager.sendMessage(inputText)
                    inputText = ""
                }
            }
            .padding()
        }
        .navigationTitle("Chat")
    }
}
