Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2nam01on0060.outbound.protection.outlook.com
 ([104.47.34.60] helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e2kd9-0002wx-3K
 for kexec@lists.infradead.org; Thu, 12 Oct 2017 21:03:01 +0000
From: David Daney <david.daney@cavium.com>
Subject: [PATCH 2/4] kexec-tools: mips: Don't set lowmem_limit to 2G for
 64-bit systems.
Date: Thu, 12 Oct 2017 14:02:26 -0700
Message-Id: <20171012210228.7353-3-david.daney@cavium.com>
In-Reply-To: <20171012210228.7353-1-david.daney@cavium.com>
References: <20171012210228.7353-1-david.daney@cavium.com>
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
To: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
Cc: linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>

The 64-bit MIPS architecture doesn't have the same 2G limit the 32-bit
version has.  Set MAXMEM and lowmem_limit to 0 for 64-bit MIPS so that
memory above 2G is usable in the kdump core files.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 kexec/arch/mips/crashdump-mips.c | 4 ++--
 kexec/arch/mips/crashdump-mips.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index 6308ec8..22fc38e 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -201,7 +201,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 		memory_ranges++;
 
 		/* Segregate linearly mapped region. */
-		if ((MAXMEM - 1) >= start && (MAXMEM - 1) <= end) {
+		if (MAXMEM && (MAXMEM - 1) >= start && (MAXMEM - 1) <= end) {
 			crash_memory_range[memory_ranges - 1].end = MAXMEM - 1;
 
 			/* Add segregated region. */
@@ -304,7 +304,7 @@ static struct crash_elf_info elf_info64 = {
 	data : ELFDATALOCAL,
 	machine : EM_MIPS,
 	page_offset : PAGE_OFFSET,
-	lowmem_limit : MAXMEM,
+	lowmem_limit : 0, /* 0 == no limit */
 };
 
 static struct crash_elf_info elf_info32 = {
diff --git a/kexec/arch/mips/crashdump-mips.h b/kexec/arch/mips/crashdump-mips.h
index c986835..7edd859 100644
--- a/kexec/arch/mips/crashdump-mips.h
+++ b/kexec/arch/mips/crashdump-mips.h
@@ -6,12 +6,13 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 				unsigned long max_addr, unsigned long min_base);
 #ifdef __mips64
 #define PAGE_OFFSET	0xa800000000000000ULL
+#define MAXMEM		0
 #else
 #define PAGE_OFFSET	0x80000000
+#define MAXMEM		0x80000000
 #endif
 #define __pa(x)		((unsigned long)(X) & 0x7fffffff)
 
-#define MAXMEM		0x80000000
 
 #define CRASH_MAX_MEMMAP_NR	(KEXEC_MAX_SEGMENTS + 1)
 #define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)
-- 
2.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
