{-# OPTIONS --without-K --safe #-}

module Cham.Context where

open import Cham.Name
open import Cham.Label
open import Data.Product

infix 5 _⊢_
data Context : Set where
  ∅  : Context
  _⊢_ : Context → Label → Context
  _,_ : Context → Context → Context

rename : (Name → Label) → Context → Context
rename ϕ ∅           = ∅
rename ϕ (Γ ⊢ (N ⁺)) = rename ϕ Γ ⊢ ϕ N
rename ϕ (Γ ⊢ (N ⁻)) = rename ϕ Γ ⊢ ϕ N
rename ϕ (Γ₁ , Γ₂)   = rename ϕ Γ₁ , rename ϕ Γ₂

permeate : Context → Context → Context
permeate ∅ Γ₂        = Γ₂
permeate (Γ₁ ⊢ N) Γ₂ = permeate Γ₁ (Γ₂ ⊢ N)
permeate (Γ₁ , Γ₂) Γ₃ = Γ₁ , Γ₂ , Γ₃
