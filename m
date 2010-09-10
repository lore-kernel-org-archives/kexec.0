From: Eric W. Biederman <ebiederm@xmission.com>
Date: Fri, 10 Sep 2010 11:57:36 -0700
Subject: [PATCH] x86 crashdump: On x86_64 generate EM_X86_64 crashdump headers.
Message-ID: <mailman.237.1284146353.27306.kexec@lists.infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Paper bag time.  I forgot to double check my changes worked
on x86_64.  So I wound up with x86_64 putting i386 crashdump headers
on when it generated a crashdump header.  Ouch!

Fix it by using the new KEXEC_ARCH_NATIVE value so we can see what
we are doing.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 kexec/arch/i386/crashdump-x86.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 06e5ae9..e202e36 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -690,19 +690,32 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	int nr_ranges, align = 1024, i;
 	struct memory_range *mem_range, *memmap_p;
 	struct crash_elf_info elf_info;
+	unsigned kexec_arch;
 
 	/* Constant parts of the elf_info */
 	elf_info.data             = ELFDATA2LSB;
 	elf_info.backup_src_start = BACKUP_SRC_START;
 	elf_info.backup_src_end   = BACKUP_SRC_END;
 
+	/* Get the architecture of the running kernel */
+	kexec_arch = elf_info.machine & KEXEC_ARCH_MASK;
+	if (kexec_arch == KEXEC_ARCH_DEFAULT)
+		kexec_arch = KEXEC_ARCH_NATIVE;
+	
         /* Get the elf architecture of the running kernel */
-	if ((info->kexec_flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_X86_64) {
+	switch(kexec_arch) {
+	case KEXEC_ARCH_X86_64:
 		elf_info.machine = EM_X86_64;
-	} else {
+		break;
+	case KEXEC_ARCH_386:
 		elf_info.machine       = EM_386;
 		elf_info.lowmem_limit  = X86_MAXMEM;
 		elf_info.get_note_info = get_crash_notes;
+		break;
+	default:
+		fprintf(stderr, "unsupported crashdump architecture: %04x\n",
+			kexec_arch);
+		return -1;
 	}
 
 	if (get_crash_memory_ranges(&mem_range, &nr_ranges,
-- 
1.6.5.2.143.g8cc62


