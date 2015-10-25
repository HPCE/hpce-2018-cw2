# Makefile for visual studio using nmake

CPPFLAGS = /Iinclude /W4 /EHsc
LDFLAGS =
LDLIBS =

# Turn on optimisations
CPPFLAGS = $(CPPFLAGS) /Ox

# TODO: Set the path to the headers
!IFNDEF TBB_INC_DIR
!ERROR "You need to set TBB_INC_DIR"
!ENDIF

# TODO: Choose the correct library for your build
!IFNDEF TBB_LIB_DIR
!ERROR "You need to set TBB_LIB_DIR"
!ENDIF

CPPFLAGS = $(CPPFLAGS) /I$(TBB_INC_DIR)
LDFLAGS = $(LDFLAGS) /LIBPATH:$(TBB_LIB_DIR)

# The very basic parts
FOURIER_CORE_OBJS = src/fourier_transform.obj src/fourier_transform_register_factories.obj

# implementations
FOURIER_IMPLEMENTATION_OBJS =  src/fast_fourier_transform.obj	src/direct_fourier_transform.obj

FOURIER_OBJS = $(FOURIER_CORE_OBJS) $(FOURIER_IMPLEMENTATION_OBJS)

.cpp.obj :
	$(CPP) $(CPPFLAGS) /c $< /Fo$@

bin\test_tbb.exe : src/test_tbb.cpp $(FOURIER_OBJS)
	-mkdir bin
	$(CPP) $(CPPFLAGS) $** /Fe$@ /link $(LDFLAGS) $(LDLIBS)

bin\test_fourier_transform.exe : src/test_fourier_transform.cpp $(FOURIER_OBJS)
	-mkdir bin
	$(CPP) $(CPPFLAGS) $** /Fe$@ /link $(LDFLAGS) $(LDLIBS)

bin\time_fourier_transform.exe : src/time_fourier_transform.cpp $(FOURIER_OBJS)
	-mkdir bin
	$(CPP) $(CPPFLAGS) $** /Fe$@ /link $(LDFLAGS) $(LDLIBS)

all : bin\test_fourier_transform.exe bin\time_fourier_transform.exe
