# Need to be modified according to different users
BOOST_PATH=/home/prabindh/TOOLS/boost_1_83_0
GRID_DIM=-DGRID_DIM1=64 -DGRID_DIM2=128
NVCC_COMPILER=nvcc
# Should not be modified
BOOST_INC_PATH=-I$(BOOST_PATH) -I$(BOOST_PATH)/boost 
VINA_GPU_INC_PATH=-I./lib -I./inc/ -I./inc/cuda
OPENCL_INC_PATH=
LIB1=-lboost_program_options -lboost_system -lboost_filesystem
LIB2=-lstdc++
LIB3=-lm -lpthread
BOOST_LIB_PATH=$(BOOST_PATH)/installed/lib
SRC=./lib/*.cpp $(BOOST_PATH)/libs/thread/src/pthread/thread.cpp $(BOOST_PATH)/libs/thread/src/pthread/once.cpp #../boost_1_77_0/boost/filesystem/path.hpMACRO=-DAMD_PLATFORM -DDISPLAY_SUCCESS -DDISPLAY_ADDITION_INFO
SRC_CUDA = ./inc/cuda/kernel2.cu
MACRO=$(GRID_DIM) #-DDISPLAY_SUCCESS -DDISPLAY_ADDITION_INFO
all:out
out:./main/main.cpp
	$(NVCC_COMPILER) -o Vina-GPU $(BOOST_INC_PATH) $(VINA_GPU_INC_PATH) $(OPENCL_INC_PATH) ./main/main.cpp -O3 $(SRC) $(SRC_CUDA) $(LIB1) $(LIB2) $(LIB3) -L$(BOOST_LIB_PATH) $(MACRO) $(OPTION) -DBUILD_KERNEL_FROM_SOURCE -DBOOST_TIMER_ENABLE_DEPRECATED
cuda:./main/main.cpp
	$(NVCC_COMPILER) -o Vina-GPU $(BOOST_INC_PATH) $(VINA_GPU_INC_PATH) $(OPENCL_INC_PATH) ./main/main.cpp -O3 $(SRC) $(SRC_CUDA) $(LIB1) -Xlinker="-rpath,$(BOOST_LIB_PATH)" $(LIB2) $(LIB3)  -L$(BOOST_LIB_PATH) $(MACRO) $(OPTION) -DBUILD_KERNEL_FROM_SOURCE -DBOOST_TIMER_ENABLE_DEPRECATED
clean:
	rm Vina-GPU
