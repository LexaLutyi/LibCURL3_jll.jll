# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule LibCURL3_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("LibCURL3")
JLLWrappers.@generate_main_file("LibCURL3", UUID("a3500760-7915-57d1-8b68-47e548e93688"))
end  # module LibCURL3_jll
