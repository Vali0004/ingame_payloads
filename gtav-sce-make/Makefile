TOOLCHAIN_FILES = toolchain/ppu/

CELL_MK_DIR = $(SCE_PS3_ROOT)/samples/mk
CELL_SN_DIR = $(SCE_PS3_ROOT)/host-win32/sn/bin/
CELL_DATA_DIR := $(SCE_PS3_ROOT)/target

include $(CELL_MK_DIR)/sdk.makedef-ppu-snc.mk

CELL_BUILD_TOOLS = SNC
SNC_PPU_PREFIX = ps3

SNC_PPU_CXXLD := ps3ppuld64
BUILD_TYPE := debug

PRX_DIR			= .
BUILD_DIR = build
CELL_SDK_FILE_NAME := payload
CELL_SDK_FILE_EXT := .elf
BINARY_DIR = $(BUILD_DIR)\$(BUILD_TYPE)\

PPU_SRCS := $(wildcard src/*.cpp src/*.s)

PPU_LOADLIBS +=

PPU_LD_DEBUG_FLAGS := -s
PPU_CXX_DEBUG_FLAGS := -g -Xinlinedebug=1 -D"_DEBUG" -D"__CELL_ASSERT__"

ifeq ($(BUILD_TYPE), release)
	PPU_LDFLAGS += -T src/linker.x -oformat=elf -no-required-files -no-standard-libraries -strip-unused-data $(PPU_LD_DEBUG_FLAGS) -o $(BUILD_DIR)\$(BUILD_TYPE)\$(CELL_SDK_FILE_NAME)$(CELL_SDK_FILE_EXT) -L"C:/usr/local/cell/host-win32/lib/prx/ldscripts"
	PPU_CXXFLAGS += -Tp -DNDEBUG -D__PS3__ -DLIBNAME=$(CELL_SDK_FILE_NAME) -DSTUBNAME=$(CELL_SDK_FILE_NAME)_stub -Xdepmode=1 -Xmserrors -I. -I"C:/usr/local/cell/target/ppu/include" -I"C:/usr/local/cell/target/common/include" -I"C:/usr/local/cell/host-win32/sn/ppu/include" -O2 -Xstd=cpp11 -Xc-=rtti -c
else
	PPU_LDFLAGS += -T src/linker.x -oformat=elf -no-required-files -no-standard-libraries -strip-unused-data -o $(BUILD_DIR)\$(BUILD_TYPE)\$(CELL_SDK_FILE_NAME)$(CELL_SDK_FILE_EXT) -L"C:/usr/local/cell/host-win32/lib/prx/ldscripts"
	PPU_CXXFLAGS += -Tp -D__PS3__ $(PPU_CXX_DEBUG_FLAGS) -DLIBNAME=$(CELL_SDK_FILE_NAME) -DSTUBNAME=$(CELL_SDK_FILE_NAME)_stub -Xdepmode=1 -Xmserrors -I. -I"C:/usr/local/cell/target/ppu/include" -I"C:/usr/local/cell/target/common/include" -I"C:/usr/local/cell/host-win32/sn/ppu/include" -O2 -Xstd=cpp11 -Xc-=rtti -c
endif

CLEANFILES = $(PRX_DIR)/$(PPU_SPRX_TARGET)

all:
	mkdir $(BINARY_DIR)
	$(CELL_SN_DIR)ps3ppusnc.exe $(PPU_CXXFLAGS) src/main.cpp -o src/main.ppu.o
	$(CELL_SN_DIR)ps3ppuas.exe src/crt0.s -o src/crt0.ppu.o
	$(SNC_PPU_CXXLD) $(PPU_LDFLAGS) src/crt0.ppu.o src/main.ppu.o
	$(TOOLCHAIN_FILES)ppu-lv2-objcopy -O binary $(BUILD_DIR)\$(BUILD_TYPE)\$(CELL_SDK_FILE_NAME)$(CELL_SDK_FILE_EXT) $(BUILD_DIR)\$(BUILD_TYPE)\$(CELL_SDK_FILE_NAME).bin

rebuild:
	$(MAKE) --no-print-directory clean
	$(MAKE) --no-print-directory all

clean:
	@echo # removing $(BUILD_DIR)
	@if exist $(BUILD_DIR)\ ( \
		rmdir $(BUILD_DIR) /s /q  \
	) \
	else (  \
		@echo # Directory is already "clean" \
	)

release:
	$(MAKE) rebuild BUILD_TYPE=release

debug:
	$(MAKE) rebuild BUILD_TYPE=debug

# Patches were needed because ancient Windows things broke
include $(TOOLCHAIN_FILES)sdk.target-ppu.mk