//
//  ARViewContainer.swift
//  furniture-finalproject
//
//  Created by andra-dev on 19/08/24.
//

import SwiftUI
import RealityKit
import ARKit
import Combine
import FocusEntity

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var viewModel: ARViewModel
    let item: Product
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        // Enable people occlusion
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
                config.frameSemantics.insert(.personSegmentationWithDepth)
        }
        
        // Enable scene reconstruction for object occlusion
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
            config.environmentTexturing = .automatic
        }
        
        arView.session.run(config)
        
        
        // Set up scene reconstruction for object occlusion
        arView.environment.sceneUnderstanding.options = [.occlusion, .physics]
        
        let focusEntity = FocusEntity(on: arView, style: .classic(color: .white))
        context.coordinator.focusEntity = focusEntity
                
        context.coordinator.arView = arView
        
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(ARViewCoordinator.handleTap))
        arView.addGestureRecognizer(tapGesture)
        
        // Add other gestures (pan, pinch, rotation)
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(ARViewCoordinator.handlePan(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(ARViewCoordinator.handlePinch(_:)))
        let rotationGesture = UIRotationGestureRecognizer(target: context.coordinator, action: #selector(ARViewCoordinator.handleRotation(_:)))
        
        arView.addGestureRecognizer(panGesture)
        arView.addGestureRecognizer(pinchGesture)
        arView.addGestureRecognizer(rotationGesture)
        
        panGesture.delegate = context.coordinator
        pinchGesture.delegate = context.coordinator
        rotationGesture.delegate = context.coordinator
        
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.tintColor = .white
        closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        closeButton.layer.cornerRadius = 20
        closeButton.addTarget(context.coordinator, action: #selector(ARViewCoordinator.closeButtonTapped), for: .touchUpInside)
        
        arView.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: arView.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: arView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> ARViewCoordinator {
        ARViewCoordinator(viewModel: viewModel, presentationMode: presentationMode, item: item)
    }
}
