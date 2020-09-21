/*
 * @Description: 
 * @Author: ekibun
 * @Date: 2020-09-21 19:53:44
 * @LastEditors: ekibun
 * @LastEditTime: 2020-09-21 22:20:25
 */
#include "iconv.hpp"

#ifdef _MSC_VER
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT __attribute__((visibility("default")))
#define strcpy_s(a, l, b) strcpy(a, b)
#endif

extern "C"
{
  DLLEXPORT const char *convert(char *from, char *to, int32_t fatal, char *str)
  {

    std::string output;
    iconvpp::converter(from, to, !fatal).convert(std::string(str), output);
    size_t len = output.size() + 1;
    char *ret = new char[len];
    strcpy_s(ret, len, output.c_str());
    return ret;
  }

  DLLEXPORT void freeChar(char *str)
  {
    delete[] str;
  }
}