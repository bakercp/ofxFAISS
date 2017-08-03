//
// Copyright (c) 2017 Christopher Baker <https://christopherbaker.net>
//
// SPDX-License-Identifier:	MIT
//


#pragma once


#include <faiss/AutoTune.h>
#include <faiss/AuxIndexStructures.h>
#include <faiss/Clustering.h>
#include <faiss/faiss.h>
#include <faiss/FaissAssert.h>
#include <faiss/hamming.h>
#include <faiss/Heap.h>
#include <faiss/index_io.h>
#include <faiss/Index.h>
#include <faiss/IndexFlat.h>
#include <faiss/IndexIVF.h>
#include <faiss/IndexIVFPQ.h>
#include <faiss/IndexLSH.h>
#include <faiss/IndexPQ.h>
#include <faiss/MetaIndexes.h>
#include <faiss/PolysemousTraining.h>
#include <faiss/ProductQuantizer.h>
#include <faiss/utils.h>
#include <faiss/VectorTransform.h>


// Enable to use include GPU features.
// #define FAISS_USE_GPU


#if defined(FAISS_USE_GPU)
#include <faiss/gpu/GpuAutoTune.h>
#include <faiss/gpu/GpuIndex.h>
#include <faiss/gpu/GpuIndexFlat.h>
#include <faiss/gpu/GpuIndexIVF.h>
#include <faiss/gpu/GpuIndexIVFFlat.h>
#include <faiss/gpu/GpuIndexIVFPQ.h>
#include <faiss/gpu/GpuIndicesOptions.h>
#include <faiss/gpu/GpuResources.h>
#include <faiss/gpu/IndexProxy.h>
#include <faiss/gpu/StandardGpuResources.h>
#endif


namespace ofxFAISS = ofx::FAISS;
