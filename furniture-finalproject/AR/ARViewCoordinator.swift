import UIKit
import RealityKit
import ARKit
import SwiftUI
import Combine
import FocusEntity

class ARViewCoordinator: NSObject, UIGestureRecognizerDelegate {
    var viewModel: ARViewModel
    var presentationMode: Binding<PresentationMode>
    var item: Product
    var focusEntity: FocusEntity?
    var arView: ARView?
    var cancellables = Set<AnyCancellable>()
    
    init(viewModel: ARViewModel, presentationMode: Binding<PresentationMode>, item: Product) {
        self.viewModel = viewModel
        self.presentationMode = presentationMode
        self.item = item
        super.init()
        
        viewModel.$modelEntity
            .compactMap { $0 }
            .sink { [weak self] entity in
                self?.placeEntity(entity)
            }
            .store(in: &cancellables)
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        guard let arView = arView, viewModel.modelEntity == nil else { return }
        
        let location = recognizer.location(in: arView)
        if arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal).first != nil {
            viewModel.loadModel(named: item.modelName)
        }
    }
    
    func placeEntity(_ entity: ModelEntity) {
            guard let arView = arView,
                  let focusEntity = focusEntity else { return }
            
            let position = focusEntity.position
            let anchorEntity = AnchorEntity(world: position)
            anchorEntity.addChild(entity)
            
            // Configure entity for occlusion
            entity.generateCollisionShapes(recursive: true)
            
            // Enable occlusion materials
        if var modelComponent = entity.components[ModelComponent.self] as? ModelComponent{
            modelComponent.materials = modelComponent.materials.map({ material in
                var updatedMaterial = material
                if var physicsMaterial = updatedMaterial as? PhysicallyBasedMaterial{
                    physicsMaterial.baseColor = .init(tint: .white, texture: nil)
                    physicsMaterial.roughness = 1.0
                    physicsMaterial.metallic = 0.0
                    physicsMaterial.blending = .opaque
                    updatedMaterial = physicsMaterial
                }
                return updatedMaterial
            })
        
            entity.components[ModelComponent.self] = modelComponent
        }
        
            arView.scene.addAnchor(anchorEntity)
            
            focusEntity.isEnabled = false
            viewModel.selectedEntity = entity  // Set the selected entity
        }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
           guard let arView = arView else { return }
           let translation = gesture.translation(in: arView)
           viewModel.updateEntityPosition(x: Float(translation.x) / 500,
                                          y: 0,
                                          z: Float(-translation.y) / 500)
           gesture.setTranslation(.zero, in: arView)
       }
       
       @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
           viewModel.updateEntityScale(Float(gesture.scale))
           gesture.scale = 1
       }
       
       @objc func handleRotation(_ gesture: UIRotationGestureRecognizer) {
           viewModel.updateEntityRotation(Float(gesture.rotation), axis: [0, 1, 0])
           gesture.rotation = 0
       }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func closeButtonTapped() {
        presentationMode.wrappedValue.dismiss()
    }
}
