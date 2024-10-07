ifneq ($(strip $(PU_SRCS) $(PU_TARGET)),)
all:
	@echo -e "\n!!! You must use \"PPU_SRCS\" instead of \"PU_SRCS\" !!!\n"
	@exit 1
endif

#---------------------------------------------------------------------- 
# PPU targets
#----------------------------------------------------------------------

PPU_C_SRCS          =   $(filter %.c,   $(PPU_SRCS))
PPU_CC_SRCS         =   $(filter %.cc,  $(PPU_SRCS))
PPU_CXX_SRCS        =   $(filter %.cpp, $(PPU_SRCS))
PPU_AS_SRCS         =   $(filter %.s,   $(PPU_SRCS))
PPU_FP_SRCS         =   $(filter %.fp,  $(PPU_SRCS))
PPU_VP_SRCS         =   $(filter %.vp,  $(PPU_SRCS))
PPU_BIN_SRCS        =   $(filter %.bin, $(PPU_SRCS))
PPU_SELF_SRCS       =   $(filter %.self,$(PPU_SRCS))
PPU_SPU_ELF_SRCS    =   $(filter %.elf, $(PPU_SRCS))
PPU_SPU_SO_SRCS     =   $(filter %.spu.so, $(PPU_SRCS))
PPU_AR_SRCS         =   $(filter %.a,   $(PPU_SRCS))

PPU_C_OBJS          =   $(patsubst %, $(OBJS_DIR)/$(notdir %.ppu.o), $(basename $(PPU_C_SRCS)))
PPU_CC_OBJS         =   $(patsubst %, $(OBJS_DIR)/$(notdir %.ppu.o), $(basename $(PPU_CC_SRCS)))
PPU_CXX_OBJS        =   $(patsubst %, $(OBJS_DIR)/$(notdir %.ppu.o), $(basename $(PPU_CXX_SRCS)))
PPU_AS_OBJS         =   $(patsubst %, $(OBJS_DIR)/$(notdir %.ppu.o), $(basename $(PPU_AS_SRCS)))
PPU_FP_OBJS         =   $(patsubst %, $(OBJS_DIR)/$(notdir %.fpo.o), $(basename $(PPU_FP_SRCS)))
PPU_VP_OBJS         =   $(patsubst %, $(OBJS_DIR)/$(notdir %.vpo.o), $(basename $(PPU_VP_SRCS)))
PPU_BIN_OBJS        =   $(patsubst %, $(OBJS_DIR)/$(notdir %.ppu.o), $(basename $(PPU_BIN_SRCS)))
PPU_SPU_ELF_OBJS    =   $(patsubst %, $(OBJS_DIR)/$(notdir %.ppu.o), $(basename $(PPU_SPU_ELF_SRCS)))
PPU_SPU_SO_OBJS     =   $(patsubst %, $(OBJS_DIR)/$(notdir %.spu.so.ppu.o), $(basename $(PPU_SPU_SO_SRCS)))
PPU_SELF_OBJS       =   $(patsubst %, $(OBJS_DIR)/$(notdir %.ppu.o), $(basename $(PPU_SELF_SRCS)))
PPU_EMBEDDED_OBJS   =   $(patsubst %, $(OBJS_DIR)/$(notdir %.ppu.o), $(PPU_EMBEDDED_SRCS))
PPU_OBJS            =   \
                        $(PPU_C_OBJS) \
                        $(PPU_CC_OBJS) \
                        $(PPU_CXX_OBJS) \
                        $(PPU_AS_OBJS) \
                        $(PPU_FP_OBJS) \
                        $(PPU_VP_OBJS) \
                        $(PPU_BIN_OBJS) \
                        $(PPU_SELF_OBJS) \
                        $(PPU_SPU_ELF_OBJS) \
                        $(PPU_SPU_SO_OBJS) \
                        $(PPU_EMBEDDED_OBJS)

