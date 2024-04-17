
PRJ_DIR = $(realpath .)
TCC_DIR = $(PRJ_DIR)/tinycc
TCC_INSTALL_DIR = $(TCC_DIR)/install

default: build_tcc

init:
	git submodule update --init --recursive

build_tcc:
	@cd $(TCC_DIR); ./configure --prefix=$(TCC_INSTALL_DIR) --disable-static
	@cd $(TCC_DIR); make clean
	@cd $(TCC_DIR); make -j 100
	@cd $(TCC_DIR); make install

clean:
	rm -rf $(TCC_INSTALL_DIR)

.PHONY: init build_tcc clean
