Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IbClt-0000rA-TS
	for kexec@lists.infradead.org; Fri, 28 Sep 2007 11:08:36 +0100
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l8SA6Q5u020474
	for <kexec@lists.infradead.org>; Fri, 28 Sep 2007 19:06:26 +0900 (JST)
Message-Id: <46FCD1BD.2080502@mxs.nes.nec.co.jp>
Date: Fri, 28 Sep 2007 19:04:45 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [makedumpfile] extract vmcoreinfo from /proc/vmcore
	for	Xen
References: <20070928090647.6EA9.ODA@valinux.co.jp>
In-Reply-To: <20070928090647.6EA9.ODA@valinux.co.jp>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Itsuro ODA <oda@valinux.co.jp>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org


Hi,

Itsuro ODA wrote:
> > I'd like to support the "extract vmcoreinfo from /proc/vmcore"
> > function for the Xen extraction too.
> >
> > I think a way of supporting this as follows:
> > 
> > * The hypervisor makes its vmcoreinfo at the initialize.
> > * add a new hypervisor call to get the hypervisor's vmcoreinfo.
> >   The hypercall would be a subcommand of the kexec hypercall.
> > * dom-0 exposes the hypervisor's vmcoreinfo via 
> >   /sys/hypervisor/vmcoreinfo
> > * kexec-tool looks /sys/hypervisor/vmcoreinfo and makes an elf-note
> >   according it

That sounds good.

BTW, the testing tree of kexec-tools has not contain the patch for
vmcoreinfo yet. I think the tree is mainline now, and I hope the
patch is merged into the tree  ;-) 


Thanks
Ken'ichi Ohmichi 

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