PPU_OBJS_DEPENDS    :=   $(PPU_SRCS) $(PPU_EMBEDDED_OBJS)
PPU_OBJS_DEPENDS    :=   $(patsubst %.c,   $(OBJS_DIR)/$(notdir %.ppu.o), $(PPU_OBJS_DEPENDS))
PPU_OBJS_DEPENDS    :=   $(patsubst %.cc,  $(OBJS_DIR)/$(notdir %.ppu.o), $(PPU_OBJS_DEPENDS))
PPU_OBJS_DEPENDS    :=   $(patsubst %.cpp, $(OBJS_DIR)/$(notdir %.ppu.o), $(PPU_OBJS_DEPENDS))
PPU_OBJS_DEPENDS    :=   $(patsubst %.s,   $(OBJS_DIR)/$(notdir %.ppu.o), $(PPU_OBJS_DEPENDS))
PPU_OBJS_DEPENDS    :=   $(patsubst %.fp,  $(OBJS_DIR)/$(notdir %.fpo.o), $(PPU_OBJS_DEPENDS))
PPU_OBJS_DEPENDS    :=   $(patsubst %.vp,  $(OBJS_DIR)/$(notdir %.vpo.o), $(PPU_OBJS_DEPENDS))
PPU_OBJS_DEPENDS    :=   $(patsubst %.bin, $(OBJS_DIR)/$(notdir %.ppu.o), $(PPU_OBJS_DEPENDS))
PPU_OBJS_DEPENDS    :=   $(patsubst %.elf, $(OBJS_DIR)/$(notdir %.ppu.o), $(PPU_OBJS_DEPENDS))
PPU_OBJS_DEPENDS    :=   $(patsubst %.spu.so, $(OBJS_DIR)/$(notdir %.spu.so.ppu.o), $(PPU_OBJS_DEPENDS))
PPU_OBJS_DEPENDS    :=   $(patsubst %.self,$(OBJS_DIR)/$(notdir %.ppu.o), $(PPU_OBJS_DEPENDS))

