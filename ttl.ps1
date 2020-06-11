function Set-TTL {
    param ($Val)
    Write-Host "IPv4 " -NoNewline -ForegroundColor Green
    netsh int ipv4 set glob defaultcurhoplimit=$Val
    Write-Host "IPv6 " -NoNewline -ForegroundColor Green
    netsh int ipv6 set glob defaultcurhoplimit=$Val
    Write-Host "TTL = $Val" -ForegroundColor Yellow
}

switch ($args[0]) {
    "-s" 
    { 
        Set-TTL -Val $args[1]
    }
    "-c"
    {
        ping 127.0.0.1 -n 1
    }
    "-a"
    {
        if ($args.Count -eq 1) 
        {
            $sec = 5;
        }
        else 
        {
            $sec = $args[1];
        }

        Set-TTL -Val 64
        Start-Sleep $sec
        Set-TTL -Val 65
    }
    "-h"
    {
        Write-Host "PowerShell script for change TTL value by MRGRD56" -BackgroundColor Yellow
        Write-Host "[-s <val>] - set TTL value to val"
        Write-Host "[-c] - check current TTL value"
        Write-Host "[-a <sec=5>] - set TTL to 64, wait (sec) seconds and set TTL to 65"
        Write-Host "[-hr] - get help in Russian language"
    }
    "-hr" 
    {
        Write-Host "[-s <val>] - устанавливает значение TTL = val"
        Write-Host "[-c] - проверяет текущее значение TTL"
        Write-Host "[-a (<sec=5>] - устанавливает TTL на 64, ждёт sec секунд и устанавливает TTL на 65"
    }
    Default 
    {
        Write-Host "Unknown argument. Try -h for help." -ForegroundColor Red
    }
}