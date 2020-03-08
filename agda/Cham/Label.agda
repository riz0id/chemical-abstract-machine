{-# OPTIONS --without-K --safe #-}

module Cham.Label where

open import Cham.Name

data Label : Set where
  _⁺ : Name → Label
  _⁻ : Name → Label

