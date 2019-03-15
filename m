Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h4jFv-0007z3-8U
 for kexec@lists.infradead.org; Fri, 15 Mar 2019 09:36:01 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH] kexec/x86: Unconditionally add the acpi_rsdp command line
Date: Fri, 15 Mar 2019 17:35:47 +0800
Message-Id: <20190315093547.6057-1-lijiang@redhat.com>
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
To: kexec@lists.infradead.org
Cc: dyoung@redhat.com, brijesh.singh@amd.com, bhe@redhat.com

The Linux kernel commit 3a63f70bf4c3 introduces the early parsing
of the RSDP. This means that boot loader must either set the
boot_params.acpi_rsdp_addr or pass a command line 'acpi_rsdp=xxx'
to tell the RDSP physical address.

Currently, kexec neither sets the boot_params.acpi_rsdp or passes
acpi_rsdp command line if it sees the first kernel support efi
runtime. This is causing the second kernel boot failure.
The EFI runtime is not available so early in the boot process so
unconditionally pass the 'acpi_rsdp=xxx' to the second kernel.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 kexec/arch/i386/crashdump-x86.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 140f45b..a29b15b 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -35,7 +35,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
-#include <dirent.h>
 #include "../../kexec.h"
 #include "../../kexec-elf.h"
 #include "../../kexec-syscall.h"
@@ -772,18 +771,6 @@ static enum coretype get_core_type(struct crash_elf_info *elf_info,
 	}
 }
 
-static int sysfs_efi_runtime_map_exist(void)
-{
-	DIR *dir;
-
-	dir = opendir("/sys/firmware/efi/runtime-map");
-	if (!dir)
-		return 0;
-
-	closedir(dir);
-	return 1;
-}
-
 /* Appends 'acpi_rsdp=' commandline for efi boot crash dump */
 static void cmdline_add_efi(char *cmdline)
 {
@@ -978,9 +965,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
 	if (delete_memmap(memmap_p, &nr_memmap, elfcorehdr, memsz) < 0)
 		return -1;
-	if (!bzImage_support_efi_boot || arch_options.noefi ||
-	    !sysfs_efi_runtime_map_exist())
-		cmdline_add_efi(mod_cmdline);
+	cmdline_add_efi(mod_cmdline);
 	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
 
 	/* Inform second kernel about the presence of ACPI tables. */
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
