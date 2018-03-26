//
// Copyright (c) 2017 Christopher Baker <https://christopherbaker.net>
//
// SPDX-License-Identifier:	MIT
//


#include "ofApp.h"


void ofApp::setup()
{
    // Generate 1000 random vectors of length 40.
    const std::size_t numVectors = 1000;
    const std::size_t dIn = 40;
    const std::size_t dOut = 10;

    // We arrange our vectors end to end in row-major layout.
    std::vector<float> xs(numVectors * dIn);
    
    // Fill every value of every vector with a random between 0.0 and 1.0.
    for (auto& x: xs) x = ofRandom(1);
    
    // Compute PCA matrix.
    faiss::PCAMatrix mat(dIn, dOut);
    
    // This will block and take a while with a lot of data.
    mat.train(numVectors, xs.data());
    
    if (mat.is_trained)
    {
        // Allocate an output matrix.
        std::vector<float> xt(numVectors * dOut);
        
        // Apply the transformation to the input data.
        mat.apply_noalloc(numVectors, xs.data(), xt.data());
        
        // Square every item.
        for (auto& x: xt) x = x * x;
        
        // Create a sum of magnitudes across every column.
        // The output sums should be descending.
        for (std::size_t i = 0; i < dOut; ++i)
        {
            float sum = 0;
            for (std::size_t j = 0; j < numVectors; ++j)
            {
                // Caclulate the index of the current row / column in the current vector.
                std::size_t k = j * dOut + i;
                sum += xt[k];
            }
            std::cout << "Sum [" << i << "] = " << sum << std::endl;
        }
    }
    else
    {
        ofLogError() << "The PCAMatrix was not successfully trained.";
    }
    
    ofExit();
}
