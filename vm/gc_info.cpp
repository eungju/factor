#include "master.hpp"

namespace factor
{

cell gc_info::return_address_index(cell return_address)
{
	u32 *return_address_array = return_addresses();

	for(cell i = 0; i < return_address_count; i++)
	{
		if(return_address == return_address_array[i])
			return i;
	}

	return (cell)-1;
}

}
