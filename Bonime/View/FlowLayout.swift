import SwiftUI

@available(iOS 16.0, *)
struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.width ?? 0, subviews: subviews, spacing: spacing)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        
        for (index, subview) in subviews.enumerated() {
            let savedPoint = result.points[index]
            subview.place(
                at: CGPoint(x: savedPoint.x + bounds.minX, y: savedPoint.y + bounds.minY),
                proposal: .unspecified
            )
        }
    }

    struct FlowResult {
        var size: CGSize = .zero
        var points: [CGPoint] = []
        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var rowHeight: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                
                if currentX + size.width > maxWidth && currentX > 0 {
                    currentX = 0
                    currentY += rowHeight + spacing
                    rowHeight = 0
                }
                points.append(CGPoint(x: currentX, y: currentY))
                rowHeight = max(rowHeight, size.height)
                currentX += size.width + spacing
                self.size.width = max(self.size.width, currentX - spacing)
            }
            self.size.height = currentY + rowHeight
        }
    }
}
