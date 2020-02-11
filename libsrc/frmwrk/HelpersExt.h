#ifndef __HELPERS_H
#define __HELPERS_H

#include <bx/bx.h>
#include <bx/allocator.h>
#include <bimg/decode.h>

class HelpersExt {

public:
	static const bgfx::Memory* getMemory(uint8_t *const data, int size) {
		const bgfx::Memory* mem = bgfx::alloc(size + 1);
		for (int i = 0; i < size; ++i) {
			mem->data[i] = data[i];
		}
		mem->data[mem->size-1] = '\0';
		return mem;
	}
};

#endif