Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate5.uk.ibm.com ([194.196.100.165])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qdmen-0001df-I8
	for kexec@lists.infradead.org; Mon, 04 Jul 2011 17:10:09 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate5.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p64H9uvQ023422
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 17:09:56 GMT
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p64H9u0j2228410
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 18:09:56 +0100
Received: from d06av09.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p64H9tIb007689
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 11:09:56 -0600
Message-Id: <20110704170959.387574073@linux.vnet.ibm.com>
Date: Mon, 04 Jul 2011 19:09:27 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch 5/9] kdump: Allow vmcore ELF header to be created in new kernel
References: <20110704170922.976299676@linux.vnet.ibm.com>
Content-Disposition: inline; filename=05-s390-kdump-common-vmcore-newmem.patch
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: ebiederm@xmission.com, vgoyal@redhat.com, hbabu@us.ibm.com, mahesh@linux.vnet.ibm.com
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, horms@verge.net.au, schwidefsky@de.ibm.com

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

For s390 we create the ELF header for /proc/vmcore in the second (kdump)
kernel. Currently vmcore gets the ELF header from oldmem using the global
variable "elfcorehdr_addr". This patch introduces a new value
ELFCORE_ADDR_NEWMEM for "elfcorehdr_addr" that indicates that the ELF header
is allocated in the new kernel. In this case a new architecture function
"arch_vmcore_get_elf_hdr()" is called to obtain address and length of the
ELF header.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 fs/proc/vmcore.c           |   66 ++++++++++++++++++++++++++++++++++++---------
 include/linux/crash_dump.h |    1 
 2 files changed, 55 insertions(+), 12 deletions(-)

--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -494,14 +494,10 @@ static void __init set_vmcore_list_offse
 						struct list_head *vc_list)
 {
 	loff_t vmcore_off;
-	Elf64_Ehdr *ehdr_ptr;
 	struct vmcore *m;
 
-	ehdr_ptr = (Elf64_Ehdr *)elfptr;
-
 	/* Skip Elf header and program headers. */
-	vmcore_off = sizeof(Elf64_Ehdr) +
-			(ehdr_ptr->e_phnum) * sizeof(Elf64_Phdr);
+	vmcore_off = elfcorebuf_sz;
 
 	list_for_each_entry(m, vc_list, list) {
 		m->offset = vmcore_off;
@@ -514,14 +510,10 @@ static void __init set_vmcore_list_offse
 						struct list_head *vc_list)
 {
 	loff_t vmcore_off;
-	Elf32_Ehdr *ehdr_ptr;
 	struct vmcore *m;
 
-	ehdr_ptr = (Elf32_Ehdr *)elfptr;
-
 	/* Skip Elf header and program headers. */
-	vmcore_off = sizeof(Elf32_Ehdr) +
-			(ehdr_ptr->e_phnum) * sizeof(Elf32_Phdr);
+	vmcore_off = elfcorebuf_sz;
 
 	list_for_each_entry(m, vc_list, list) {
 		m->offset = vmcore_off;
@@ -641,7 +633,7 @@ static int __init parse_crash_elf32_head
 	return 0;
 }
 
-static int __init parse_crash_elf_headers(void)
+static int __init parse_crash_elf_headers_oldmem(void)
 {
 	unsigned char e_ident[EI_NIDENT];
 	u64 addr;
@@ -679,6 +671,53 @@ static int __init parse_crash_elf_header
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
+static int __init parse_crash_elf_headers_newmem(void)
+{
+	unsigned char e_ident[EI_NIDENT];
+	int rc;
+
+	rc = arch_vmcore_get_elf_hdr(&elfcorebuf, &elfcorebuf_sz);
+	if (rc)
+		return rc;
+	memcpy(e_ident, elfcorebuf, EI_NIDENT);
+	if (memcmp(e_ident, ELFMAG, SELFMAG) != 0) {
+		printk(KERN_WARNING "Warning: Core image elf header "
+		       "not found\n");
+		rc = -EINVAL;
+		goto fail;
+	}
+	if (e_ident[EI_CLASS] == ELFCLASS64) {
+		rc = process_ptload_program_headers_elf64(elfcorebuf,
+							  elfcorebuf_sz,
+							  &vmcore_list);
+		if (rc)
+			goto fail;
+		set_vmcore_list_offsets_elf64(elfcorebuf, &vmcore_list);
+		vmcore_size = get_vmcore_size_elf64(elfcorebuf);
+	} else if (e_ident[EI_CLASS] == ELFCLASS32) {
+		rc = process_ptload_program_headers_elf32(elfcorebuf,
+							  elfcorebuf_sz,
+							  &vmcore_list);
+		if (rc)
+			goto fail;
+		set_vmcore_list_offsets_elf32(elfcorebuf, &vmcore_list);
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
@@ -687,7 +726,10 @@ static int __init vmcore_init(void)
 	/* If elfcorehdr= has been passed in cmdline, then capture the dump.*/
 	if (!(is_vmcore_usable()))
 		return rc;
-	rc = parse_crash_elf_headers();
+	if (elfcorehdr_addr == ELFCORE_ADDR_NEWMEM)
+		rc = parse_crash_elf_headers_newmem();
+	else
+		rc = parse_crash_elf_headers_oldmem();
 	if (rc) {
 		printk(KERN_WARNING "Kdump: vmcore not initialized\n");
 		return rc;
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -8,6 +8,7 @@
 
 #define ELFCORE_ADDR_MAX	(-1ULL)
 #define ELFCORE_ADDR_ERR	(-2ULL)
+#define ELFCORE_ADDR_NEWMEM	(-3ULL)
 
 extern unsigned long long elfcorehdr_addr;
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
