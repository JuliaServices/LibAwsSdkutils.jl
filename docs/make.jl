using LibAwsSdkutils
using Documenter

DocMeta.setdocmeta!(LibAwsSdkutils, :DocTestSetup, :(using LibAwsSdkutils); recursive=true)

makedocs(;
    modules=[LibAwsSdkutils],
    repo="https://github.com/JuliaServices/LibAwsSdkutils.jl/blob/{commit}{path}#{line}",
    sitename="LibAwsSdkutils.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://github.com/JuliaServices/LibAwsSdkutils.jl",
        assets=String[],
        size_threshold=2_000_000, # 2 MB, we generate about 1 MB page
        size_threshold_warn=2_000_000,
    ),
    pages=["Home" => "index.md"],
)

deploydocs(; repo="github.com/JuliaServices/LibAwsSdkutils.jl", devbranch="main")
