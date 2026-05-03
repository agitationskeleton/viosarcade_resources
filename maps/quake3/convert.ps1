$inputDir = Get-Location
$outputDir = "$inputDir\out"
$magickPath = "C:\Program Files\ImageMagick-7.1.1-Q16-HDRI\magick.exe"

if (!(Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

$files = Get-ChildItem -Path $inputDir\*.tga, $inputDir\*.jpg -File

if ($files.Count -eq 0) {
    Write-Host "No .tga or .jpg files found in: $inputDir"
} else {
    foreach ($file in $files) {
        $inputFile = $file.FullName
        $filenameNoExt = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        $outputFile = Join-Path $outputDir "$filenameNoExt.png"
        
        Write-Host "Converting: $inputFile -> $outputFile"
        & "$magickPath" convert "$inputFile" -resize 480x270^^>^^> -gravity center -extent 480x270 "$outputFile"
    }
}
