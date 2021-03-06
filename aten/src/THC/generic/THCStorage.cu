#ifndef THC_GENERIC_FILE
#define THC_GENERIC_FILE "generic/THCStorage.cu"
#else

void THCStorage_(fill)(THCState *state, THCStorage *self, real value)
{
  THCThrustAllocator thrustAlloc(state);
  thrust::device_ptr<real> self_data(THCStorage_(data)(state, self));
  thrust::fill(
#if CUDA_VERSION >= 7000
    thrust::cuda::par(thrustAlloc).on(THCState_getCurrentStream(state)),
#endif
    self_data, self_data+self->size, value);
}

void THCStorage_(resize)(THCState *state, THCStorage *self, ptrdiff_t size)
{
  THCStorage_resize(state, self, size);
}

THC_API int THCStorage_(getDevice)(THCState* state, const THCStorage* storage) {
  return THCStorage_getDevice(state, storage);
}

#endif
