From: Baoquan He <bhe@redhat.com>
Date: Tue, 26 Apr 2022 08:14:15 +0800
Subject: [PATCH] arm64/crashdump-arm64: increase CRASH_MAX_MEMORY_RANGES
 to 32k
In-Reply-To: <20220419172327.11288-1-abuehaze@amazon.com>
References: <20220419172327.11288-1-abuehaze@amazon.com>
Message-ID: <Ymc5VxBOQgyrrN+y@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 04/19/22 at 05:23pm, abuehaze14 wrote:
> On ARM64 based VMs hotplugging more than 31GB of memory will cause
> kdump to fail loading as it's hitting the CRASH_MAX_MEMORY_RANGES
> limit which is currently 32 on ARM64 given that the  memory block size
> is 1GB. This patch is raising CRASH_MAX_MEMORY_RANGES
> to 32K similar to what we have on x86, this should allow
> kdump to work until the VM has 32TB which should be
> enough for a long time.
> 
> Signed-off-by: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>

Sounds reasonable.

Acked-by: Baoquan He <bhe@redhat.com>

By the way, Simon usually collects kexec-tools patches every one to two
weeks, no need to always ping in a short time.

> ---
>  kexec/arch/arm64/crashdump-arm64.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kexec/arch/arm64/crashdump-arm64.h b/kexec/arch/arm64/crashdump-arm64.h
> index 12f4308..82fa69b 100644
> --- a/kexec/arch/arm64/crashdump-arm64.h
> +++ b/kexec/arch/arm64/crashdump-arm64.h
> @@ -14,7 +14,7 @@
>  
>  #include "kexec.h"
>  
> -#define CRASH_MAX_MEMORY_RANGES	32
> +#define CRASH_MAX_MEMORY_RANGES	32768
>  
>  /* crash dump kernel support at most two regions, low_region and high region. */
>  #define CRASH_MAX_RESERVED_RANGES	2
> -- 
> 2.32.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


