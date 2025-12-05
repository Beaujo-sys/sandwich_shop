# Task: Implement cart item modifications in a Flutter sandwich shop app

## App Context
- There are two pages:
  1. Order screen: users select sandwiches and add them to their cart.
  2. Cart screen: users view items in their cart and the total price.
- State: The cart contains a list of items with `id`, `name`, `price`, `quantity`, and optional `options` (e.g., bread type, extras).
- Goal: Allow users to modify items directly from the cart screen.

## Requirements

### 1) Change Item Quantity
- Description: Let users increase or decrease the quantity of an item in the cart.
- UI:
  - Each cart item shows a quantity control (e.g., “− [quantity] +”).
  - Disable decrement when quantity is 1 (or prompt to remove).
- Actions:
  - On increment: Increase the item’s quantity by 1.
  - On decrement: Decrease the item’s quantity by 1; if quantity becomes 0, remove the item.
- State updates:
  - Update the item’s `quantity` in the cart state.
  - Recalculate and update the cart subtotal/total.
- Edge cases:
  - Prevent negative quantities.
  - Respect any max quantity rules if applicable.

### 2) Remove Item
- Description: Allow users to remove an item entirely from the cart.
- UI:
  - Provide a “Remove” button or a swipe-to-delete gesture per item.
  - Optional confirmation dialog.
- Actions:
  - On remove: Delete the item from the cart list.
- State updates:
  - Recalculate and update totals.
  - If cart becomes empty, show the empty cart state (message, CTA to “Add sandwiches”).

### 3) Edit Item Options (e.g., bread, extras, sauces)
- Description: Allow users to change the configuration of an existing cart item.
- UI:
  - “Edit” button on each item opens an edit modal/screen with the same customization controls used on the order screen.
- Actions:
  - On save: Update the item’s `options` and `price` if the configuration changes.
  - On cancel: Leave the item unchanged.
- State updates:
  - Persist the updated options and price in the cart.
  - Recalculate and update totals.
- Edge cases:
  - If the edited options make it identical to another item, either merge items (sum quantities) or keep them separate based on product rules.

### 4) Clear Cart
- Description: Allow users to remove all items at once.
- UI:
  - “Clear Cart” button at the top or bottom of the cart screen.
  - Confirmation dialog to prevent accidental clearing.
- Actions:
  - On confirm: Empty the cart list.
- State updates:
  - Reset totals to 0.
  - Show empty cart state.

### 5) Undo Recent Remove (Optional)
- Description: Provide a brief undo window after an item removal.
- UI:
  - Snackbar/toast with “Item removed” and an “Undo” action.
- Actions:
  - On undo: Restore the last removed item to its previous position and quantity/options.
- State updates:
  - Recalculate totals accordingly.

## Technical Details
- Data model: CartItem { id, name, basePrice, quantity, options, computedPrice }
- Price calculation:
  - computedPrice = basePrice + sum(option surcharges)
  - Line total = computedPrice * quantity
  - Cart total = sum(all line totals) + taxes/fees if applicable
- State management:
  - Use a single source of truth (e.g., Provider, Riverpod, Bloc).
  - Emit updates so UI reflects quantity, options, and total immediately.
- Persistence:
  - Optional: Save cart state locally (e.g., SharedPreferences) to restore after app restart.
- Accessibility:
  - Ensure buttons are accessible with screen readers and have adequate hit targets.

## Deliverables
- Updated cart screen UI with controls for quantity, remove, edit, and clear.
- Actions wired to state updates with recalculated totals.
- Unit tests for:
  - Increment/decrement quantity.
  - Remove item.
  - Edit options updates price and merges correctly if required.
  - Clear cart behavior.
  - Undo removal (if implemented).

## Acceptance Criteria
- Users can adjust item quantities, remove items, edit item options, and clear the cart.
- Totals update immediately and correctly.
- No negative quantities; empty cart state is handled.
- Changes persist within the session and are reflected on navigation.