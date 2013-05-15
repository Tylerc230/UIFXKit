//
//  glMath.c
//  UIGLKit
//
//  Created by Tyler Casselman on 11/20/12.
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

float nextPowOf2(float num)
{
    float f = (float)(num - 1);
    return 1U << ((*(unsigned int*)(&f) >> 23) - 126);
}

