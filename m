Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WqDRb-0006Vr-CY
 for kexec@lists.infradead.org; Fri, 30 May 2014 03:25:24 +0000
Date: Fri, 30 May 2014 11:24:52 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH kexec-tools] kdump: pass acpi_rsdp to 2nd kernel if kernel
 does not export efi runtime maps
Message-ID: <20140530032452.GA30043@dhcp-16-198.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: horms@verge.net.au, kexec@lists.infradead.org, vgoyal@redhat.com


If kernel does not export efi runtime maps it means 1:1 mapping does not
work or user explictly boot with efi=old_map. In this case efi setup code
will failback to noefi boot, but for kdump case we still need pass extra
acpi_rsdp cmdline.

Thus adding a check in kdump path.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

Index: kexec-tools/kexec/arch/i386/crashdump-x86.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c
+++ kexec-tools/kexec/arch/i386/crashdump-x86.c
@@ -34,6 +34,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
+#include <dirent.h>
 #include "../../kexec.h"
 #include "../../kexec-elf.h"
 #include "../../kexec-syscall.h"
@@ -780,6 +781,18 @@ static enum coretype get_core_type(struc
 	}
 }
 
+static int sysfs_efi_runtime_map_exist(void)
+{
+	DIR *dir;
+
+	dir = opendir("/sys/firmware/efi/runtime-map");
+	if (!dir)
+		return 0;
+
+	closedir(dir);
+	return 1;
+}
+
 /* Appends 'acpi_rsdp=' commandline for efi boot crash dump */
 static void cmdline_add_efi(char *cmdline)
 {
@@ -974,7 +987,8 @@ int load_crashdump_segments(struct kexec
 	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
 	if (delete_memmap(memmap_p, &nr_memmap, elfcorehdr, memsz) < 0)
 		return -1;
-	if (!bzImage_support_efi_boot || arch_options.noefi)
+	if (!bzImage_support_efi_boot || arch_options.noefi ||
+	    !sysfs_efi_runtime_map_exist())
 		cmdline_add_efi(mod_cmdline);
 	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
