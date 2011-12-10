Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RZGlz-0005yV-VH
 for kexec@lists.infradead.org; Sat, 10 Dec 2011 06:51:05 +0000
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Sat, 10 Dec 2011 06:45:26 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBA6owTW5116094
 for <kexec@lists.infradead.org>; Sat, 10 Dec 2011 17:50:58 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBA6ovOL032371
 for <kexec@lists.infradead.org>; Sat, 10 Dec 2011 17:50:58 +1100
Subject: [RFC PATCH v6 06/10] fadump: Add PT_NOTE program header for vmcoreinfo
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Sat, 10 Dec 2011 12:20:54 +0530
Message-ID: <20111210065054.10195.4026.stgit@mars.in.ibm.com>
In-Reply-To: <20111210064301.10195.3344.stgit@mars.in.ibm.com>
References: <20111210064301.10195.3344.stgit@mars.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>, Amerigo Wang <amwang@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Milton Miller <miltonm@bga.com>, Haren Myneni <hbabu@us.ibm.com>, Randy Dunlap <rdunlap@xenotime.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Ananth Narayan <ananth@in.ibm.com>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Introduce a PT_NOTE program header that points to physical address of
vmcoreinfo_note buffer declared in kernel/kexec.c. The vmcoreinfo
note buffer is populated during crash_fadump() at the time of system
crash.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index cab56e7..5689954 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -814,6 +814,19 @@ static void fadump_setup_crash_memory_ranges(void)
 	}
 }
 
+/*
+ * If the given physical address falls within the boot memory region then
+ * return the relocated address that points to the dump region reserved
+ * for saving initial boot memory contents.
+ */
+static inline unsigned long fadump_relocate(unsigned long paddr)
+{
+	if (paddr > RMA_START && paddr < fw_dump.boot_memory_size)
+		return fdm.rmr_region.destination_address + paddr;
+	else
+		return paddr;
+}
+
 static int fadump_create_elfcore_headers(char *bufp)
 {
 	struct elfhdr *elf;
@@ -845,6 +858,22 @@ static int fadump_create_elfcore_headers(char *bufp)
 
 	(elf->e_phnum)++;
 
+	/* setup ELF PT_NOTE for vmcoreinfo */
+	phdr = (struct elf_phdr *)bufp;
+	bufp += sizeof(struct elf_phdr);
+	phdr->p_type	= PT_NOTE;
+	phdr->p_flags	= 0;
+	phdr->p_vaddr	= 0;
+	phdr->p_align	= 0;
+
+	phdr->p_paddr	= fadump_relocate(paddr_vmcoreinfo_note());
+	phdr->p_offset	= phdr->p_paddr;
+	phdr->p_memsz	= vmcoreinfo_max_size;
+	phdr->p_filesz	= vmcoreinfo_max_size;
+
+	/* Increment number of program headers. */
+	(elf->e_phnum)++;
+
 	/* setup PT_LOAD sections. */
 
 	for (i = 0; i < crash_mem_ranges; i++) {


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
