Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byw5V-0000ag-Pg
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 07:24:01 +0000
Received: by mail-qk0-f177.google.com with SMTP id z190so253965998qkc.2
 for <kexec@lists.infradead.org>; Tue, 25 Oct 2016 00:23:36 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH Makedumpfile 05/10] arm64: fix page_offset definition
Date: Tue, 25 Oct 2016 12:52:57 +0530
Message-Id: <862a1692521ff11b2dd59e07eec0e9b2c3c253ae.1477378297.git.panand@redhat.com>
In-Reply-To: <cover.1477378297.git.panand@redhat.com>
References: <cover.1477378297.git.panand@redhat.com>
In-Reply-To: <cover.1477378297.git.panand@redhat.com>
References: <cover.1477378297.git.panand@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, sgoel@codeaurora.org, mansip@codeaurora.org, asamson@codeaurora.org, kexec@lists.infradead.org

arch/arm64/include/asm/memory.h defines PAGE_OFFSET as follows:

 #define PAGE_OFFSET             (UL(0xffffffffffffffff) << (VA_BITS - 1))

Use same definition in makedumpfile as well.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index c73efa1aad54..ce5869452484 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -203,8 +203,7 @@ get_machdep_info_arm64(void)
 {
 	info->max_physmem_bits = PHYS_MASK_SHIFT;
 	info->section_size_bits = SECTIONS_SIZE_BITS;
-	info->page_offset = SYMBOL(_stext)
-		& (0xffffffffffffffffUL << (VA_BITS - 1));
+	info->page_offset = 0xffffffffffffffffUL << (VA_BITS - 1);
 	info->vmalloc_start = 0xffffffffffffffffUL << VA_BITS;
 	info->vmalloc_end = PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - 0x10000;
 	info->vmemmap_start = VMALLOC_END + 0x10000;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
