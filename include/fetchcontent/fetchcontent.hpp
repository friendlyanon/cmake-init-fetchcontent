#pragma once

#include <string>

#include <headeronly/headeronly.hpp>

namespace fc
{

/**
 * @brief Return the name of the headeronly dependency
 */
inline auto name() -> std::string
{
  return ::name();
}

}  // namespace fc
