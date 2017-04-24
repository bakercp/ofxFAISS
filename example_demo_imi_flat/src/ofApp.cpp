//
// Copyright (c) 2017 Christopher Baker <https://christopherbaker.net>
//
// SPDX-License-Identifier:	MIT
//


#include "ofApp.h"

// just generate some random vecs in a hypercube (CPU)
std::vector<float> makeRandomVecs(size_t numVecs, int dim)
{
    std::vector<float> vecs(numVecs * dim);
    faiss::float_rand(vecs.data(), vecs.size(), 1);
    return vecs;
}


void ofApp::setup()
{
    // Reserves 18% of GPU memory for temporary work by default; the
    // size can be adjusted, or your own implementation of GpuResources
    // can be made to manage memory in a different way.
    faiss::gpu::StandardGpuResources res;

    int dim = 128;
    int numberOfEMIterations = 20;
    size_t numberOfClusters = 20000;
    size_t numVecsToCluster = 5000000;

    // generate a bunch of random vectors; note that this is on the CPU!
    std::vector<float> vecs = makeRandomVecs(numVecsToCluster, dim);
    faiss::gpu::GpuIndexFlatConfig config;
    config.device = 0;            // this is the default
    config.useFloat16 = false;    // this is the default
    faiss::gpu::GpuIndexFlatL2 index(&res, dim, config);

    faiss::ClusteringParameters cp;
    cp.niter = numberOfEMIterations;
    cp.verbose = true; // print out per-iteration stats

    // For spherical k-means, use GpuIndexFlatIP and set cp.spherical = true

    // By default faiss only samples 256 vectors per centroid, in case
    // you are asking for too few centroids for too many vectors.
    // e.g., numberOfClusters = 1000, numVecsToCluster = 1000000 would
    // only sample 256000 vectors.
    //
    // You can override this to use any number of clusters
    // cp.max_points_per_centroid =
    //   ((numVecsToCluster + numberOfClusters - 1) / numberOfClusters);

    faiss::Clustering kMeans(dim, numberOfClusters, cp);

    // do the work!
    kMeans.train(numVecsToCluster, vecs.data(), index);

    // kMeans.centroids contains the resulting cluster centroids (on CPU)
    printf("centroid 3 dim 6 is %f\n", kMeans.centroids[3 * dim + 6]);

    ofExit();
}
