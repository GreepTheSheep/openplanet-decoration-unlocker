$compress = @{
    Path = "./info.toml", "./src"
    CompressionLevel = "Fastest"
    DestinationPath = "./DecorationUnlocker.op"
}
Compress-Archive @compress -Force

Write-Host("✅ Done!")