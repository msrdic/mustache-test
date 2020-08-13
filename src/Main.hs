{-# LANGUAGE OverloadedStrings #-}
module Main where

import Text.Mustache
import Data.Text

data Context = Context { cName :: Text, cValue :: Int, cInCA :: Bool, cTaxedValue :: Int}

instance ToMustache Context where
  toMustache context = object
    [ "name" ~> cName context
    , "value" ~> cValue context
    , "in_ca" ~> cInCA context
    , "taxed_value" ~> cTaxedValue context ]

main :: IO ()
main = do
  let searchSpace = [".", "./templates"]
      templateName = "main.mustache"
      context = Context "Mladen" 1000 True 1200
  
  compiled <- automaticCompile searchSpace templateName
  case compiled of
    Left err -> print err
    Right template -> print $ substitute template context -- this is where you can start using it