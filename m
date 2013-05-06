Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UZLBS-000431-FK
 for kexec@lists.infradead.org; Mon, 06 May 2013 13:10:27 +0000
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 6 May 2013 14:05:59 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 42F3A17D801D
 for <kexec@lists.infradead.org>; Mon,  6 May 2013 14:11:04 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r46D9o5j49348844
 for <kexec@lists.infradead.org>; Mon, 6 May 2013 13:09:50 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r46D9xNS007574
 for <kexec@lists.infradead.org>; Mon, 6 May 2013 07:10:00 -0600
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH 1/4] kdump: Introduce ELFCORE_ADDR_NEWMEM
Date: Mon,  6 May 2013 15:09:56 +0200
Message-Id: <1367845799-29125-2-git-send-email-holzheu@linux.vnet.ibm.com>
In-Reply-To: <1367845799-29125-1-git-send-email-holzheu@linux.vnet.ibm.com>
References: <1367845799-29125-1-git-send-email-holzheu@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Jan Willeke <willeke@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>

Currently vmcore gets the ELF header from oldmem using the global variable
"elfcorehdr_addr". This patch introduces a new possible value
ELFCORE_ADDR_NEWMEM. This indicates that the ELF header is allocated
in the new (2nd) kernel. In this case a new architecture function
arch_vmcore_get_elf_hdr() is called to obtain address and length of the
ELF header. The ELF header that is created in the 2nd kernel already
contains the correct relative offsets in the ELF notes and loads sections.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 fs/proc/vmcore.c           | 65 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/crash_dump.h |  4 ++-
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 17f7e08..71db4e6 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -487,6 +487,18 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 }
 
 /* Sets offset fields of vmcore elements. */
+static void __init set_vmcore_list_offsets_newmem(struct list_head *vc_list)
+{
+	loff_t vmcore_off = elfcorebuf_sz;
+	struct vmcore *m;
+
+	list_for_each_entry(m, vc_list, list) {
+		m->offset = vmcore_off;
+		vmcore_off += m->size;
+	}
+}
+
+/* Sets offset fields of vmcore elements. */
 static void __init set_vmcore_list_offsets_elf64(char *elfptr,
 						struct list_head *vc_list)
 {
@@ -636,7 +648,7 @@ static int __init parse_crash_elf32_headers(void)
 	return 0;
 }
 
-static int __init parse_crash_elf_headers(void)
+static int __init parse_crash_elf_headers_oldmem(void)
 {
 	unsigned char e_ident[EI_NIDENT];
 	u64 addr;
@@ -672,6 +684,52 @@ static int __init parse_crash_elf_headers(void)
 	return 0;
 }
 
+/*
+ * provide an empty default implementation here -- architecture
+ * code may override this
+ */
+int __weak arch_vmcore_get_elf_hdr(char **elfcorebuf, size_t *elfcorebuf_sz)
+{
+	return -EOPNOTSUPP;
+}
+
+static int parse_crash_elf_headers_newmem(void)
+{
+	unsigned char e_ident[EI_NIDENT];
+	int rc;
+
+	rc = arch_vmcore_get_elf_hdr(&elfcorebuf, &elfcorebuf_sz);
+	if (rc)
+		return rc;
+	memcpy(e_ident, elfcorebuf, EI_NIDENT);
+	if (memcmp(e_ident, ELFMAG, SELFMAG) != 0) {
+		pr_warn("Warning: Core image elf header not found\n");
+		rc = -EINVAL;
+		goto fail;
+	}
+	if (e_ident[EI_CLASS] == ELFCLASS64) {
+		rc = process_ptload_program_headers_elf64(elfcorebuf,
+							  elfcorebuf_sz,
+							  &vmcore_list);
+		if (rc)
+			goto fail;
+		set_vmcore_list_offsets_newmem(&vmcore_list);
+		vmcore_size = get_vmcore_size_elf64(elfcorebuf);
+	} else if (e_ident[EI_CLASS] == ELFCLASS32) {
+		rc = process_ptload_program_headers_elf32(elfcorebuf,
+							  elfcorebuf_sz,
+							  &vmcore_list);
+		if (rc)
+			goto fail;
+		set_vmcore_list_offsets_newmem(&vmcore_list);
+		vmcore_size = get_vmcore_size_elf32(elfcorebuf);
+	}
+	return 0;
+fail:
+	kfree(elfcorebuf);
+	return rc;
+}
+
 /* Init function for vmcore module. */
 static int __init vmcore_init(void)
 {
@@ -680,7 +738,10 @@ static int __init vmcore_init(void)
 	/* If elfcorehdr= has been passed in cmdline, then capture the dump.*/
 	if (!(is_vmcore_usable()))
 		return rc;
-	rc = parse_crash_elf_headers();
+	if (elfcorehdr_addr == ELFCORE_ADDR_NEWMEM)
+		rc = parse_crash_elf_headers_newmem();
+	else
+		rc = parse_crash_elf_headers_oldmem();
 	if (rc) {
 		pr_warn("Kdump: vmcore not initialized\n");
 		return rc;
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 37e4f8d..9424d4fc 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -8,10 +8,12 @@
 
 #define ELFCORE_ADDR_MAX	(-1ULL)
 #define ELFCORE_ADDR_ERR	(-2ULL)
+#define ELFCORE_ADDR_NEWMEM	(-3ULL)
 
 extern unsigned long long elfcorehdr_addr;
 extern unsigned long long elfcorehdr_size;
-
+extern int arch_vmcore_get_elf_hdr(char **elfcorebuf,
+				   size_t *elfcorebuf_sz);
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);
 
-- 
1.8.1.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
