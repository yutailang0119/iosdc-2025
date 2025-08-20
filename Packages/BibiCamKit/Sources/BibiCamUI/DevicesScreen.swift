import Foundation
import SmartDeviceManagement
import SwiftUI

struct DevicesScreen: View {
  @State private var phase: ScreenPhase<[DevicesRequest.Response.Device], Error> = .loading

  var body: some View {
    DependencyProvider { dependency in
      ListScreen(phase) { devices in
        ForEach(devices, id: \.name) { device in
          if let deviceId = device.name.components(separatedBy: "/").last {
            NavigationLink {
              WebRTCScreen(
                state: WebRTCScreen.ViewState(
                  dependency: dependency,
                  deviceId: deviceId
                )
              )
            } label: {
              VStack(alignment: .leading) {
                Text(device.traits.info.customName)
                Text(device.deviceType)
                  .font(.caption)
                  .foregroundStyle(.secondary)
              }
            }
            .disabled(!device.supportsWebRTC)
          }
        }
      }
      .task {
        do {
          guard let client = await dependency.smartDeviceManagement else {
            phase = .empty
            return
          }
          let devices = try await client.request(for: DevicesRequest())
          phase = .loaded(devices.devices)
        } catch {
          phase = .failed(error)
        }
      }
    }
  }
}

#Preview {
  DevicesScreen()
}

private extension DevicesRequest.Response.Device {
  var supportsWebRTC: Bool {
    traits.cameraLiveStream.supportedProtocols.contains("WEB_RTC")
  }
}
