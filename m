Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bY1DS-0008Kj-7g
 for kexec@lists.infradead.org; Fri, 12 Aug 2016 01:24:54 +0000
From: Sameer Goel <sgoel@codeaurora.org>
Subject: [PATCH V2] arm64:kexec: Memstart should not be before the kernel
 start address
Date: Thu, 11 Aug 2016 19:24:29 -0600
Message-Id: <1470965069-20121-1-git-send-email-sgoel@codeaurora.org>
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
Cc: panand@redhat.com, timur@codeaurora.org, kexec@lists.infradead.org, rruigrok@codeaurora.org, takahiro.akashi@linaro.org, Sameer Goel <sgoel@codeaurora.org>

Starting 4.6 the kernel memblock start is rounded down to a desirable
alignment. So, the kernel can see reserved meory regions before the kernel
start address in the iomem query.
Need to make sure that the right kernel start address is picked from the iomem
query.

Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
---
This change should be applied on top of geoff kexec-tools v3 branch from
arm64[1] +  bugfix[2]

[1] http://lists.infradead.org/pipermail/kexec/2016-August/016768.html
[2] http://lists.infradead.org/pipermail/kexec/2016-July/016664.html

 kexec/arch/arm64/kexec-arm64.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 940cddb..7a1d4fc 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -25,6 +25,11 @@
 
 /* Global varables the core kexec routines expect. */
 
+#define SZ_2M 0x200000
+#define __round_mask(x, y) ((__typeof__(x))((y)-1))
+#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
+#define round_down(x, y) ((x) & ~__round_mask(x, y))
+
 unsigned char reuse_initrd;
 
 off_t initrd_base;
@@ -448,6 +453,27 @@ void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
 	add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
 }
 
+static int get_memory_ranges_iomem_kc_cb(void *data, int nr, char *str,
+	unsigned long long base, unsigned long long length)
+{
+	struct memory_range *r;
+
+	if (nr >= KEXEC_SEGMENT_MAX)
+		return -1;
+
+	r = (struct memory_range *)data + nr;
+	r->type = RANGE_RAM;
+	r->start = base;
+	r->end = base + length - 1;
+
+	set_phys_offset(round_down(r->start, SZ_2M));
+
+	dbgprintf("%s: %016llx - %016llx : %s", __func__, r->start,
+		r->end, str);
+
+	return 0;
+}
+
 /**
  * get_memory_ranges_iomem_cb - Helper for get_memory_ranges_iomem.
  */
@@ -465,7 +491,6 @@ static int get_memory_ranges_iomem_cb(void *data, int nr, char *str,
 	r->start = base;
 	r->end = base + length - 1;
 
-	set_phys_offset(r->start);
 
 	dbgprintf("%s: %016llx - %016llx : %s", __func__, r->start,
 		r->end, str);
@@ -480,6 +505,14 @@ static int get_memory_ranges_iomem_cb(void *data, int nr, char *str,
 static int get_memory_ranges_iomem(struct memory_range *array,
 	unsigned int *count)
 {
+	*count = kexec_iomem_for_each_line("Kernel code\n",
+		get_memory_ranges_iomem_kc_cb, array);
+
+	if (!*count) {
+		dbgprintf("%s: failed: No code segment found.\n", __func__);
+		return -EFAILED;
+	}
+
 	*count = kexec_iomem_for_each_line("System RAM\n",
 		get_memory_ranges_iomem_cb, array);
 
-- 
Qualcomm Innovation Center, Inc. Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
