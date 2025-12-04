from flask import Flask, request, jsonify
from huggingface_service import HFLocalEmbeddings

app = Flask(__name__)
hf = HFLocalEmbeddings()

@app.route("/embed", methods=["POST"])
def embed():
    data = request.json
    texts = data.get("texts")
    if not texts or not isinstance(texts, list):
        return jsonify({"error": "Provide a list of texts"}), 400
    embeddings = hf.embed_texts(texts)
    embeddings_list = [emb.tolist() for emb in embeddings]
    return jsonify({"embeddings": embeddings_list})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
