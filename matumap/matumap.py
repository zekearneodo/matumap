import umap
import numpy as np

def do_umap_embedding(data, n_neighbours=5, n_components=2, metric='euclidean'):
	map = umap.UMAP(n_neighbours, n_components, metric, random_state=42)
	map.fit(data)
	embedded = map.transform(data)
	return embedded, map

def do_umap_embedding_flattened(data_flat, nrows, ncols, map=[], n_neighbours=5, n_components=2, \
								metric='euclidean', **kwargs):
	# the data is now vectors that need to be reshaped back to a matrix by numpy
	data = np.reshape(data_flat,(nrows,ncols),order='F')
	if map:
		embedding = map.transform(data)
		return embedding
	map = umap.UMAP(n_neighbours, n_components, metric, **kwargs)
	map.fit(data)
	embedded = map.transform(data)
	embedded = np.reshape(embedded, (1,embedded.shape[0]*n_components), order='F')
	return embedded, map