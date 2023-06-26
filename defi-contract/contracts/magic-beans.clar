(define-fungible-token magic-beans)
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant error-amount-zero (err u101))

(define-public (mint (amount uint) (who principal)) 
(begin  
(asserts! (is-eq tx-sender contract-owner) err-owner-only)
;; amount, who are unchecked, but we let the contract owner mint to whoever they like for convenience
;; #[allow(unchecked_data)]
(ft-mint? magic-beans amount who)
)
)

(define-public (transfer (amount uint) (sender principal) (recipient principal)) 
(begin
(asserts! (is-eq sender contract-owner) err-owner-only)
(asserts! (> amount u0) error-amount-zero)
;; recipient is unchecked, anyone can transfer their tokens to anyone else
;; #[allow(unchecked_data)]
(ft-transfer? magic-beans amount sender recipient)
)
)