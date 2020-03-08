{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TypeOperators              #-}

import Control.Cham.Agent
import Control.Cham.Context
import Control.Cham.Label

import Control.Monad.RWS.Lazy (RWS, get, gets, put, modify, tell, ask)
import Control.Monad.Reader.Class (MonadReader)
import Control.Monad.State.Class (MonadState)
import Control.Monad.Writer.Class (MonadWriter)
import qualified Data.Set as S

class (Eq p, Ord p) => ProcessId p where
  isWhiteId :: p -> Bool

newtype Count = Count { uncount :: Integer }
  deriving (Show, Eq, Ord, Num, Enum)

data StateInfo p = StateInfo
  { stateInfoIdColor       :: p
  , stateInfoOpCount       :: Count
  , stateInfoSnapshotCount :: Count
  , stateInfoWarningColor  :: p
  , stateInfoParentColor   :: p
  } deriving (Show, Eq)

data InfoBundle p = InfoBundle
  { infoBundleStateInfo   :: StateInfo p
  , infoBundleIdBorderSet :: S.Set p
  , infoBundleIdColor     :: p
  } deriving (Show, Eq)

newtype StateBundle p =
  StateBundle { stateBundleStateInfos :: [InfoBundle p] }
  deriving (Show, Eq)

data Message p =
    WarningMessage
    { messageMasterColor :: p
    , messageSenderColor :: p
    }
  | ChildMessage { messageChildColor  :: p             }
  | DataMessage  { messageStateBundle :: StateBundle p }
  | DoneMessage  { messageMyColor     :: p             }
  deriving (Show, Eq)

data Letter p = Letter
  { letterSenderOf    :: p
  , letterRecipientOf :: p
  , letterMessage     :: Message p
  } deriving (Show, Eq)

data ProcessConfig = ProcessConfig
  deriving (Show, Eq)

data ProcessState p = ProcessState
  { processStateIdColor       :: p
  , processStateLocalColor    :: p
  , processStateParentColor   :: p
  , processStateOpCount       :: Count
  , processStateSnapshotCount :: Count
  , processStateInChannels    :: [p]
  , processStateOutChannels   :: [p]
  , processStateWarningRecSet :: S.Set p
  , processStateIdBorderSet   :: S.Set p
  , processStateChildSet      :: S.Set p
  , processStateRecStateInfo  :: StateInfo p
  , processStateStateBundle   :: StateBundle p
  } deriving (Show, Eq)

newtype ProcessAction p x = ProcessAction
  { runAction :: RWS ProcessConfig [Letter p] (ProcessState p) x }
  deriving ( Functor, Applicative, Monad, MonadReader ProcessConfig
           , MonadWriter [Letter p], MonadState (ProcessState p))

msgHandler :: ProcessId p
           => Agent (Empty :. Ion (Letter p) S
                           :. Ion (ProcessAction p ()) Z)
msgHandler = \letter -> case letterMessage letter of
  WarningMessage { messageMasterColor = warningCol
                 , messageSenderColor = senderCol } ->
    handleWarningMessage (letterSenderOf letter) warningCol senderCol

  ChildMessage { messageChildColor = childCol } ->
    handleChildMessage childCol

main = putStrLn "lala"
