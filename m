Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RZ0in-0002f3-Ex
 for kexec@lists.infradead.org; Fri, 09 Dec 2011 13:42:43 +0000
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 9 Dec 2011 13:42:23 -0000
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB9DgKXu2425022
 for <kexec@lists.infradead.org>; Fri, 9 Dec 2011 13:42:20 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost.localdomain
 [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB9DgKOb014016
 for <kexec@lists.infradead.org>; Fri, 9 Dec 2011 06:42:20 -0700
Message-ID: <1323438139.3253.2.camel@br98xy6r>
Subject: [PATCH] kexec-tools: s390: Do not create ELF header by default
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Fri, 09 Dec 2011 14:42:19 +0100
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Cc: kexec@lists.infradead.org

Hello Simon,

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

For s390 we have two modes for kdump:

For the first mode, as on all other architectures, the kexec tool creates
the ELF header and the 2nd kernel processes it for /proc/vmcore setup.

This mode has the disadvantage that for memory and CPU hotplug the kdump
kernel has to be reloaded by the kexec tool. For s390 this is a real problem
because we have a cpuplugd daemon that sets CPUs online and offline
according to the current workload. So CPU online/offline events occur very
often.

For the second mode on s390, the ELF header is created by the kdump kernel.
This is done automatically when the kernel is booted in kdump mode
and no "elfcorehdr" kernel parameter is specified. On s390 the kdump kernel
can get all necessary information to build the ELF header. We can get
the memory map, all CPU registers, and vmcoreinfo 

With this patch a compile switch WITH_ELF_HEADER is introduced. When the
macro is defined, kexec will create the ELF header and add the "elfcorehdr"
kernel parameter. If it is not specified (default), no header is created.

For s390 we want to have the 2nd mode as default because it has only
advantages for us.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
--
 kexec/arch/s390/crashdump-s390.c |   31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

--- a/kexec/arch/s390/crashdump-s390.c
+++ b/kexec/arch/s390/crashdump-s390.c
@@ -12,25 +12,26 @@
 #include <stdio.h>
 #include <elf.h>
 #include <limits.h>
+#include <string.h>
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
 #include "../../kexec/crashdump.h"
 #include "kexec-s390.h"
 
 /*
- * Load additional segments for kdump kernel
+ * Create ELF core header
  */
-int load_crashdump_segments(struct kexec_info *info, unsigned long crash_base,
-			    unsigned long crash_end)
+static int create_elf_header(struct kexec_info *info, unsigned long crash_base,
+			     unsigned long crash_end)
 {
+#ifdef WITH_ELF_HEADER
 	static struct memory_range crash_memory_range[MAX_MEMORY_RANGES];
-	unsigned long bufsz, elfcorehdr, elfcorehdr_size, crash_size;
+	unsigned long elfcorehdr, elfcorehdr_size, bufsz;
 	struct crash_elf_info elf_info;
 	char str[COMMAND_LINESIZE];
 	int ranges;
 	void *tmp;
 
-	crash_size = crash_end - crash_base + 1;
 	memset(&elf_info, 0, sizeof(elf_info));
 
 	elf_info.data = ELFDATA2MSB;
@@ -49,6 +50,23 @@ int load_crashdump_segments(struct kexec
 	elfcorehdr = add_buffer(info, tmp, bufsz, bufsz, 1024,
 				crash_base, crash_end, -1);
 	elfcorehdr_size = bufsz;
+	snprintf(str, sizeof(str), " elfcorehdr=%ld@%ldK\n",
+		 elfcorehdr_size, elfcorehdr / 1024);
+	command_line_add(str);
+#endif
+	return 0;
+}
+
+/*
+ * Load additional segments for kdump kernel
+ */
+int load_crashdump_segments(struct kexec_info *info, unsigned long crash_base,
+			    unsigned long crash_end)
+{
+	unsigned long crash_size = crash_size = crash_end - crash_base + 1;
+
+	if (create_elf_header(info, crash_base, crash_end))
+		return -1;
 	elf_rel_build_load(info, &info->rhdr, (const char *) purgatory,
 			   purgatory_size, crash_base + 0x2000,
 			   crash_base + 0x10000, -1, 0);
@@ -57,9 +75,6 @@ int load_crashdump_segments(struct kexec
 	elf_rel_set_symbol(&info->rhdr, "crash_size", &crash_size,
 			   sizeof(crash_size));
 	info->entry = (void *) elf_rel_get_addr(&info->rhdr, "purgatory_start");
-	snprintf(str, sizeof(str), " elfcorehdr=%ld@%ldK\n",
-		 elfcorehdr_size, elfcorehdr / 1024);
-	command_line_add(str);
 	return 0;
 }
 #else



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
