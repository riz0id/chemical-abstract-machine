{-# LANGUAGE DataKinds      #-}
{-# LANGUAGE GADTs          #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE TypeOperators  #-}

module Control.Cham.Agent where

import Control.Cham.Context
import Control.Cham.Label
import Control.Cham.Name
import Data.Kind

data Agent :: Context -> Type where
  Inaction :: Agent 'Empty
  -- ^ fixpoint for all reactions

  Prefix   :: Ion ty ion valence
           -> Agent cxt
           -> Agent (cxt :. Ion ty ion valence)
  -- ^ binds a type variable to this reagent. can be
  -- | thought of as currying.

  Parallel :: Agent cxt0
           -> Agent cxt1
           -> Agent (cxt0 >< cxt1)
  -- ^ product of reagents that can run in parallel safely.

  Restrict :: Particle ty valence
           -> Agent cxt
           -> Agent (cxt :. Ion ty valence 'Neg)

  {- omitted for the moment because it's hard an probably
  -- undecidable
  Relabel  :: (a -> Ion b lbl')
           -> Agent (cxt :. Ion a lbl)
           -> Agent cxt'
  -}

  External :: Agent cxt0
           -> Agent cxt1
           -> Agent (cxt0 >< cxt1)