PPU_AR_OBJS         =   $(patsubst %, $(OBJS_DIR)/$(notdir %)/*.o, $(basename $(PPU_AR_SRCS)))
PPU_AR_DEPENDS      =   $(patsubst %, $(OBJS_DIR)/$(notdir %)/libtmp.a, $(basename $(PPU_AR_SRCS)))

PPU_C_MD_FILES      =   $(patsubst %, $(OBJS_DIR)/$(notdir %.ppu.d), $(basename $(PPU_C_SRCS)))
PPU_CC_MD_FILES     =   $(patsubst %, $(OBJS_DIR)/$(notdir %.ppu.d), $(basename $(PPU_CC_SRCS)))
PPU_CXX_MD_FILES    =   $(patsubst %, $(OBJS_DIR)/$(notdir %.ppu.d), $(basename $(PPU_CXX_SRCS)))
PPU_AS_MD_FILES     =   $(patsubst %, $(OBJS_DIR)/$(notdir %.ppu.d), $(basename $(PPU_AS_SRCS)))
PPU_MD_FILES        =   \
                        $(PPU_C_MD_FILES) \
                        $(PPU_CC_MD_FILES) \
                        $(PPU_CXX_MD_FILES) \
                        $(PPU_AS_MD_FILES)

ifneq ($(PPU_TARGET),)
PPU_SELF_TARGET     = $(basename $(PPU_TARGET))$(FSELF_SUFFIX)
endif
PPU_CLEAN_OBJS      = $(strip \
                        $(PPU_OBJS) $(PPU_MD_FILES) $(PPU_TARGET) $(PPU_SELF_TARGET) \
                        $(PPU_LIB_TARGET) $(PPU_INCLINK_TARGET) \
                        $(patsubst %, $(notdir %.bin), $(basename $(PPU_SPU_ELF_SRCS))) \
                        $(patsubst %, $(notdir %.jobbin2), $(basename $(PPU_SPU_ELF_SRCS))) \
                        $(patsubst %, $(OBJS_DIR)/$(notdir %.fpo), $(basename $(PPU_FP_SRCS))) \
                        $(patsubst %, $(OBJS_DIR)/$(notdir %.vpo), $(basename $(PPU_VP_SRCS))))

TARGET              +=  $(PPU_TARGET) $(PPU_SELF_TARGET) $(PPU_LIB_TARGET) $(PPU_INCLINK_TARGET)

PPU_LINK_OBJS       = $(strip \
                        $(PPU_LDLIBDIR) $(PPU_OBJS) $(PPU_AR_OBJS) \
                        $(PPU_LIBS) $(PPU_LOADLIBS) $(PPU_LDLIBS))

#---------------------------------------------------------------------- 
# check options
#----------------------------------------------------------------------
ifneq ($(strip $(PPU_LOADLIBS)),)
	ifeq ($(CELL_BUILD_TOOLS), SNC)
		PPU_LOADLIBS := --start-group $(PPU_LOADLIBS) --end-group
	else
		PPU_LOADLIBS := -Wl,--start-group $(PPU_LOADLIBS) -Wl,--end-group
	endif
endif

# -O0 and -Wuninitialized are exclusive
ifeq ($(PPU_OPTIMIZE_LV),-O0)
	GCC_WARNFLAGS_UNINITIALIZED =
endif

#----------------------------------------------------------------------
# Build rules for PPU
#----------------------------------------------------------------------
$(PPU_TARGET): $(PPU_DEPENDS) $(PPU_OBJS_DEPENDS) $(PPU_LIBS)
	@mkdir -p $(dir $(@))
ifeq ($(CELL_BUILD_TOOLS), SNC)
	$(PPU_CXXLD) -oformat=elf $(PPU_LDFLAGS) $(PPU_LINK_OBJS) -o $@
else
	$(PPU_CXXLD) $(PPU_LDFLAGS) $(PPU_LINK_OBJS) -o $@
endif

$(PPU_SELF_TARGET): $(PPU_TARGET)
	@mkdir -p $(dir $(@))
ifneq ($(MAKE_FSELF_TYPE),)
	$(MAKE_FSELF_INTERNAL) -input $< -output $@ $(MAKE_FSELF_TYPE)
else
	$(MAKE_FSELF) $< $@
endif

$(PPU_LIB_TARGET): $(PPU_DEPENDS) $(PPU_OBJS_DEPENDS) $(PPU_AR_DEPENDS)
	@mkdir -p $(dir $(@))
	$(PPU_AR) cru $@ $(PPU_OBJS) $(PPU_AR_OBJS)
	$(PPU_RANLIB) $@

$(PPU_INCLINK_TARGET): $(PPU_DEPENDS) $(PPU_OBJS_DEPENDS) $(PPU_LIBS)
	@mkdir -p $(dir $(@))
	$(PPU_CXXLD) -r -nostartfiles $(PPU_LDFLAGS) $(PPU_LINK_OBJS) -o $@

$(PPU_C_OBJS): $(OBJS_DIR)/%.ppu.o: %.c
	@mkdir -p $(dir $(@))
ifeq ($(CELL_BUILD_TOOLS), SNC)	
	$(PPU_CC) -c $(PPU_CFLAGS) -MMD -o $@ $<
else
	$(PPU_CC) -c $(PPU_CFLAGS) -Wp,-MMD,$(@:.o=.d),-MT,$@ -o $@ $<
endif

$(PPU_CC_OBJS): $(OBJS_DIR)/%.ppu.o: %.cc
	@mkdir -p $(dir $(@))
ifeq ($(CELL_BUILD_TOOLS), SNC)	
	$(PPU_CXX) -c $(PPU_CXXFLAGS) -MMD -o $@ $<
else
	$(PPU_CXX) -c $(PPU_CXXFLAGS) -Wp,-MMD,$(@:.o=.d),-MT,$@ -o $@ $<
endif

$(PPU_CXX_OBJS): $(OBJS_DIR)/%.ppu.o: %.cpp
	@mkdir -p $(dir $(@))
ifeq ($(CELL_BUILD_TOOLS), SNC)	
	$(PPU_CXX) -c $(PPU_CXXFLAGS) -MMD -o $@ $<
else
	$(PPU_CXX) -c $(PPU_CXXFLAGS) -Wp,-MMD,$(@:.o=.d),-MT,$@ -o $@ $<
endif

$(PPU_AS_OBJS): $(OBJS_DIR)/%.ppu.o: %.s
	@mkdir -p $(dir $(@))
ifeq ($(CELL_BUILD_TOOLS), SNC)
	$(PPU_CCAS) $(PPU_ASFLAGS) -o $@ $<
else
	$(PPU_CCAS) -c $(PPU_ASFLAGS) -o $@ $<
endif

$(PPU_FP_OBJS): $(OBJS_DIR)/%.fpo.o: %.fp
	@mkdir -p $(dir $(@))
	$(PSGL_CGC) $(FPSHADER_QUIET) -profile $(FPSHADER_PROFILE) $(FPSHADER_FLAGS) -o $(OBJS_DIR)/$*.fpo $<
	cd $(OBJS_DIR) && $(PPU_OBJCOPY) -I binary -O elf64-powerpc-celloslv2 -B powerpc \
		--set-section-align .data=7 \
		--set-section-pad .data=128 \
		$*.fpo $*.fpo.o

$(PPU_VP_OBJS): $(OBJS_DIR)/%.vpo.o: %.vp
	@mkdir -p $(dir $(@))
	$(PSGL_CGC) $(VPSHADER_QUIET) -profile $(VPSHADER_PROFILE) $(VPSHADER_FLAGS) -o $(OBJS_DIR)/$*.vpo $<
	cd $(OBJS_DIR) && $(PPU_OBJCOPY) -I binary -O elf64-powerpc-celloslv2 -B powerpc \
		--set-section-align .data=7 \
		--set-section-pad .data=128 \
		$*.vpo $*.vpo.o

$(PPU_BIN_OBJS): $(OBJS_DIR)/%.ppu.o: %.bin
	@mkdir -p $(dir $(@))
	$(PPU_OBJCOPY) -I binary -O elf64-powerpc-celloslv2 -B powerpc \
		--set-section-align .data=7 \
		--set-section-pad .data=128 \
		--rename-section .data=.spu_image.$<,readonly,contents,alloc \
		$< $@

$(PPU_SELF_OBJS): $(OBJS_DIR)/%.ppu.o: %.self
	@mkdir -p $(dir $(@))
	$(PPU_OBJCOPY) -I binary -O elf64-powerpc-celloslv2 -B powerpc \
		--set-section-align .data=7 \
		--set-section-pad .data=128 \
		--rename-section .data=.spu_image.$<,readonly,contents,alloc \
		$< $@

$(PPU_SPU_ELF_OBJS): $(OBJS_DIR)/%.ppu.o: %.elf
	@mkdir -p $(dir $(@))
	$(SPU_ELF_TO_PPU_OBJ) $(SPU_ELF_TO_PPU_OBJ_FLAGS) $< $@

$(PPU_SPU_SO_OBJS): $(OBJS_DIR)/%.spu.so.ppu.o: %.spu.so
	@mkdir -p $(dir $(@))
	$(SPU_ELF_TO_PPU_OBJ) $(SPU_ELF_TO_PPU_OBJ_FLAGS) $< $@

$(PPU_AR_DEPENDS): $(OBJS_DIR)/%/libtmp.a: %.a
	$(RM) -r $(OBJS_DIR)/$*/
	mkdir -p $(OBJS_DIR)/$*/
	$(CP) $< $(OBJS_DIR)/$*/libtmp.a
	cd $(OBJS_DIR)/$*/ && $(PPU_AR) -x libtmp.a

$(PPU_EMBEDDED_OBJS): $(OBJS_DIR)/%.ppu.o: %
	@mkdir -p $(dir $(@))
	$(PPU_OBJCOPY) -I binary -O elf64-powerpc-celloslv2 -B powerpc \
		--set-section-align .data=7 \
		--set-section-pad .data=128 \
		$< $@

.PHONY: ppu-clean

ppu-clean:
ifneq ($(PPU_CLEAN_OBJS),)
	$(RM) $(PPU_CLEAN_OBJS)
endif
ifneq ($(strip $(PPU_AR_DEPENDS)),)
	$(RM) -r $(dir $(PPU_AR_DEPENDS))
endif

#----------------------------------------------------------
# include dependency
#----------------------------------------------------------
-include $(PPU_MD_FILES)

