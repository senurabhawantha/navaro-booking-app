//  Navaro
//
//  Created by Guest User on 2025-09-09

import SwiftUI
import RealityKit
import CoreMotion

struct ARView: View {
    var body: some View {
        ZStack {
            
//             
            
            // 🔹 AR RealityKit Background
            Model3DView()
                .edgesIgnoringSafeArea(.all)

            VStack {
                // 🔹 Top Location Tag
                HStack {
                    Label("Weligama Cliff", systemImage: "mappin.circle.fill")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)

                    Spacer()

                    Button(action: {
                        // Close action
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .padding(8)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 50)

                Spacer()

                // 🔹 Bottom Navigation Card
                HStack {
                    Image(systemName: "arrow.turn.left.up")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Turn Left in 200m")
                            .font(.headline)
                            .foregroundColor(.white)
                        HStack(spacing: 8) {
                            Text("1.3 km away")
                            Text("•")
                            Text("15 mins")
                        }
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                    }

                    Spacer()
                }
                .padding()
                .background(Color.black.opacity(0.6))
                .cornerRadius(16)
                .padding(.horizontal)
                .padding(.bottom, 80)

                // 🔹 Custom Tab Bar
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "house")
                        Text("Home").font(.caption2)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.purple)
                        Text("Map").font(.caption2).foregroundColor(.purple)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search").font(.caption2)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "bookmark")
                        Text("Booking").font(.caption2)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "person")
                        Text("Profile").font(.caption2)
                    }
                    Spacer()
                }
                .padding(.vertical, 12)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ARView()
}

// MARK: - RealityKit 3D Model Integration
struct Model3DView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIView(context: Context) -> RealityKit.ARView {
        let arView = RealityKit.ARView(frame: .zero)

        // Transparent background (so SwiftUI layers show)
        arView.environment.background = .color(.clear)

        let sceneAnchor = AnchorEntity(world: .zero)

        do {
            let modelEntity = try Entity.loadModel(named: "hotel_room") // your 3D model file
            modelEntity.scale = SIMD3<Float>(repeating: 0.01)
            let bounds = modelEntity.visualBounds(relativeTo: nil)
            modelEntity.position = -bounds.center

            sceneAnchor.addChild(modelEntity)
            context.coordinator.modelEntity = modelEntity
        } catch {
            print("⚠️ Error loading model: \(error)")
        }

        arView.scene.anchors.append(sceneAnchor)
        context.coordinator.startMotionTracking()

        return arView
    }

    func updateUIView(_ uiView: RealityKit.ARView, context: Context) {}

    static func dismantleUIView(_ uiView: RealityKit.ARView, coordinator: Coordinator) {
        coordinator.stopMotionTracking()
    }

    class Coordinator {
        let motionManager = CMMotionManager()
        var modelEntity: Entity?

        func startMotionTracking() {
            guard motionManager.isDeviceMotionAvailable else { return }

            motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, _ in
                guard let self = self,
                      let motion = motion,
                      let model = self.modelEntity else { return }

                let attitude = motion.attitude
                let rotation = simd_quatf(ix: Float(attitude.quaternion.x),
                                          iy: Float(attitude.quaternion.y),
                                          iz: Float(attitude.quaternion.z),
                                          r: Float(attitude.quaternion.w))

                model.orientation = rotation
            }
        }

        func stopMotionTracking() {
            motionManager.stopDeviceMotionUpdates()
        }
    }
}

