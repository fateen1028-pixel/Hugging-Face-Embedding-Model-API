from sentence_transformers import SentenceTransformer

class HFLocalEmbeddings:
    def __init__(self, model_name="all-MiniLM-L6-v2"):
        self.model = SentenceTransformer(model_name)

    def embed_texts(self, texts):
        embeddings = self.model.encode(texts, show_progress_bar=True)
        return embeddings
