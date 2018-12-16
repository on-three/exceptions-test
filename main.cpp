#include <iostream>

struct NeedsCleanUp
{
    const int item;

    NeedsCleanUp(int i)
        : item { i }
    {
        std::cout << "Creating cleanup item " << item << std::endl;
    }

    NeedsCleanUp(const NeedsCleanUp& src)
        : item { 100 + src.item }
    {
        std::cout << "Copying cleanup item " << src.item << " to "
                  << item << std::endl;
    }

    ~NeedsCleanUp()
    {
        std::cout << "Destroying cleanup item " << item << std::endl;
    }
};

int main(int argc, char* argv[])
{
    NeedsCleanUp ex { 1 };
    std::exception_ptr exp1 { std::make_exception_ptr(ex) };
    std::exception_ptr exp2 { exp1 };

    try
    {
        [&exp1] {
            NeedsCleanUp cl { 2 };  // causes "resuming exception"
                                    // ref count reset
            std::rethrow_exception(exp1);
        } ();
    }
    catch (...)
    {
    }

    return 0;
}

