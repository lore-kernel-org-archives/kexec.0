Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mux6C-00CnPp-DG
 for kexec@lists.infradead.org; Wed, 08 Dec 2021 13:35:10 +0000
From: Philipp Rudo <prudo@redhat.com>
Subject: [PATCH v2] kernel/crash_core: suppress unknown crashkernel parameter
 warning
Date: Wed,  8 Dec 2021 14:34:43 +0100
Message-Id: <20211208133443.6867-1-prudo@redhat.com>
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
Cc: bhe@redhat.com, akpm@linux-foundation.org, ahalaney@redhat.com

When booting with crashkernel= on the kernel command line a warning
similar to

[    0.038294] Kernel command line: ro console=ttyS0 crashkernel=256M
[    0.038353] Unknown kernel command line parameters "crashkernel=256M", will be passed to user space.

is printed. This comes from crashkernel= being parsed independent from
the kernel parameter handling mechanism. So the code in init/main.c
doesn't know that crashkernel= is a valid kernel parameter and prints
this incorrect warning. Suppress the warning by adding a dummy
early_param handler for crashkernel=.

Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
Signed-off-by: Philipp Rudo <prudo@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>

---
v2:
	- improve commit message
	- add Acked-by from Baoquan

---
 kernel/crash_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index eb53f5ec62c9..256cf6db573c 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -6,6 +6,7 @@
 
 #include <linux/buildid.h>
 #include <linux/crash_core.h>
+#include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 
@@ -295,6 +296,16 @@ int __init parse_crashkernel_low(char *cmdline,
 				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
 }
 
+/*
+ * Add a dummy early_param handler to mark crashkernel= as a known command line
+ * parameter and suppress incorrect warnings in init/main.c.
+ */
+static int __init parse_crashkernel_dummy(char *arg)
+{
+	return 0;
+}
+early_param("crashkernel", parse_crashkernel_dummy);
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
