#include <Python.h>
#include "../fizzy.h"

static PyObject *fizz_fizzy(PyObject *self, PyObject *args) {
    int start, end, ret;

    if (!PyArg_ParseTuple(args, "i", &start))
        return NULL;
    if (!PyArg_ParseTuple(args, "i", &end))
        return NULL;

    ret = fizzy(start, end);
    return Py_BuildValue("i", ret);
}

static PyMethodDef FizzMethods[] = {
    { "fizzy", fizz_fizzy, METH_VARARGS, "Fizz the buzz" },
    { NULL, NULL, 0, NULL } /* Sentinel */
};

PyMODINIT_FUNC initfizz(void) {
    (void)Py_InitModule("fizz", FizzMethods);
}
