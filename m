Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aOAgf-0000WD-9I
 for kexec@lists.infradead.org; Tue, 26 Jan 2016 20:58:07 +0000
From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH 07/17] kexec: Set IORESOURCE_SYSTEM_RAM for System RAM
Date: Tue, 26 Jan 2016 21:57:23 +0100
Message-Id: <1453841853-11383-8-git-send-email-bp@alien8.de>
In-Reply-To: <1453841853-11383-1-git-send-email-bp@alien8.de>
References: <1453841853-11383-1-git-send-email-bp@alien8.de>
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
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Minfei Huang <mnfhuang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

From: Toshi Kani <toshi.kani@hpe.com>

Set proper ioresource flags and types for crash kernel reservation
areas.

Reviewed-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm <linux-mm@kvack.org>
Cc: Minfei Huang <mnfhuang@gmail.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Link: http://lkml.kernel.org/r/1452020081-26534-7-git-send-email-toshi.kani@hpe.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 kernel/kexec_core.c | 8 +++++---
 kernel/kexec_file.c | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 8dc659144869..8d34308ea449 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -66,13 +66,15 @@ struct resource crashk_res = {
 	.name  = "Crash kernel",
 	.start = 0,
 	.end   = 0,
-	.flags = IORESOURCE_BUSY | IORESOURCE_MEM
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_CRASH_KERNEL
 };
 struct resource crashk_low_res = {
 	.name  = "Crash kernel",
 	.start = 0,
 	.end   = 0,
-	.flags = IORESOURCE_BUSY | IORESOURCE_MEM
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_CRASH_KERNEL
 };
 
 int kexec_should_crash(struct task_struct *p)
@@ -959,7 +961,7 @@ int crash_shrink_memory(unsigned long new_size)
 
 	ram_res->start = end;
 	ram_res->end = crashk_res.end;
-	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_MEM;
+	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
 	ram_res->name = "System RAM";
 
 	crashk_res.end = end - 1;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 007b791f676d..2bfcdc064116 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -525,7 +525,7 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 	/* Walk the RAM ranges and allocate a suitable range for the buffer */
 	if (image->type == KEXEC_TYPE_CRASH)
 		ret = walk_iomem_res("Crash kernel",
-				     IORESOURCE_MEM | IORESOURCE_BUSY,
+				     IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
 				     crashk_res.start, crashk_res.end, kbuf,
 				     locate_mem_hole_callback);
 	else
-- 
2.3.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
