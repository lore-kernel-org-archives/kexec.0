Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e19.ny.us.ibm.com ([129.33.205.209])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZOVZN-0001H6-V3
 for kexec@lists.infradead.org; Sun, 09 Aug 2015 18:43:42 +0000
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <schwidefsky@de.ibm.com>;
 Sun, 9 Aug 2015 14:43:18 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C14426E8041
 for <kexec@lists.infradead.org>; Sun,  9 Aug 2015 14:35:00 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t79IhFKn57147576
 for <kexec@lists.infradead.org>; Sun, 9 Aug 2015 18:43:15 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t79IhFoC009299
 for <kexec@lists.infradead.org>; Sun, 9 Aug 2015 14:43:15 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] kexec: allocate the kexec control page with
 KEXEC_CONTROL_MEMORY_GFP
Date: Tue, 21 Apr 2015 14:06:32 +0200
Message-Id: <1429617992-31686-2-git-send-email-schwidefsky@de.ibm.com>
In-Reply-To: <1429617992-31686-1-git-send-email-schwidefsky@de.ibm.com>
References: <1429617992-31686-1-git-send-email-schwidefsky@de.ibm.com>
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
To: Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

Introduce KEXEC_CONTROL_MEMORY_GFP to allow the architecture code
to override the gfp flags of the allocation for the kexec control
page. The loop in kimage_alloc_normal_control_pages allocates pages
with GFP_KERNEL until a page is found that happens to have an
address smaller than the KEXEC_CONTROL_MEMORY_LIMIT. On systems
with a large memory size but a small KEXEC_CONTROL_MEMORY_LIMIT
the loop will keep allocating memory until the oom killer steps in.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/kexec.h | 3 +++
 include/linux/kexec.h         | 4 ++++
 kernel/kexec.c                | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index 694bcd6..2f924bc 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -26,6 +26,9 @@
 /* Not more than 2GB */
 #define KEXEC_CONTROL_MEMORY_LIMIT (1UL<<31)
 
+/* Allocate control page with GFP_DMA */
+#define KEXEC_CONTROL_MEMORY_GFP GFP_DMA
+
 /* Maximum address we can use for the crash control pages */
 #define KEXEC_CRASH_CONTROL_MEMORY_LIMIT (-1UL)
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e60a745..e804306 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -40,6 +40,10 @@
 #error KEXEC_CONTROL_MEMORY_LIMIT not defined
 #endif
 
+#ifndef KEXEC_CONTROL_MEMORY_GFP
+#define KEXEC_CONTROL_MEMORY_GFP GFP_KERNEL
+#endif
+
 #ifndef KEXEC_CONTROL_PAGE_SIZE
 #error KEXEC_CONTROL_PAGE_SIZE not defined
 #endif
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 38c25b1..7a36fdc 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -707,7 +707,7 @@ static struct page *kimage_alloc_normal_control_pages(struct kimage *image,
 	do {
 		unsigned long pfn, epfn, addr, eaddr;
 
-		pages = kimage_alloc_pages(GFP_KERNEL, order);
+		pages = kimage_alloc_pages(KEXEC_CONTROL_MEMORY_GFP, order);
 		if (!pages)
 			break;
 		pfn   = page_to_pfn(pages);
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
