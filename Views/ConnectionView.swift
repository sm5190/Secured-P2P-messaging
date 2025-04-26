import SwiftUI

struct ConnectionView: View {
    @StateObject var connectivityManager = ConnectivityManager()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Secure P2P Messaging")
                    .font(.largeTitle)
                    .bold()

                Button(action: {
                    connectivityManager.startBrowsing()
                }) {
                    Text("Discover & Connect")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: ChatView(connectivityManager: connectivityManager)) {
                    Text("Go to Chat")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(!connectivityManager.isConnected)
            }
            .padding()
        }
    }
}
