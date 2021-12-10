Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvWGM-000iVD-G3
 for kexec@lists.infradead.org; Fri, 10 Dec 2021 03:07:59 +0000
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37F2881CCB4
 for <kexec@lists.infradead.org>; Fri, 10 Dec 2021 03:07:53 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH 2/3] arm64/crashdump: unify routine to get page_offset
Date: Fri, 10 Dec 2021 11:07:34 +0800
Message-Id: <20211210030735.53155-3-piliu@redhat.com>
In-Reply-To: <20211210030735.53155-1-piliu@redhat.com>
References: <20211210030735.53155-1-piliu@redhat.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>

There are two funcs to get page_offset:
  get_kernel_page_offset()
  get_page_offset()

Since get_kernel_page_offset() does not observe the kernel formula, and
remove it. Unify them in order to introduce 52-bits VA kernel more
easily in the coming patch.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 kexec/arch/arm64/crashdump-arm64.c | 23 +----------------------
 kexec/arch/arm64/kexec-arm64.c     |  4 ++--
 kexec/arch/arm64/kexec-arm64.h     |  1 +
 3 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index a02019a..0a8d44c 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -46,27 +46,6 @@ static struct crash_elf_info elf_info = {
 	.machine	= EM_AARCH64,
 };
 
-/*
- * Note: The returned value is correct only if !CONFIG_RANDOMIZE_BASE.
- */
-static uint64_t get_kernel_page_offset(void)
-{
-	int i;
-
-	if (elf_info.kern_vaddr_start == UINT64_MAX)
-		return UINT64_MAX;
-
-	/* Current max virtual memory range is 48-bits. */
-	for (i = 48; i > 0; i--)
-		if (!(elf_info.kern_vaddr_start & (1UL << i)))
-			break;
-
-	if (i <= 0)
-		return UINT64_MAX;
-	else
-		return UINT64_MAX << i;
-}
-
 /*
  * iomem_range_callback() - callback called for each iomem region
  * @data: not used
@@ -198,7 +177,7 @@ int load_crashdump_segments(struct kexec_info *info)
 	if (err)
 		return EFAILED;
 
-	elf_info.page_offset = get_kernel_page_offset();
+	get_page_offset(&elf_info.page_offset);
 	dbgprintf("%s: page_offset:   %016llx\n", __func__,
 			elf_info.page_offset);
 
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 7373fa3..bd650e6 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -909,7 +909,7 @@ static int get_va_bits(void)
  * get_page_offset - Helper for getting PAGE_OFFSET
  */
 
-static int get_page_offset(void)
+int get_page_offset(unsigned long *page_offset)
 {
 	int ret;
 
@@ -954,7 +954,7 @@ int get_phys_base_from_pt_load(long *phys_offset)
 	unsigned long long phys_start;
 	unsigned long long virt_start;
 
-	ret = get_page_offset();
+	ret = get_page_offset(&page_offset);
 	if (ret < 0)
 		return ret;
 
diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index 1844b67..ed99d9d 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -69,6 +69,7 @@ extern struct arm64_mem arm64_mem;
 
 uint64_t get_phys_offset(void);
 uint64_t get_vp_offset(void);
+int get_page_offset(unsigned long *offset);
 
 static inline void reset_vp_offset(void)
 {
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
