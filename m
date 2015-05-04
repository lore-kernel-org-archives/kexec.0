Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YpGpE-00027Z-5d
 for kexec@lists.infradead.org; Mon, 04 May 2015 13:54:25 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH RFC 3/3] arm64: Enable/disable D-cache before/after sha
 verification
Date: Mon,  4 May 2015 18:32:51 +0530
Message-Id: <2939844d0211a820cf22a8d666df90af889ec6f1.1430742915.git.panand@redhat.com>
In-Reply-To: <cover.1430742915.git.panand@redhat.com>
References: <cover.1430742915.git.panand@redhat.com>
In-Reply-To: <cover.1430742915.git.panand@redhat.com>
References: <cover.1430742915.git.panand@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: geoff@infradead.org
Cc: Pratyush Anand <panand@redhat.com>, takahiro.akashi@linaro.org, kexec@lists.infradead.org

Enable D cache before SHA verification and disable it before switching
to kernel.

Since we only map RAM area, therefore currently no printf is allowed
between d-cache enable and disable events. Identity mapping for port
area with device type memory attributes need to be created for printf to
work.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 purgatory/arch/arm64/purgatory-arm64.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/purgatory/arch/arm64/purgatory-arm64.c b/purgatory/arch/arm64/purgatory-arm64.c
index 3a1c9243bfa2..e045039039b6 100644
--- a/purgatory/arch/arm64/purgatory-arm64.c
+++ b/purgatory/arch/arm64/purgatory-arm64.c
@@ -2,6 +2,7 @@
  * ARM64 purgatory.
  */
 
+#include "cache.h"
 #include <stdint.h>
 #include <purgatory.h>
 
@@ -10,6 +11,8 @@
 extern uint32_t *arm64_sink;
 extern void (*arm64_kernel_entry)(uint64_t);
 extern uint64_t arm64_dtb_addr;
+extern uint64_t arm64_ram_start;
+extern uint64_t arm64_ram_end;
 
 static void wait_for_xmit_complete(void)
 {
@@ -44,14 +47,23 @@ void putchar(int ch)
 	}
 }
 
+uint64_t page_table[PAGE_TABLE_SIZE / sizeof(uint64_t)] __attribute__ ((aligned (PAGE_TABLE_SIZE))) = { };
+extern void enable_dcache(uint64_t , uint64_t , uint64_t *);
+extern void disable_dcache(uint64_t , uint64_t);
+
 void setup_arch(void)
 {
 	printf("purgatory: kernel_entry: %lx\n",
 		(unsigned long)arm64_kernel_entry);
 	printf("purgatory: dtb:          %lx\n", arm64_dtb_addr);
+	printf("purgatory: RAM start: %lx\n", arm64_ram_start);
+	printf("purgatory: RAM end: %lx\n", arm64_ram_end);
+
+	enable_dcache(arm64_ram_start, arm64_ram_end, page_table);
 }
 
 void post_verification_setup_arch(void)
 {
+	disable_dcache(arm64_ram_start, arm64_ram_end);
 	arm64_kernel_entry(arm64_dtb_addr);
 }
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
