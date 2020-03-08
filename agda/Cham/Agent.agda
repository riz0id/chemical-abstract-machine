{-# OPTIONS --without-K #-}

module Cham.Agent where

open import Cham.Context
open import Cham.Label
open import Cham.Name
open import Data.Nat
open import Data.Product

data Agent : Context → Set where
  Nil  : Agent ∅

  _∙_  : ∀ {Γ}
       → (Valence : Label)
       → Agent Γ
       → Agent (Γ ⊢ Valence)

  _∣_  : ∀ {Γ₁ Γ₂}
       → Agent Γ₁
       → Agent Γ₂
       → Agent (Γ₁ , Γ₂)

  _/_  : ∀ {Γ}
       → (Ion : Name)
       → Agent Γ
       → Agent (Γ ⊢ Ion ⁻)

  _[]_ : ∀ {Γ₁ Γ₂}
       → Agent Γ₁
       → Agent Γ₂
       → Agent (Γ₁ , Γ₂)

Reaction : ∀ {Γ₁ Γ₂ Ion}
         → Agent (Γ₁ ⊢ Ion ⁺)
         → Agent (Γ₂ ⊢ Ion ⁻)
         → Agent Γ₁ × Agent Γ₂
Reaction (.(_   ⁺) ∙ a₁) (.(_ ⁻) ∙ a₂) = a₁ , a₂
Reaction (.(Ion ⁺) ∙ a₁) (Ion    / a₂) = a₁ , a₂
