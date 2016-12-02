Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailapp01.imgtec.com ([195.59.15.196])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cCkTb-0000vf-3l
 for kexec@lists.infradead.org; Fri, 02 Dec 2016 09:49:59 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
 by Forcepoint Email with ESMTPS id A323DB7BA62EB
 for <kexec@lists.infradead.org>; Fri,  2 Dec 2016 09:49:27 +0000 (GMT)
From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH 2/6] mips: use arch_options for both 32 and 64 bit variants
Date: Fri, 2 Dec 2016 10:49:07 +0100
Message-ID: <1480672151-18503-3-git-send-email-marcin.nowakowski@imgtec.com>
In-Reply-To: <1480672151-18503-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1480672151-18503-1-git-send-email-marcin.nowakowski@imgtec.com>
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

At the moment arch_options structure is defined for 64-bit only and is
used exclusively in ifdef'ed code. Remove the ifdefs around the uses of
the structure and define it for all code variants as it will be used for
passing more arch options in the followup commits.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 kexec/arch/mips/crashdump-mips.c | 7 ++-----
 kexec/arch/mips/kexec-mips.c     | 8 +++++---
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index dc68cb4..e56b3ef 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -288,7 +288,6 @@ static int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr)
 	return 0;
 }
 
-#ifdef __mips64
 static struct crash_elf_info elf_info64 = {
 	class: ELFCLASS64,
 	data : ELFDATA2MSB,
@@ -296,7 +295,7 @@ static struct crash_elf_info elf_info64 = {
 	page_offset : PAGE_OFFSET,
 	lowmem_limit : MAXMEM,
 };
-#endif
+
 static struct crash_elf_info elf_info32 = {
 	class: ELFCLASS32,
 	data : ELFDATA2MSB,
@@ -321,13 +320,11 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	struct crash_elf_info *elf_info = &elf_info32;
 	unsigned long start_offset = 0x80000000UL;
 
-#ifdef __mips64
 	if (arch_options.core_header_type == CORE_TYPE_ELF64) {
 		elf_info = &elf_info64;
 		crash_create = crash_create_elf64_headers;
-		start_offset = 0xffffffff80000000UL;
+		start_offset = (unsigned long)0xffffffff80000000UL;
 	}
-#endif
 
 	if (get_kernel_paddr(elf_info))
 		return -1;
diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index ebc3d9a..de9019a 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -76,11 +76,13 @@ void arch_usage(void)
 {
 }
 
-#ifdef __mips64
 struct arch_options_t arch_options = {
-	.core_header_type = CORE_TYPE_ELF64
-};
+#ifdef __mips64
+	.core_header_type = CORE_TYPE_ELF64,
+#else
+	.core_header_type = CORE_TYPE_ELF32,
 #endif
+};
 
 int arch_process_options(int argc, char **argv)
 {
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
