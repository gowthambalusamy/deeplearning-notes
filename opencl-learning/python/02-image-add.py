# -*- coding: utf-8 -*-

from __future__ import absolute_import, print_function
import numpy as np
import pyopencl as cl
import cv2
from PIL import Image

def RoundUp(groupSize, globalSize):  
    r = globalSize % groupSize;  
    if r == 0:  
        return globalSize
    else:  
        return globalSize + groupSize - r

# 创建Context
# 如果有多个设备，则会提示选择
ctx = cl.create_some_context()
# 创建CommandQueue
queue = cl.CommandQueue(ctx)

mf = cl.mem_flags

# 通过字符串内容编译OpenCL的Program
prg = cl.Program(ctx, """
__kernel void image_add(__read_only image2d_t input,__read_only image2d_t input2,
                              __write_only image2d_t output){
    //初始化采样器
    const sampler_t sampler = CLK_FILTER_NEAREST |
                              CLK_NORMALIZED_COORDS_FALSE |
                              CLK_ADDRESS_CLAMP;
    //获取图片大小
    const int2 size = get_image_dim(input);
    //设置当前像素
    int2 coord = (int2)(get_global_id(0),get_global_id(1));
    if(coord.x >= 0 && coord.x < size.x && coord.y >= 0 && coord.y < size.y){
        float4 color = read_imagef(input,sampler,coord) + read_imagef(input2,sampler,coord);
        color.w = 1.0f;

        write_imagef(output,coord,color);
    }
}
""").build()

# 打开图片文件
src1 = Image.open('temp/images/f1.png')
src2 = Image.open('temp/images/f2.png')
dist = Image.new('RGBA',(640,480),(255,255,255))

# OpenCL处理的图片文件格式RGBA,unit8
imageFormat = cl.ImageFormat(cl.channel_order.RGBA,cl.channel_type.UNSIGNED_INT8)

# 将图片从Host复制到Device
img1 = cl.Image(ctx, mf.READ_ONLY | mf.COPY_HOST_PTR,imageFormat,src1.size,None,src1.tobytes())
img2 = cl.Image(ctx, mf.READ_ONLY | mf.COPY_HOST_PTR,imageFormat,src2.size,None,src2.tobytes())
output = cl.Image(context=ctx,flags=mf.WRITE_ONLY,format=imageFormat,shape=src1.size)

# 根据图片大小定义WorkSize
localWorkSize = ( 8, 8 )  
globalWorkSize = ( RoundUp(localWorkSize[0], src1.size[0]),  
                    RoundUp(localWorkSize[1], src1.size[1]))
# 执行Kernel
prg.image_add(queue,globalWorkSize,localWorkSize,img1,img2,output)


buffer = np.zeros(src1.size[0] * src1.size[1] * 4, np.uint8)  
origin = ( 0, 0, 0 )  
region = ( src1.size[0], src1.size[1], 1 )  
# 将处理好的图片从设备复制到HOST 
cl.enqueue_read_image(queue, output,
                        origin, region, buffer).wait()
# 保存图片
dist = Image.frombytes("RGBA",src1.size, buffer.tobytes())
dist.save('temp/images/cl-output.png')
dist.show()