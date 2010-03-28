import qualified Data.Map as M
import qualified Data.ByteString as B
import Data.Foldable as F
import Data.Sequence as S
import System.Random
import Data.Maybe

type Corpus = M.Map (Seq B.ByteString) (Seq B.ByteString)

corpus :: Corpus
corpus = M.empty

roots :: Seq (Seq B.ByteString)
roots = S.empty

makePassage :: 
     Int 
  -> (Seq B.ByteString) 
  -> Maybe (Seq B.ByteString) 
  -> IO [B.ByteString]

makePassage 0 acc _ =
  return $ (F.foldr (:) [] acc)

makePassage n acc Nothing = 
  do r <- randomRIO (0, (S.length roots) - 1)
     let root = S.index roots r in
       makePassage n acc (Just $ root)

makePassage n acc (Just prefix) =
  case M.lookup prefix corpus of
    Nothing -> makePassage n acc (Just $ S.drop 1 prefix)
    Just x ->
      do r <- randomRIO (0, (S.length x) - 1)
         let word = S.index x r in
           makePassage (n - 1) (acc |> word) (Just ((S.drop 1 prefix) |> word))
