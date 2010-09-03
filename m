Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ew0-f49.google.com ([209.85.215.49])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OrVyY-0007NU-3h
	for kexec@lists.infradead.org; Fri, 03 Sep 2010 13:06:42 +0000
Received: by ewy9 with SMTP id 9so1161773ewy.36
	for <kexec@lists.infradead.org>; Fri, 03 Sep 2010 06:06:35 -0700 (PDT)
From: Maxim Uvarov <muvarov@gmail.com>
Subject: [PATCH] mips/crashdump put cmdline after the latest segment
Date: Fri, 03 Sep 2010 17:06:32 +0400
Message-ID: <20100903130632.2859.83145.stgit@muvarov>
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
To: kexec@lists.infradead.org

From: Maxim Uvarov <muvarov@gmail.com>

Move cmdline from just after .bss segment to the just after
the latest segment to avoid segments overlap while loading
crashdump kernel. (new mips vmlinux has additional segments
after .bss).
Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
---

 kexec/arch/mips/kexec-elf-mips.c |   35 +++++++++--------------------------
 1 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
index a9c865e..3e19ca2 100644
--- a/kexec/arch/mips/kexec-elf-mips.c
+++ b/kexec/arch/mips/kexec-elf-mips.c
@@ -80,7 +80,6 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 	int result;
 	unsigned long cmdline_addr;
 	size_t i;
-	unsigned long bss_start = 0, bss_size = 0;
 
 	/* See options.h if adding any more options. */
 	static const struct option options[] = {
@@ -133,22 +132,6 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 			phdr->p_paddr = virt_to_phys(phdr->p_paddr);
 	}
 
-	for (i = 0; i < ehdr.e_shnum; i++) {
-		struct mem_shdr *shdr;
-		unsigned char *strtab;
-		strtab = (unsigned char *)ehdr.e_shdr[ehdr.e_shstrndx].sh_data;
-
-		shdr = &ehdr.e_shdr[i];
-		if (shdr->sh_size &&
-				strcmp((char *)&strtab[shdr->sh_name],
-					".bss") == 0) {
-			bss_start = virt_to_phys(shdr->sh_addr);
-			bss_size = shdr->sh_size;
-			break;
-		}
-
-	}
-
 	/* Load the Elf data */
 	result = elf_exec_load(&ehdr, info);
 	if (result < 0)
@@ -156,15 +139,6 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 
 	info->entry = (void *)virt_to_phys(ehdr.e_entry);
 
-	/* Put cmdline right after bss for crash*/
-	if (info->kexec_flags & KEXEC_ON_CRASH)
-		cmdline_addr = bss_start + bss_size;
-	else
-		cmdline_addr = 0;
-
-	if (!bss_size)
-		die("No .bss segment present\n");
-
 	if (command_line)
 		command_line_len = strlen(command_line) + 1;
 
@@ -183,6 +157,15 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 		strncat(cmdline_buf, crash_cmdline,
 				sizeof(crash_cmdline) -
 				strlen(crash_cmdline) - 1);
+
+	if (info->kexec_flags & KEXEC_ON_CRASH)
+		/* In case of crashdump segment[0] is kernel.
+		 * Put cmdline just after it. */
+		cmdline_addr = info->segment[0].mem +
+				info->segment[0].memsz;
+	else
+		cmdline_addr = 0;
+
 	add_buffer(info, cmdline_buf, sizeof(cmdline_buf),
 			sizeof(cmdline_buf), sizeof(void *),
 			cmdline_addr, 0x0fffffff, 1);


Best regards,
Maxim Uvarov.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
