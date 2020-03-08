{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_Abstract_Chemical_Machine (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/syzygy/.cabal/bin"
libdir     = "/home/syzygy/.cabal/lib/x86_64-linux-ghc-8.10.0.20200123/Abstract-Chemical-Machine-1.0.0-inplace-ACM"
dynlibdir  = "/home/syzygy/.cabal/lib/x86_64-linux-ghc-8.10.0.20200123"
datadir    = "/home/syzygy/.cabal/share/x86_64-linux-ghc-8.10.0.20200123/Abstract-Chemical-Machine-1.0.0"
libexecdir = "/home/syzygy/.cabal/libexec/x86_64-linux-ghc-8.10.0.20200123/Abstract-Chemical-Machine-1.0.0"
sysconfdir = "/home/syzygy/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Abstract_Chemical_Machine_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Abstract_Chemical_Machine_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "Abstract_Chemical_Machine_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "Abstract_Chemical_Machine_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Abstract_Chemical_Machine_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Abstract_Chemical_Machine_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
