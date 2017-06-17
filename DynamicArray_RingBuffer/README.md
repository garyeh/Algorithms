# Dynamic Array

In computer science, a dynamic array is a random access, variable-size list data structure that allows elements to be added or removed. It is supplied with standard libraries in many modern mainstream programming languages. Dynamic arrays overcome a limit of static arrays, which have a fixed capacity that needs to be specified at allocation.

A dynamic array is not the same thing as a dynamically allocated array, which is an array whose size is fixed when the array is allocated, although a dynamic array may use such a fixed-size array as a back end.


# Ring Buffer

A ring buffer is a data structure that uses a single, fixed-size buffer as if it were connected end-to-end. This structure lends itself easily to buffering data streams.

The useful property of a ring buffer is that it does not need to have its elements shuffled around when one is consumed. (If a non-ring buffer were used then it would be necessary to shift all elements when one is consumed.) In other words, the ring buffer is well-suited as a FIFO buffer while a standard, non-ring buffer is well suited as a LIFO buffer.

Circular buffering makes a good implementation strategy for a queue that has fixed maximum size. Should a maximum size be adopted for a queue, then a ring buffer is a completely ideal implementation; all queue operations are constant time. However, expanding a ring buffer requires shifting memory, which is comparatively costly. For arbitrarily expanding queues, a linked list approach may be preferred instead.
