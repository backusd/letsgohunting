#include "pch.h"


#include "webgpu.h"
#pragma comment (lib, "webgpu")

int main(int, char**) 
{
    // 1. We create a descriptor
    WGPUInstanceDescriptor desc = {};
    desc.nextInChain = nullptr;

    // 2. We create the instance using this descriptor
    WGPUInstance instance = wgpuCreateInstance(&desc);

    // 3. We can check whether there is actually an instance created
    if (!instance) {
        std::cerr << "Could not initialize WebGPU!" << std::endl;
        return 1;
    }

    // 4. Display the object (WGPUInstance is a simple pointer, it may be
    // copied around without worrying about its size).
    std::cout << "WGPU instance: " << instance << std::endl;

    // 5. We clean up the WebGPU instance
    wgpuInstanceRelease(instance);


    std::cout << "Hello, world!" << std::endl;
    return 0;
} 