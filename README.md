# Text Embeddings in Elasticsearch

This repository provides a simple example of how Elasticsearch can be used for similarity
search by combining a sentence embedding model with the `dense_vector` field type.

## Description

The main script `src/main.py` indexes the first ~20,000 questions from the
[StackOverflow](https://github.com/elastic/rally-tracks/tree/master/so)
dataset. Before indexing, each post's title is run through a pre-trained sentence embedding to
produce a [`dense_vector`](https://www.elastic.co/guide/en/elasticsearch/reference/master/dense-vector.html).

After indexing, the script accepts free-text queries in a loop ("Enter query: ..."). The text is run
through the same sentence embedding to produce a vector, then used to search for similar questions
through [cosine similarity](https://www.elastic.co/guide/en/elasticsearch/reference/7.x/query-dsl-script-score-query.html#vector-functions).

Google's [Universal Sentence Encoder](https://tfhub.dev/google/universal-sentence-encoder/2) is used
to perform the vector embedding.

## Running from Docker

Instead of downloading Elasticsearch and cloning this repository, you can run the following commands to download and run from a Docker container:

```
docker build . -t text-embeddings
docker run --name text_embeddings -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -d text-embeddings
docker exec -it text_embeddings bash
cd text-embeddings/
python3.6 src/main.py
```

## Example Queries

The following queries return good posts near the top position, despite there not being strong term
overlap between the query and document title:
- "zipping up files" returns "Compressing / Decompressing Folders & Files"
- "determine if something is an IP" returns "How do you tell whether a string is an IP or a hostname"
- "translate bytes to doubles" returns "Convert Bytes to Floating Point Numbers in Python"

Note that in other cases, the results can be noisy and unintuitive. For example, "zipping up files" also assigns high scores to "Partial .csproj Files" and "How to avoid .pyc files?".
