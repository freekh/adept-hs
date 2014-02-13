import Data.Set (Set)
import Data.Set as S
type Id = String

data Constraint = Constraint String (Set String)
data Attribute = Attribute String (Set String)
data Req = Req Id (Set Constraint)

data Variant = Variant Id (Set Attribute) (Set Req) deriving Ord

resolve :: Set Req -> Set Variant -> Set Variant
resolve rs vs = S.empty



vars = Variant 
