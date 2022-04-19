From: abuehaze14 <abuehaze@amazon.com>
Date: Tue, 19 Apr 2022 17:23:27 +0000
Subject: [PATCH] arm64/crashdump-arm64: increase CRASH_MAX_MEMORY_RANGES to 32k
Message-ID: <20220419172327.11288-1-abuehaze@amazon.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On ARM64 based VMs hotplugging more than 31GB of memory will cause
kdump to fail loading as it's hitting the CRASH_MAX_MEMORY_RANGES
limit which is currently 32 on ARM64 given that the  memory block size
is 1GB. This patch is raising CRASH_MAX_MEMORY_RANGES
to 32K similar to what we have on x86, this should allow
kdump to work until the VM has 32TB which should be
enough for a long time.

Signed-off-by: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
---
 kexec/arch/arm64/crashdump-arm64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.h b/kexec/arch/arm64/crashdump-arm64.h
index 12f4308..82fa69b 100644
--- a/kexec/arch/arm64/crashdump-arm64.h
+++ b/kexec/arch/arm64/crashdump-arm64.h
@@ -14,7 +14,7 @@
 
 #include "kexec.h"
 
-#define CRASH_MAX_MEMORY_RANGES	32
+#define CRASH_MAX_MEMORY_RANGES	32768
 
 /* crash dump kernel support at most two regions, low_region and high region. */
 #define CRASH_MAX_RESERVED_RANGES	2
-- 
2.32.0


