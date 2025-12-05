# Feature Requirements: Cart Item Modifications

## 1. Feature Description and Purpose
Enable users to modify items directly from the cart screen, including changing quantities, removing items, editing customization options (e.g., bread/extras/sauces), clearing the entire cart, and optionally undoing a recent removal. The purpose is to improve checkout flexibility and accuracy, ensuring the cart reflects the user’s desired configuration while keeping totals and pricing accurate and responsive.

### Scope
- Cart item quantity adjustments
- Item removal
- Edit item options
- Clear entire cart
- Undo recent removal (optional)
- Immediate state and total price updates
- Accessibility and persistence (optional) considerations

### Out of Scope
- Payment processing
- Authentication
- Inventory limits beyond optional max quantity rules

---

## 2. User Stories

### Subtask A: Change Item Quantity
- As a user, I want to increase an item’s quantity from the cart so I can buy more of the same sandwich without re-adding it from the order screen.
- As a user, I want to decrease an item’s quantity from the cart so I can adjust my order without deleting and re-adding the item.
- As a user, I don’t want to be able to set the quantity to a negative number or accidentally reduce below 1 without clear feedback.

### Subtask B: Remove Item
- As a user, I want to remove an item from the cart so I don’t pay for sandwiches I no longer want.
- As a cautious user, I want an optional confirmation or a simple gesture (like swipe-to-delete) to remove items quickly but safely.

### Subtask C: Edit Item Options
- As a user, I want to edit the options of a cart item (bread, extras, sauces) so I can fine-tune my sandwich without starting over.
- As a power user, I want the edited item to reflect accurate pricing immediately and optionally merge with identical items based on product rules.

### Subtask D: Clear Cart
- As a user, I want a “Clear Cart” action to empty my cart quickly when I change my mind.
- As a careful user, I want a confirmation prompt to avoid accidental clearing.

### Subtask E: Undo Recent Remove (Optional)
- As a user, I want a brief “Undo” opportunity after I remove an item so I can easily recover from mistakes.

### Subtask F: State and Totals Feedback
- As a user, I want the cart subtotal/total to update instantly when I change quantities, edit options, or remove items.
- As a user, I want to see an empty cart state with messaging and a call-to-action when my cart becomes empty.

### Subtask G: Accessibility and Persistence
- As a user using assistive technology, I want quantity controls, remove, edit, and clear actions to be accessible via screen readers and have adequate hit targets.
- As a returning user, I want my cart changes to persist within the session and optionally across app restarts.

---

## 3. Acceptance Criteria

### Subtask A: Change Item Quantity
- Quantity controls (“− [quantity] +”) present on each cart item.
- Decrement is disabled at quantity 1 or prompts removal; no negative quantities allowed.
- Increment increases quantity by 1; decrement reduces by 1; quantity reaching 0 removes the item.
- Cart totals (line totals and overall total) recalculate immediately on change.
- Respect optional max quantity rules and show feedback if exceeded.

### Subtask B: Remove Item
- Each item has a visible “Remove” action or supports swipe-to-delete.
- Removing an item updates the cart immediately and recalculates totals.
- Optional confirmation dialog configurable by product rules.
- Empty cart state is displayed when the last item is removed.

### Subtask C: Edit Item Options
- Each item has an “Edit” action that opens a modal/screen with the same customization controls as the order flow.
- On save, the item’s options and computed price update; totals recalculate immediately.
- On cancel, no changes are applied.
- If edited options match an existing item and product rules require merging, items merge and quantities sum; otherwise, keep separate.

### Subtask D: Clear Cart
- “Clear Cart” button available in the cart screen.
- Confirmation dialog required before clearing.
- On confirm, cart empties, totals reset to 0, and empty state is shown.

### Subtask E: Undo Recent Remove (Optional)
- After removing an item, show a snackbar/toast “Item removed” with an “Undo” action for a brief period.
- If “Undo” is tapped within the allowed window, restore the item to its previous position, quantity, and options; totals update accordingly.
- If timeout elapses or another change occurs that invalidates undo, the removal remains final.

### Subtask F: State Management and Price Calculation
- Single source of truth (Provider, Riverpod, or Bloc) manages cart state.
- Data model includes: CartItem { id, name, basePrice, quantity, options, computedPrice }.
- computedPrice = basePrice + sum(option surcharges); line total = computedPrice * quantity; cart total = sum(line totals) + taxes/fees if applicable.
- UI reacts to state changes immediately; no stale totals.

### Subtask G: Persistence and Accessibility
- Changes persist within the session; optionally persisted locally (e.g., SharedPreferences) to restore after restart.
- All controls labeled for screen readers and meet minimum touch targets.
- Keyboard navigation and focus states behave predictably in edit modals/screens.

### Validation and Testing
- Unit tests cover:
  - Increment/decrement quantity, preventing negatives and handling zero-removal.
  - Remove item behavior and total recalculation.
  - Edit options updating computed price and merging logic where applicable.
  - Clear cart behavior, totals reset, and empty state.
  - Undo removal restoring item and totals.
- Manual QA verifies:
  - Instant UI updates and accurate totals.
  - Accessibility behavior.
  - Edge cases: max quantity, identical item merging, undo timing.

### Definition of Done
- All acceptance criteria satisfied across supported devices.
- Unit tests implemented and passing in CI.
- No critical accessibility issues; basic screen reader checks pass.
- Feature documented in release notes with user guidance.