Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a5Fjl-0002cb-B1
 for kexec@lists.infradead.org; Sat, 05 Dec 2015 16:31:05 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH 3/4] arm64: Fix KVBASE
Date: Sat,  5 Dec 2015 22:00:02 +0530
Message-Id: <3c83adde922e0ce26bafd8b189242b73fadbe40e.1449332470.git.panand@redhat.com>
In-Reply-To: <cover.1449332470.git.panand@redhat.com>
References: <cover.1449332470.git.panand@redhat.com>
In-Reply-To: <cover.1449332470.git.panand@redhat.com>
References: <cover.1449332470.git.panand@redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, timur@codeaurora.org, asamson@codeaurora.org, kexec@lists.infradead.org, rruigrok@codeaurora.org, sgoel@codeaurora.org, dyoung@redhat.com

KVBASE should be VMALLOC_START. So fix it.

Signed-off-by: Pratyush Anand <panand@redhat.com>
Reported-by: Sameer Goel <sgoel@codeaurora.org>
---
 arch/arm64.c   | 3 ++-
 makedumpfile.h | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 4d50012529c3..a94a4ba16dd5 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -199,7 +199,8 @@ get_machdep_info_arm64(void)
 {
 	info->max_physmem_bits = PHYS_MASK_SHIFT;
 	info->section_size_bits = SECTIONS_SIZE_BITS;
-	info->page_offset = KVBASE;
+	info->page_offset = SYMBOL(_stext)
+		& (0xffffffffffffffffUL << (VA_BITS - 1));
 	info->vmalloc_start = 0xffffffffffffffffUL << VA_BITS;
 	info->vmalloc_end = PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - 0x10000;
 	info->vmemmap_start = VMALLOC_END + 0x10000;
diff --git a/makedumpfile.h b/makedumpfile.h
index abe6a9897095..c42fc8142663 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -507,8 +507,7 @@ int get_va_bits_arm64(void);
 #define ARM64_PGTABLE_LEVELS	get_pgtable_level_arm64()
 #define VA_BITS			get_va_bits_arm64()
 #define PAGE_SHIFT		get_page_shift_arm64()
-#define KVBASE_MASK		(0xffffffffffffffffUL << (VA_BITS - 1))
-#define KVBASE			(SYMBOL(_stext) & KVBASE_MASK)
+#define KVBASE			VMALLOC_START
 #endif /* aarch64 */
 
 #ifdef __arm__
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
