using Test, Aqua, LibAwsSdkutils, LibAwsCommon

@testset "LibAwsSdkutils" begin
    @testset "aqua" begin
        Aqua.test_all(LibAwsSdkutils, ambiguities=false)
        Aqua.test_ambiguities(LibAwsSdkutils)
    end
    @testset "basic usage to test the library loads" begin
        alloc = aws_default_allocator() # important! this shouldn't need to be qualified! if we generate a definition for it in LibAwsSdkutils that is a bug.
        aws_sdkutils_library_init(alloc)
    end
end
