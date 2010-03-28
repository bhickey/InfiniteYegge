class YeggeBox:
    """The magical YeggeBox"""
    def __init__(self):
        self.corpus = []
    def addGrams(self,k,grams):
        self.corpus.append(grams)
    def getWord(self):
        return "Eat moard chickin"

