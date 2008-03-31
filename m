Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JgBav-0006gM-SI
	for kexec@lists.infradead.org; Mon, 31 Mar 2008 04:26:06 +0000
Date: Mon, 31 Mar 2008 13:26:04 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: [PATCH 3/4] extract vmcoreinfo from /proc/vmcore for Xen
Message-Id: <20080331131818.DDD1.ODA@valinux.co.jp>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xen-devel@lists.xensource.com
Cc: kexec@lists.infradead.org

This patch is for kexec-tools-testing-20080324.

--- kexec/crashdump.c.org	2008-03-25 11:51:51.000000000 +0900
+++ kexec/crashdump.c	2008-03-26 09:29:20.000000000 +0900
@@ -110,10 +110,8 @@
 	return 0;
 }
 
-/* Returns the physical address of start of crash notes buffer for a kernel. */
-int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
+static int get_vmcoreinfo(char *kdump_info, uint64_t *addr, uint64_t *len)
 {
-	char kdump_info[PATH_MAX];
 	char line[MAX_LINE];
 	int count;
 	FILE *fp;
@@ -122,9 +120,8 @@
 	*addr = 0;
 	*len = 0;
 
-	sprintf(kdump_info, "/sys/kernel/vmcoreinfo");
 	if (!(fp = fopen(kdump_info, "r")))
-		return 0;
+		return -1;
 
 	if (!fgets(line, sizeof(line), fp))
 		die("Cannot parse %s: %s\n", kdump_info, strerror(errno));
@@ -137,3 +134,14 @@
 
 	return 0;
 }
+
+/* Returns the physical address of start of crash notes buffer for a kernel. */
+int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
+{
+	return get_vmcoreinfo("/sys/kernel/vmcoreinfo", addr, len);
+}
+
+int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len)
+{
+	return get_vmcoreinfo("/sys/hypervisor/vmcoreinfo", addr, len);
+}
--- kexec/crashdump.h.org	2008-03-25 11:55:53.000000000 +0900
+++ kexec/crashdump.h	2008-03-25 11:56:57.000000000 +0900
@@ -3,6 +3,7 @@
 
 extern int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len);
 extern int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len);
+extern int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len);
 
 /* Need to find a better way to determine per cpu notes section size. */
 #define MAX_NOTE_BYTES		1024
--- kexec/crashdump-elf.c.org	2008-03-25 11:57:09.000000000 +0900
+++ kexec/crashdump-elf.c	2008-03-26 13:13:52.000000000 +0900
@@ -36,6 +36,8 @@
 	uint64_t notes_addr, notes_len;
 	uint64_t vmcoreinfo_addr, vmcoreinfo_len;
 	int has_vmcoreinfo = 0;
+	uint64_t vmcoreinfo_addr_xen, vmcoreinfo_len_xen;
+	int has_vmcoreinfo_xen = 0;
 	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
 
 	if (xen_present())
@@ -51,7 +53,12 @@
 		has_vmcoreinfo = 1;
 	}
 
-	sz = sizeof(EHDR) + (nr_cpus + has_vmcoreinfo) * sizeof(PHDR) +
+	if (xen_present() &&
+	    get_xen_vmcoreinfo(&vmcoreinfo_addr_xen, &vmcoreinfo_len_xen) == 0) {
+		has_vmcoreinfo_xen = 1;
+	}
+
+	sz = sizeof(EHDR) + (nr_cpus + has_vmcoreinfo + has_vmcoreinfo_xen) * sizeof(PHDR) +
 	     ranges * sizeof(PHDR);
 
 	/*
@@ -168,6 +175,21 @@
 		dbgprintf_phdr("vmcoreinfo header", phdr);
 	}
 
+	if (has_vmcoreinfo_xen) {
+		phdr = (PHDR *) bufp;
+		bufp += sizeof(PHDR);
+		phdr->p_type	= PT_NOTE;
+		phdr->p_flags	= 0;
+		phdr->p_offset  = phdr->p_paddr = vmcoreinfo_addr_xen;
+		phdr->p_vaddr   = 0;
+		phdr->p_filesz	= phdr->p_memsz	= vmcoreinfo_len_xen;
+		/* Do we need any alignment of segments? */
+		phdr->p_align	= 0;
+
+		(elf->e_phnum)++;
+		dbgprintf_phdr("vmcoreinfo_xen header", phdr);
+	}
+
 	/* Setup an PT_LOAD type program header for the region where
 	 * Kernel is mapped if info->kern_size is non-zero.
 	 */

-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
