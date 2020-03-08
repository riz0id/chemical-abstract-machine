{-# LANGUAGE DataKinds      #-}
{-# LANGUAGE GADTs          #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE TypeOperators  #-}

module Control.Cham.Molecule where

import Control.Cham.Agent
import Control.Cham.Context
import Control.Cham.Label
import Control.Cham.Name
import Data.Kind

data Molecule :: Context -> Type where
  Reagant  :: Agent cxt
           -> Molecule cxt
  -- ^ lift an agent to the molecular level.

  Prefix   :: Ion ty ion valence
           -> Molecule cxt
           -> Molecule (cxt :. Ion ty ion valence)
  -- ^ ionize an entire molecule.

  Restrict :: Molecule cxt
           -> Particle ty ion
           -> Molecule (cxt :. Ion ty ion 'Neg)
  -- ^ restrict a molecular action till the postfixed action
  -- | has been communicated.

  Tuple    :: Molecule cxt0
           -> Molecule cxt1
           -> Molecule (cxt0 >< cxt1)
  -- ^ building larger molecules.

  LeftPrj  :: Molecule (cxt0 >< cxt1) -> Molecule cxt0
  RightPrj :: Molecule (cxt0 >< cxt1) -> Molecule cxt1
  -- ^ right and left decomposition

infix 5 >=<
(>=<) :: Molecule cxt0 -> Molecule cxt1 -> Molecule (cxt0 >< cxt1)
(>=<) = Tuple

data Membrane :: Context -> Type where
  Void    :: Membrane 'Empty
  Airlock :: Molecule cxt0
          -> Membrane cxt1
          -> Membrane (cxt0 >< cxt1)

infixl 5 <|
(<|) :: Molecule cxt0 -> Membrane cxt1 -> Membrane (cxt0 >< cxt1)
(<|) = Airlock
