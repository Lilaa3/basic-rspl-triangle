V=1
SOURCE_DIR=src
BUILD_DIR=build
include $(N64_INST)/include/n64.mk

CFLAGS+=-Wall -Wextra -pedantic
ifeq ($(D),1)
CFLAGS+=-g
CXXFLAGS+=-g
ASFLAGS+=-g
RSPASFLAGS+=-g
LDFLAGS+=-g
endif

all: basic_rspl_triangle.z64
	@mkdir -p $(BUILD_DIR)
	mv basic_rspl_triangle.z64 $(BUILD_DIR)/basic_rspl_triangle.z64
.PHONY: all

OBJS = $(BUILD_DIR)/main.o $(BUILD_DIR)/rsp/rsp_example.o

basic_rspl_triangle.z64: N64_ROM_TITLE="Basic RSPL Triangle"

$(BUILD_DIR)/basic_rspl_triangle.elf: $(OBJS)

# Clean targets inside both root and build folders
clean:
	rm -rf $(BUILD_DIR) *.z64
.PHONY: clean

-include $(wildcard $(BUILD_DIR)/*.d)