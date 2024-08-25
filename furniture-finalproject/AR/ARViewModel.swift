import SwiftUI
import RealityKit
import Combine

class ARViewModel: ObservableObject {
    @Published var selectedEntity: ModelEntity?
    @Published var modelEntity: ModelEntity?
    private var cancellables = Set<AnyCancellable>()
    
    func loadModel(named name: String) {
        guard modelEntity == nil else { return }
        
        let loadOperation = Future<ModelEntity, Error> { promise in
            do {
                let entity = try Entity.load(named: name)
                
                if let modelEntity = entity as? ModelEntity {
                    modelEntity.generateCollisionShapes(recursive: true)
                    promise(.success(modelEntity))
                } else {
                    let modelEntity = ModelEntity()
                    modelEntity.addChild(entity)
                    modelEntity.generateCollisionShapes(recursive: true)
                    promise(.success(modelEntity))
                }
            } catch {
                promise(.failure(error))
            }
        }
        
        loadOperation
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Failed to load model: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] entity in
                self?.modelEntity = entity
            }
            .store(in: &cancellables)
    }
    
    func updateEntityPosition(x: Float, y: Float, z: Float) {
            selectedEntity?.position += SIMD3<Float>(x, y, z)
        }
        
        func updateEntityScale(_ scale: Float) {
            selectedEntity?.scale *= scale
        }
        
        func updateEntityRotation(_ angle: Float, axis: SIMD3<Float>) {
            selectedEntity?.transform.rotation *= simd_quatf(angle: angle, axis: axis)
        }
}
