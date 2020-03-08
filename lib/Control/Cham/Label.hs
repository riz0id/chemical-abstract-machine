{-# LANGUAGE DataKinds                #-}
{-# LANGUAGE GADTs                    #-}
{-# LANGUAGE PolyKinds                #-}
{-# LANGUAGE StandaloneKindSignatures #-}
{-# LANGUAGE TypeOperators            #-}

module Control.Cham.Label where

import Data.Kind
import Data.Typeable
import GHC.TypeLits

data Label where
  Pos :: Label -- outgoing state(producer ion)
  Neg :: Label -- incoming state(consumer ion)
  deriving (Typeable, Show, Eq)

type    Ion :: Type -> Symbol -> Label -> Type
newtype Ion t ion valence = Ion t
  deriving (Typeable, Show, Eq)
