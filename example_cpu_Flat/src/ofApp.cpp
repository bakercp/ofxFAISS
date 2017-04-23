//
// Copyright (c) 2017 Christopher Baker <https://christopherbaker.net>
//
// SPDX-License-Identifier:	MIT
//


#include "ofApp.h"


void ofApp::setup()
{
    // The number of features in our feature vector.
    const std::size_t numFeatures = 64;

    // The number of feature vectors in our collection.
    const std::size_t numFeatureVectors = 100000;

    // The number of queries we will make.
    const std::size_t numQueries = 10000;

    // Our feature vectors.
    std::vector<float> featureVectors(numFeatureVectors, 0);

    // Our query feature vectors.
    std::vector<float> queries(numQueries, 0);

    // Create random feature vectors in row-major order.
    for(std::size_t i = 0; i < featureVectors.size(); ++i)
    {
        for(std::size_t j = 0; j < numFeatures; ++j)
        {
            featureVectors[d * i + j] = drand48();
        }

        featureVectors[d * i] += i / 1000.;
    }

    for(int i = 0; i < nq; i++) {
        for(int j = 0; j < d; j++)
            xq[d * i + j] = drand48();
        xq[d * i] += i / 1000.;
    }

    faiss::IndexFlatL2 index(d);           // call constructor
    printf("is_trained = %s\n", index.is_trained ? "true" : "false");
    index.add(nb, xb);                     // add vectors to the index
    printf("ntotal = %ld\n", index.ntotal);

    int k = 4;

    {       // sanity check: search 5 first vectors of xb
        long *I = new long[k * 5];
        float *D = new float[k * 5];

        index.search(5, xb, k, D, I);

        // print results
        printf("I=\n");
        for(int i = 0; i < 5; i++) {
            for(int j = 0; j < k; j++)
                printf("%5ld ", I[i * k + j]);
            printf("\n");
        }

        printf("D=\n");
        for(int i = 0; i < 5; i++) {
            for(int j = 0; j < k; j++)
                printf("%7g ", D[i * k + j]);
            printf("\n");
        }

        delete [] I;
        delete [] D;
    }


    {       // search xq
        long *I = new long[k * nq];
        float *D = new float[k * nq];

        index.search(nq, xq, k, D, I);

        // print results
        printf("I (5 first results)=\n");
        for(int i = 0; i < 5; i++) {
            for(int j = 0; j < k; j++)
                printf("%5ld ", I[i * k + j]);
            printf("\n");
        }

        printf("I (5 last results)=\n");
        for(int i = nq - 5; i < nq; i++) {
            for(int j = 0; j < k; j++)
                printf("%5ld ", I[i * k + j]);
            printf("\n");
        }
        
        delete [] I;
        delete [] D;
    }
    
    delete [] xb;
    delete [] xq;

    ofExit();
}
