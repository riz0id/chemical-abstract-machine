{-# OPTIONS --without-K #-}

module Cham.Molecule where

open import Cham.Agent
open import Cham.Context
open import Cham.Label
open import Cham.Name
open import Data.List
open import Data.Product using (_×_)

data Molecule : Context → Set₁ where
  Reagent : ∀ {Γ} → Agent Γ → Molecule Γ

  _·ₘ_    : ∀ {Γ}
          → (Valence : Label)
          → Molecule Γ
          → Molecule (Γ ⊢ Valence)

  _∣ₘ_    : ∀ {Γ₁ Γ₂}
          → Molecule Γ₁
          → Molecule Γ₂
          → Molecule (Γ₁ , Γ₂)

  _/ₘ_    : ∀ {Γ}
          → (Ion : Name)
          → Molecule Γ
          → Molecule (Γ ⊢ Ion ⁻)

  ⟨_,_⟩   : ∀ {Γ₁ Γ₂}
          → Molecule Γ₁
          → Molecule Γ₂
          → Molecule (Γ₁ , Γ₂)

  l∶⟨_,_⟩  : ∀ {Γ₁ Γ₂}
          → Molecule (Γ₁ , Γ₂)
          → Molecule Γ₁

  r∶⟨_,_⟩  : ∀ {Γ₁ Γ₂}
          → Molecule (Γ₁ , Γ₂)
          → Molecule Γ₂

  -- molecular solutions
  Sol     : ∀ {Γ₁ Γ₂}
          → Molecule Γ₁
          → Molecule Γ₂
          → Molecule (permeate Γ₁ Γ₂)


