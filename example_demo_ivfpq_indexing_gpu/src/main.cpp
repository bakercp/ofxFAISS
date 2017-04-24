//
// Copyright (c) 2017 Christopher Baker <https://christopherbaker.net>
//
// SPDX-License-Identifier:	MIT
//


#include "ofApp.h"


int main()
{
	ofSetupOpenGL(520, 94, OF_WINDOW);
    return ofRunApp(std::make_shared<ofApp>());
}
