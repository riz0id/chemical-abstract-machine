{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE GADTs         #-}
{-# LANGUAGE TypeOperators #-}

module Control.Cham.Context where

import Data.Kind
import Data.Typeable

data Context where
  Empty   :: Context
  Append  :: Context -> Type -> Context
  Product :: Context -> Context -> Context
  deriving (Typeable)

infixl 5 :.
type (:.) = 'Append
type (><) = 'Product
