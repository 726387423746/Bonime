import SwiftUI

struct FlowLayout: Layout {
    var spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let containerWidth = proposal.width ?? .infinity
        var totalHeight: CGFloat = 0
        var currentLineWidth: CGFloat = 0
        var currentLineHeight: CGFloat = 0
        var maxRowWidth: CGFloat = 0
        
        for subview in subviews {
            let viewSize = subview.sizeThatFits(.unspecified)
            
            // Mathematically precise wrap check
            if currentLineWidth + viewSize.width > containerWidth && currentLineWidth > 0 {
                totalHeight += currentLineHeight + spacing
                maxRowWidth = max(maxRowWidth, currentLineWidth - spacing)
                currentLineWidth = 0
                currentLineHeight = 0
            }
            
            currentLineWidth += viewSize.width + spacing
            currentLineHeight = max(currentLineHeight, viewSize.height)
        }
        
        // Account for the final line
        maxRowWidth = max(maxRowWidth, currentLineWidth - spacing)
        let finalHeight = totalHeight + currentLineHeight
        
        return CGSize(width: maxRowWidth, height: finalHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        var y = bounds.minY
        var currentLineHeight: CGFloat = 0
        
        for subview in subviews {
            let viewSize = subview.sizeThatFits(.unspecified)
            
            // Wrap if the view exceeds the bounding box width
            if x + viewSize.width > bounds.maxX && x > bounds.minX {
                x = bounds.minX
                y += currentLineHeight + spacing
                currentLineHeight = 0
            }
            
            subview.place(at: CGPoint(x: x, y: y), proposal: .unspecified)
            
            x += viewSize.width + spacing
            currentLineHeight = max(currentLineHeight, viewSize.height)
        }
    }
}
