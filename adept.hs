import Debug.Trace (trace)
import Data.Set (Set)
import Data.Set as S
import Data.Hashable (Hashable)

newtype Id = Id String deriving (Show, Eq, Ord)

fl :: (Ord a) => [a] -> Set a
fl = S.fromList



data Constraint = Constraint String String deriving (Eq, Show, Ord)
data Attribute = Attribute String String deriving (Eq, Show, Ord)
data Req = Req Id (Set Constraint) deriving (Eq, Show, Ord)

data Variant = Variant Id (Set Attribute) (Set Req) deriving (Eq, Show, Ord)

resolve :: Set Req -> Set Variant -> Set Variant

resolve reqs vars
  | S.null reqs = S.empty
  | S.null vars = error "Couldn't satisfy requirements"
resolve rs vs = resolve rem vs
  where req@(Req id cons) = S.minView 0 rs
        rem = S.deleteMin req rs
        vars = [ (attr,req) | Variant id attr req <- vs ]  


req = fl [Req (Id "b") ( fl [Constraint "Version" "2"] ) ]



repo :: Set Variant 
repo = fl [ Variant (Id "a")
            (fl [Attribute "Version" "1"])
            (fl [Req (Id "b") ( fl [Constraint "Version" "2"] ) ])
          , Variant (Id "b")
            ( fl [Attribute "Version" "2"] )
            S.empty
          ]
