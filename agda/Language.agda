{-# OPTIONS --without-K #-}

open import Data.Product using (_×_)
open import Data.String
open import Level
open import Relation.Binary.PropositionalEquality.Core

Valence : Set
Valence = String

data Type : Set where
  Outgoing : Type
  Incoming : Type

infix 5 _,_⦂_
data Context : Set where
  ∅    : Context
  _,_⦂_ : Context → Valence → Type → Context

_+_ : Context → Context → Context
∅           + Γ₂ = Γ₂
(Γ₁ , x ⦂ A) + Γ₂ = (Γ₁ + Γ₂) , x ⦂ A

rename : Context → (Valence → Valence) → Context
rename ∅          ϕ = ∅
rename (Γ , x ⦂ A) ϕ = rename Γ ϕ , ϕ x ⦂ A

data Agent {ℓ} : Context → Set ℓ → Set (suc ℓ) where
  Nil  : ∀ {A : Set ℓ} → Agent ∅ A

  _∙_  : ∀ {Γ A}
       → (ion : Valence)
       → (com : Type)
       → (x : A)
       → Agent (Γ , ion ⦂ com) A

  _∣_  : ∀ {Γ₁ Γ₂} {A B : Set ℓ}
       → Agent Γ₁ A
       → Agent Γ₂ B
       → Agent (Γ₁ + Γ₂) (A × B)

  _/_  : ∀ {Γ A}
       → A
       → (ion : Valence)
       → Agent (Γ , ion ⦂ Outgoing) A

  _[_] : ∀ {Γ A}
       → (ϕ : Valence → Valence)
       → Agent Γ A
       → Agent (rename Γ ϕ) A

  fix_ : ∀ {Γ} {A B : Set ℓ}
       → (f : A → B)
       → Agent Γ A
       → Agent Γ B

infix 4 _∋_⦂_
data _∋_⦂_ : Context → Valence → Type → Set where
  Z : ∀ {Γ x A}
      -----------------
    → Γ , x ⦂ A ∋ x ⦂ A

  S : ∀ {Γ x y A B}
    → x ≢ y
    → Γ ∋ x ⦂ A
      -----------------
    → Γ , y ⦂ B ∋ x ⦂ A

data _⊢_⦂_ : Context → Valence → Type → Set where
  ⊢ : ∀ {Γ x A}
    → Γ ∋ x ⦂ A
      ----------
    → Γ ⊢ x ⦂ A
