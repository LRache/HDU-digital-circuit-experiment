VERILATOR = verilator
CC = gcc

VERILATOR_CFLAGS += -MMD --build -cc -O3 --trace-fst 
VERILATOR_FLAGS  = --timescale "1ns/1ns" --no-timing --autoflush

LAB_NAME ?= lab3
LAB_DIR  ?= $(LAB_NAME)

BUILD_DIR = $(abspath ./$(LAB_DIR)/build)
OBJ_DIR	  = $(abspath ./$(LAB_DIR)/V$(TOP))
 
CSRCS = $(filter-out $(OBJ_DIR)/*, $(wildcard $(LAB_DIR)/*.cpp))
VSRCS = $(wildcard $(LAB_DIR)/*.v)
INC_PATH += $(abspath ./$(LAB_DIR)/obj)


SIM_EXE = $(BUILD_DIR)/$(LAB_NAME)_sim

$(OBJ_DIR)/V$(TOP).mk:
	mkdir -p $(OBJ_DIR)
	$(VERILATOR) --cc $(VSRCS) --Mdir $(OBJ_DIR) --trace-fst --top-module $(TOP) $(VERILATOR_FLAGS)

update: $(OBJ_DIR)/V$(TOP).mk

$(SIM_EXE): $(CSRCS) $(VSRCS)
	mkdir -p $(BUILD_DIR)
	$(VERILATOR) $(VERILATOR_CFLAGS) $(VERILATOR_FLAGS) --top-module $(TOP) $(CSRCS) $(VSRCS) $(addprefix -CFLAGS , $(CXXFLAGS)) $(addprefix -LDFLAGS , $(LDFLAGS)) --Mdir $(OBJ_DIR) --exe -o $(SIM_EXE)

.PHONY: sim

sim: $(SIM_EXE)
	$(SIM_EXE)

clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(OBJ_DIR)
