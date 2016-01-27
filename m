Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aOYP3-0004zq-Fu
 for kexec@lists.infradead.org; Wed, 27 Jan 2016 22:17:30 +0000
Received: by mail-wm0-x230.google.com with SMTP id p63so47401235wmp.1
 for <kexec@lists.infradead.org>; Wed, 27 Jan 2016 14:17:07 -0800 (PST)
Date: Wed, 27 Jan 2016 23:17:00 +0100
From: Ivan Delalande <colona@arista.com>
Subject: [PATCH v2] makedumpfile: readpage_elf: handle 0-pages not stored in
 the ELF file
Message-ID: <20160127221700.GA31203@ycc.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E19AFB@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Daisuke Nishimura <dai-nishimura@rc.jp.nec.com>, Minoru Usui <min-usui@ti.jp.nec.com>, kexec-ml <kexec@lists.infradead.org>

Handle pages filled with zero that are not stored in the ELF file
directly, but have addresses between p_filesz and p_memsz of a segment.

This allows makedumpfile to dump-dmesg from a previously makedumpfile-ed
vmcore where all 0-page were excluded (dump_level & 1) for example.

Signed-off-by: Ivan Delalande <colona@arista.com>
---
 elf_info.c     | 22 ++++++++++++++++++++++
 elf_info.h     |  1 +
 makedumpfile.c | 17 +++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/elf_info.c b/elf_info.c
index 8bce942..d9d1f42 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -42,6 +42,7 @@ struct pt_load_segment {
 	unsigned long long	phys_end;
 	unsigned long long	virt_start;
 	unsigned long long	virt_end;
+	size_t			mem_size;
 };
 
 static int			nr_cpus;             /* number of cpu */
@@ -166,6 +167,7 @@ dump_Elf_load(Elf64_Phdr *prog, int num_load)
 	pls->virt_start  = prog->p_vaddr;
 	pls->virt_end    = pls->virt_start + prog->p_filesz;
 	pls->file_offset = prog->p_offset;
+	pls->mem_size    = prog->p_memsz;
 
 	DEBUG_MSG("LOAD (%d)\n", num_load);
 	DEBUG_MSG("  phys_start : %llx\n", pls->phys_start);
@@ -584,6 +586,26 @@ offset_to_pt_load_end(off_t offset)
 }
 
 /*
+ * Return true if a page is in the zone between p_filesz and p_memsz of a
+ * segment, which is a page filled with zero and not stored in the ELF file.
+ */
+int
+paddr_is_null(unsigned long long paddr)
+{
+	int i;
+	struct pt_load_segment *pls;
+
+	for (i = 0; i < num_pt_loads; i++) {
+		pls = &pt_loads[i];
+		if ((paddr >= pls->phys_end)
+		    && (paddr + info->page_size
+			<= pls->phys_start + pls->mem_size))
+			return TRUE;
+	}
+	return FALSE;
+}
+
+/*
  * Judge whether the page is fractional or not.
  */
 int
diff --git a/elf_info.h b/elf_info.h
index e712253..4823311 100644
--- a/elf_info.h
+++ b/elf_info.h
@@ -36,6 +36,7 @@ unsigned long long page_head_to_phys_start(unsigned long long head_paddr);
 unsigned long long page_head_to_phys_end(unsigned long long head_paddr);
 off_t offset_to_pt_load_start(off_t offset);
 off_t offset_to_pt_load_end(off_t offset);
+int paddr_is_null(unsigned long long paddr);
 unsigned long long vaddr_to_paddr_general(unsigned long long vaddr);
 off_t vaddr_to_offset_slow(int fd, char *filename, unsigned long long vaddr);
 unsigned long long get_max_paddr(void);
diff --git a/makedumpfile.c b/makedumpfile.c
index b802446..491f278 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -652,11 +652,20 @@ readpage_elf(unsigned long long paddr, void *bufptr)
 	size_t size1, size2;
 	unsigned long long phys_start, phys_end, frac_head = 0;
 
+	/*
+	 * Check the 0-filled pages that are not in the ELF file.
+	 */
+	if (paddr_is_null(paddr)) {
+		memset(bufptr, 0, info->page_size);
+		return TRUE;
+	}
+
 	offset1 = paddr_to_offset(paddr);
 	offset2 = paddr_to_offset(paddr + info->page_size);
 	phys_start = paddr;
 	phys_end = paddr + info->page_size;
 
+
 	/*
 	 * Check the case phys_start isn't aligned by page size like below:
 	 *
@@ -726,6 +735,14 @@ readpage_elf_parallel(int fd_memory, unsigned long long paddr, void *bufptr)
 	size_t size1, size2;
 	unsigned long long phys_start, phys_end, frac_head = 0;
 
+	/*
+	 * Check the 0-filled pages that are not in the ELF file.
+	 */
+	if (paddr_is_null(paddr)) {
+		memset(bufptr, 0, info->page_size);
+		return TRUE;
+	}
+
 	offset1 = paddr_to_offset(paddr);
 	offset2 = paddr_to_offset(paddr + info->page_size);
 	phys_start = paddr;
-- 
2.7.0


-- 
Ivan "Colona" Delalande
Arista Networks

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
