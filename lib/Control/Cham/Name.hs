{-# LANGUAGE DataKinds                #-}
{-# LANGUAGE KindSignatures           #-}
{-# LANGUAGE StandaloneKindSignatures #-}

module Control.Cham.Name where

import Data.Kind
import Data.Typeable
import GHC.TypeLits

type    Particle :: Type -> Symbol -> Type
newtype Particle ty valence = Particle ty
  deriving (Typeable, Show, Eq)
