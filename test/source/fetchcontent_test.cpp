#include "fetchcontent/fetchcontent.hpp"

auto main() -> int
{
  auto result = fc::name();
  return result == "headeronly" ? 0 : 1;
}
