using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPPStorageApplication.Core.Mapper
{
    public interface ICustomMapper<A,B>
    {
        B convert(A source);
    }
}
