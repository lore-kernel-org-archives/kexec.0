Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RAd4M-0000n0-PX
	for kexec@lists.infradead.org; Mon, 03 Oct 2011 07:36:20 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id p937ZTEg005585
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 13:05:29 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p937ZSc72474026
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 13:05:28 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p937ZSq5014780
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 18:35:28 +1100
Date: Mon, 3 Oct 2011 13:05:27 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: [Patch 2/4][kexec-tools] Recognise NT_NOCOREDUMP elf-note type
Message-ID: <20111003073527.GB22694@in.ibm.com>
References: <20111003070735.GJ2223@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111003070735.GJ2223@in.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, crash-utility@redhat.com, kexec@lists.infradead.org
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

The kernel vmcore may contain a new elf-note of type NT_NOCOREDUMP. Include this
new note, whose address and length are made available at
/sys/kernel/nt_nocoredump, while loading elf-headers.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---

diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
index 8d82db9..b009227 100644
--- a/kexec/crashdump-elf.c
+++ b/kexec/crashdump-elf.c
@@ -39,7 +39,9 @@ int FUNC(struct kexec_info *info,
 	long int nr_cpus = 0;
 	uint64_t notes_addr, notes_len;
 	uint64_t vmcoreinfo_addr, vmcoreinfo_len;
+	uint64_t nt_nocoredump_addr, nt_nocoredump_len;
 	int has_vmcoreinfo = 0;
+	int has_nt_nocoredump = 0;
 	uint64_t vmcoreinfo_addr_xen, vmcoreinfo_len_xen;
 	int has_vmcoreinfo_xen = 0;
 	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
@@ -57,6 +59,9 @@ int FUNC(struct kexec_info *info,
 		has_vmcoreinfo = 1;
 	}
 
+	if (get_kernel_nt_nocoredump(&nt_nocoredump_addr, &nt_nocoredump_len) == 0)
+		has_nt_nocoredump = 1;
+
 	if (xen_present() &&
 	    get_xen_vmcoreinfo(&vmcoreinfo_addr_xen, &vmcoreinfo_len_xen) == 0) {
 		has_vmcoreinfo_xen = 1;
@@ -179,6 +184,21 @@ int FUNC(struct kexec_info *info,
 		dbgprintf_phdr("vmcoreinfo header", phdr);
 	}
 
+	if (has_nt_nocoredump && !(info->kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
+		phdr = (PHDR *) bufp;
+		bufp += sizeof(PHDR);
+		phdr->p_type	= PT_NOTE;
+		phdr->p_flags	= 0;
+		phdr->p_offset  = phdr->p_paddr = nt_nocoredump_addr;
+		phdr->p_vaddr   = 0;
+		phdr->p_filesz	= phdr->p_memsz	= nt_nocoredump_len;
+		/* Do we need any alignment of segments? */
+		phdr->p_align	= 0;
+
+		(elf->e_phnum)++;
+		dbgprintf_phdr("nocoredump note present", phdr);
+	}
+
 	if (has_vmcoreinfo_xen) {
 		phdr = (PHDR *) bufp;
 		bufp += sizeof(PHDR);
diff --git a/kexec/crashdump.c b/kexec/crashdump.c
index 945b052..0ee05f0 100644
--- a/kexec/crashdump.c
+++ b/kexec/crashdump.c
@@ -136,12 +136,43 @@ static int get_vmcoreinfo(const char *kdump_info, uint64_t *addr, uint64_t *len)
 	return 0;
 }
 
+static int get_nt_nocoredump(const char *kdump_info, uint64_t *addr, uint64_t *len)
+{
+	char line[MAX_LINE];
+	int count;
+	FILE *fp;
+	unsigned int temp2;
+	unsigned long long temp;
+
+	*addr = 0;
+	*len = 0;
+
+	if (!(fp = fopen(kdump_info, "r")))
+		return -1;
+	if (!fgets(line, sizeof(line), fp))
+		die("Cannot parse %s: %s\n", kdump_info, strerror(errno));
+	count = sscanf(line, "%Lx %x", &temp, &temp2);
+	if (count != 2)
+		die("Cannot parse %s: %s\n", kdump_info, strerror(errno));
+
+	*addr = (uint64_t) temp;
+	*len = (uint64_t) temp2;
+
+	fclose(fp);
+	return 0;
+}
 /* Returns the physical address of start of crash notes buffer for a kernel. */
 int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
 {
 	return get_vmcoreinfo("/sys/kernel/vmcoreinfo", addr, len);
 }
 
+/* Returns the physical address of start of nocoredump buffer for a kernel. */
+int get_kernel_nt_nocoredump(uint64_t *addr, uint64_t *len)
+{
+	return get_nt_nocoredump("/sys/kernel/nt_nocoredump", addr, len);
+}
+
 int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len)
 {
 	return get_vmcoreinfo("/sys/hypervisor/vmcoreinfo", addr, len);
-- 
1.7.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
