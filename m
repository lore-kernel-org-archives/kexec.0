Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Npdek-0007Av-JR
	for kexec@lists.infradead.org; Thu, 11 Mar 2010 08:22:14 +0000
Subject: [PATCH 3/3] x86: Fix biarch crashdump setup.
References: <m1k4tjb7d1.fsf@fess.ebiederm.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 11 Mar 2010 00:22:07 -0800
In-Reply-To: <m1k4tjb7d1.fsf@fess.ebiederm.org> (Eric W. Biederman's message
	of "Thu\, 11 Mar 2010 00\:16\:58 -0800")
Message-ID: <m16353b74g.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Kexec Mailing List <kexec@lists.infradead.org>


Generate the correct crashdump header for x86_64 kernels
when a 32bit kernel is used.

Signed-off-by: Eric W. Biederman <ebiederm@aristanetworks.com>
---
 kexec/arch/i386/crashdump-x86.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 804dadd..9d37442 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -509,7 +509,7 @@ static struct crash_elf_info elf_info32 =
 static enum coretype get_core_type(struct kexec_info *info,
 				   struct memory_range *range, int ranges)
 {
-	if (info->kexec_flags & KEXEC_ARCH_X86_64)
+	if ((info->kexec_flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_X86_64)
 		return CORE_TYPE_ELF64;
 	else {
 		/* fall back to default */
@@ -534,6 +534,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	unsigned long sz, elfcorehdr;
 	int nr_ranges, align = 1024;
 	struct memory_range *mem_range, *memmap_p;
+	unsigned machine;
 
 	if (get_crash_memory_ranges(&mem_range, &nr_ranges,
 				    info->kexec_flags) < 0)
@@ -548,6 +549,12 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 			get_core_type(info, mem_range, nr_ranges);
 	}
 
+        /* Get the elf architecture of the running kernel */
+	machine = EM_386;
+	if ((info->kexec_flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_X86_64) {
+		machine = EM_X86_64;
+	}
+
 	/* Memory regions which panic kernel can safely use to boot into */
 	sz = (sizeof(struct memory_range) * (KEXEC_MAX_SEGMENTS + 1));
 	memmap_p = xmalloc(sz);
@@ -571,6 +578,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 
 	/* Create elf header segment and store crash image data. */
 	if (arch_options.core_header_type == CORE_TYPE_ELF64) {
+		elf_info64.machine = machine;
 		if (crash_create_elf64_headers(info, &elf_info64,
 					       crash_memory_range, nr_ranges,
 					       &tmp, &sz,
@@ -578,6 +586,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 			return -1;
 	}
 	else {
+		elf_info32.machine = machine;
 		if (crash_create_elf32_headers(info, &elf_info32,
 					       crash_memory_range, nr_ranges,
 					       &tmp, &sz,
-- 
1.6.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
