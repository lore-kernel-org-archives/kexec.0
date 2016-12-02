Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailapp01.imgtec.com ([195.59.15.196])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cCkTb-0000w4-48
 for kexec@lists.infradead.org; Fri, 02 Dec 2016 09:49:59 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
 by Forcepoint Email with ESMTPS id 4149CE615A2F4
 for <kexec@lists.infradead.org>; Fri,  2 Dec 2016 09:49:29 +0000 (GMT)
From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH 4/6] mips: crashdump: add little-endian support
Date: Fri, 2 Dec 2016 10:49:09 +0100
Message-ID: <1480672151-18503-5-git-send-email-marcin.nowakowski@imgtec.com>
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

Elf header for crashdump has until now been hardcoded as big-endian.
Change that to use the native endianness for the compile target so that
the crashdumps are generated properly for each CPU type.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 kexec/arch/mips/crashdump-mips.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index e56b3ef..278ee01 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -288,9 +288,17 @@ static int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr)
 	return 0;
 }
 
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+# define ELFDATALOCAL ELFDATA2LSB
+#elif __BYTE_ORDER == __BIG_ENDIAN
+# define ELFDATALOCAL ELFDATA2MSB
+#else
+# error Unknown byte order
+#endif
+
 static struct crash_elf_info elf_info64 = {
 	class: ELFCLASS64,
-	data : ELFDATA2MSB,
+	data : ELFDATALOCAL,
 	machine : EM_MIPS,
 	page_offset : PAGE_OFFSET,
 	lowmem_limit : MAXMEM,
@@ -298,7 +306,7 @@ static struct crash_elf_info elf_info64 = {
 
 static struct crash_elf_info elf_info32 = {
 	class: ELFCLASS32,
-	data : ELFDATA2MSB,
+	data : ELFDATALOCAL,
 	machine : EM_MIPS,
 	page_offset : PAGE_OFFSET,
 	lowmem_limit : MAXMEM,
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
