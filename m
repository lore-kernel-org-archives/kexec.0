Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VS5GC-0003Wa-Ef
 for kexec@lists.infradead.org; Fri, 04 Oct 2013 13:17:36 +0000
Received: by mail-lb0-f169.google.com with SMTP id z5so3325319lbh.0
 for <kexec@lists.infradead.org>; Fri, 04 Oct 2013 06:17:13 -0700 (PDT)
From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: [PATCH] kexec: arm: Fix endianness in crashdump header
Date: Fri,  4 Oct 2013 16:17:07 +0300
Message-Id: <1380892627-25525-1-git-send-email-taras.kondratiuk@linaro.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: Linaro Networking <linaro-networking@linaro.org>, kexec@lists.infradead.org

Currently little-endian ELFDATA is hard-coded in crashdump header.
This lead to a wrong header format if crashdump is generated on BE system.

Set native endianness into ELFDATA field.

Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
 kexec/arch/arm/crashdump-arm.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 01973b1..0cd6935 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -31,6 +31,13 @@
 #include "../../crashdump.h"
 #include "crashdump-arm.h"
 
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#define ELFDATANATIVE ELFDATA2LSB
+#elif __BYTE_ORDER == __BIG_ENDIAN
+#define ELFDATANATIVE ELFDATA2MSB
+#else
+#error "Unknown machine endian"
+#endif
 
 /*
  * Used to save various memory ranges/regions needed for the captured
@@ -47,7 +54,7 @@ static struct memory_range crash_reserved_mem;
 
 static struct crash_elf_info elf_info = {
 	.class		= ELFCLASS32,
-	.data		= ELFDATA2LSB,
+	.data		= ELFDATANATIVE,
 	.machine	= EM_ARM,
 	.page_offset	= PAGE_OFFSET,
 };
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
