Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1ITZqR-0001jb-Ut
	for kexec@lists.infradead.org; Fri, 07 Sep 2007 05:09:46 -0400
Received: from mailgate3.nec.co.jp (mailgate54.nec.co.jp [10.7.69.197])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l8799gRB000614
	for <kexec@lists.infradead.org>; Fri, 7 Sep 2007 18:09:42 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
	(8.11.7/3.7W-MAILGATE-NEC)
	id l8799gq06384 for kexec@lists.infradead.org;
	Fri, 7 Sep 2007 18:09:42 +0900 (JST)
Received: from kuichi.jp.nec.com (kuichi.jp.nec.com [10.26.220.17]) by
	mailsv3.nec.co.jp (8.11.7/3.7W-MAILSV4-NEC) with ESMTP
	id l8799fB28688 for <kexec@lists.infradead.org>;
	Fri, 7 Sep 2007 18:09:41 +0900 (JST)
Subject: [PATCH 2/2] [kexec-tools] Pass vmcoreinfo's address and size #2
Message-Id: <20070907181002oomichi@mail.jp.nec.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Fri, 7 Sep 2007 18:10:02 +0900
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>


[2/2] [kexec-tools] Pass vmcoreinfo's address and size
  The patch is for kexec-tools-testing-20070330.
  (http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/)
  kexec command gets the address and size of the vmcoreinfo data from
  /sys/kernel/vmcoreinfo, and passes them to the second kernel through
  ELF header of /proc/vmcore. When the second kernel is booting, the
  kernel gets them from the ELF header and creates vmcoreinfo's PT_NOTE
  segment into /proc/vmcore.

  Changelog:
  - Fix the problem that the kexec command cannnot be executed on kernels
    without vmcoreinfo.


Thanks
Ken'ichi Ohmichi

---
Signed-off-by: Dan Aloni <da-x@monatomic.org>
Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

---
diff -rpuN a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
--- a/kexec/crashdump-elf.c	2007-03-30 13:34:36.000000000 +0900
+++ b/kexec/crashdump-elf.c	2007-09-07 22:58:18.000000000 +0900
@@ -36,6 +36,8 @@ int FUNC(struct kexec_info *info,
 	char *bufp;
 	long int nr_cpus = 0;
 	uint64_t notes_addr, notes_len;
+	uint64_t vmcoreinfo_addr, vmcoreinfo_len;
+	int has_vmcoreinfo = 0;
 	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
 
 	if (xen_present())
@@ -47,7 +49,11 @@ int FUNC(struct kexec_info *info,
 		return -1;
 	}
 
-	sz = sizeof(EHDR) + nr_cpus * sizeof(PHDR) + ranges * sizeof(PHDR);
+	if (get_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len) == 0) {
+		has_vmcoreinfo = 1;
+	}
+
+	sz = sizeof(EHDR) + (nr_cpus + has_vmcoreinfo) * sizeof(PHDR) + ranges * sizeof(PHDR);
 
 	/*
 	 * Certain architectures such as x86_64 and ia64 require a separate
@@ -148,6 +154,21 @@ int FUNC(struct kexec_info *info,
 		dfprintf_phdr(stdout, "Elf header", phdr);
 	}
 
+	if (has_vmcoreinfo) {
+		phdr = (PHDR *) bufp;
+		bufp += sizeof(PHDR);
+		phdr->p_type	= PT_NOTE;
+		phdr->p_flags	= 0;
+		phdr->p_offset  = phdr->p_paddr = vmcoreinfo_addr;
+		phdr->p_vaddr   = 0;
+		phdr->p_filesz	= phdr->p_memsz	= vmcoreinfo_len;
+		/* Do we need any alignment of segments? */
+		phdr->p_align	= 0;
+
+		(elf->e_phnum)++;
+		dfprintf_phdr(stdout, "vmcoreinfo header", phdr);
+	}
+
 	/* Setup an PT_LOAD type program header for the region where
 	 * Kernel is mapped if info->kern_size is non-zero.
 	 */
diff -rpuN a/kexec/crashdump.c b/kexec/crashdump.c
--- a/kexec/crashdump.c	2007-03-30 13:34:36.000000000 +0900
+++ b/kexec/crashdump.c	2007-09-07 23:03:55.000000000 +0900
@@ -108,3 +108,32 @@ int get_crash_notes_per_cpu(int cpu, uin
 
 	return 0;
 }
+
+/* Returns the physical address of start of crash notes buffer for a kernel. */
+int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
+{
+	char kdump_info[PATH_MAX];
+	char line[MAX_LINE];
+	int count;
+	FILE *fp;
+	unsigned long long temp, temp2;
+
+	*addr = 0;
+	*len = 0;
+
+	sprintf(kdump_info, "/sys/kernel/vmcoreinfo");
+	fp = fopen(kdump_info, "r");
+	if (!fp)
+		return 0;
+
+	if (!fgets(line, sizeof(line), fp))
+		die("Cannot parse %s: %s\n", kdump_info, strerror(errno));
+	count = sscanf(line, "%Lx %Lx", &temp, &temp2);
+	if (count != 2)
+		die("Cannot parse %s: %s\n", kdump_info, strerror(errno));
+
+	*addr = (uint64_t) temp;
+	*len = (uint64_t) temp2;
+
+	return 0;
+}
diff -rpuN a/kexec/crashdump.h b/kexec/crashdump.h
--- a/kexec/crashdump.h	2007-03-30 13:34:36.000000000 +0900
+++ b/kexec/crashdump.h	2007-09-07 22:58:18.000000000 +0900
@@ -2,6 +2,7 @@
 #define CRASHDUMP_H
 
 extern int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len);
+extern int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len);
 
 /* Need to find a better way to determine per cpu notes section size. */
 #define MAX_NOTE_BYTES		1024
_

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
