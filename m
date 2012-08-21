Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T3qNo-0002oM-2z
 for kexec@lists.infradead.org; Tue, 21 Aug 2012 15:28:45 +0000
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 3CBA2A3DD6
 for <kexec@lists.infradead.org>; Tue, 21 Aug 2012 17:28:43 +0200 (CEST)
Resent-To: kexec@lists.infradead.org
Resent-Message-ID: <201208211728.42986.ptesarik@suse.cz>
Message-Id: <20120821084452.172220263@azariah.suse.cz>
Date: Tue, 21 Aug 2012 10:44:54 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [patch 3/9] Read the Xen crash ELF note into memory at startup
References: <20120821084451.587187471@azariah.suse.cz>
Content-Disposition: inline; filename=03-crash_xen_info_t.patch
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Petr Tesarik <ptesarik@suse.cz>, Norbert Trapp <Norbert.Trapp@ts.fujitsu.com>

Instead of seeking individual fields inside the ELF note, copy the
corresponding struct type from the Xen sources, so people can understand
why the code does what it does.

This is mainly a cleanup patch to improve maintainability, but it also
simplifies reusing the crash note data from other places.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 arch/x86_64.c  |   24 ++++++++++++++--
 elf_info.c     |   25 -----------------
 elf_info.h     |    2 -
 makedumpfile.c |   82 ++++++++++++++++++++++++++++++++++++++++++---------------
 makedumpfile.h |   49 ++++++++++++++++++++++++++++++++--
 5 files changed, 130 insertions(+), 52 deletions(-)

--- a/elf_info.c
+++ b/elf_info.c
@@ -88,7 +88,6 @@ static unsigned long		size_eraseinfo;
  */
 static off_t			offset_xen_crash_info;
 static unsigned long		size_xen_crash_info;
-static unsigned long		xen_p2m_mfn;
 
 
 /*
@@ -292,8 +291,7 @@ static int
 get_pt_note_info(void)
 {
 	int n_type, size_desc;
-	unsigned long p2m_mfn;
-	off_t offset, offset_desc, off_p2m = 0;
+	off_t offset, offset_desc;
 	char buf[VMCOREINFO_XEN_NOTE_NAME_BYTES];
 	char note[MAX_SIZE_NHDR];
 
@@ -349,21 +347,6 @@ get_pt_note_info(void)
 			offset_xen_crash_info = offset_desc;
 			size_xen_crash_info   = size_desc;
 
-			off_p2m = offset + offset_next_note(note)
-					 - sizeof(p2m_mfn);
-			if (lseek(fd_memory, off_p2m, SEEK_SET) < 0){
-				ERRMSG("Can't seek the dump memory(%s). %s\n",
-				    name_memory, strerror(errno));
-				return FALSE;
-			}
-			if (read(fd_memory, &p2m_mfn, sizeof(p2m_mfn))
-			     != sizeof(p2m_mfn)) {
-				ERRMSG("Can't read the dump memory(%s). %s\n",
-				    name_memory, strerror(errno));
-				return FALSE;
-			}
-			xen_p2m_mfn = p2m_mfn;
-
 		/*
 		 * Check whether a source dumpfile contains eraseinfo.
 		 *   /proc/vmcore does not contain eraseinfo, because eraseinfo
@@ -859,9 +842,3 @@ set_eraseinfo(off_t offset, unsigned lon
 	size_eraseinfo   = size;
 }
 
-unsigned long
-get_xen_p2m_mfn(void)
-{
-	return xen_p2m_mfn;
-}
-
--- a/elf_info.h
+++ b/elf_info.h
@@ -68,8 +68,6 @@ int has_eraseinfo(void);
 void get_eraseinfo(off_t *offset, unsigned long *size);
 void set_eraseinfo(off_t offset, unsigned long size);
 
-unsigned long get_xen_p2m_mfn(void);
-
 #endif  /* ELF_INFO_H */
 
 
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5316,32 +5316,64 @@ get_structure_info_xen(void)
 }
 
 int
-get_xen_phys_start(void)
+init_xen_crash_info(void)
 {
-	off_t offset, offset_xen_crash_info;
-	unsigned long xen_phys_start, size_xen_crash_info;
-	const off_t failed = (off_t)-1;
+	off_t		offset_xen_crash_info;
+	unsigned long	size_xen_crash_info;
+	void		*buf;
+
+	get_xen_crash_info(&offset_xen_crash_info, &size_xen_crash_info);
+	if (!size_xen_crash_info) {
+		info->xen_crash_info_v = -1;
+		return TRUE;		/* missing info is non-fatal */
+	}
+
+	if (size_xen_crash_info < sizeof(xen_crash_info_com_t)) {
+		ERRMSG("Xen crash info too small (%lu bytes).\n",
+		       size_xen_crash_info);
+		return FALSE;
+	}
+
+	buf = malloc(size_xen_crash_info);
+	if (!buf) {
+		ERRMSG("Can't allocate note (%lu bytes). %s\n",
+		       size_xen_crash_info, strerror(errno));
+		return FALSE;
+	}
+
+	if (lseek(info->fd_memory, offset_xen_crash_info, SEEK_SET) < 0) {
+		ERRMSG("Can't seek the dump memory(%s). %s\n",
+		       info->name_memory, strerror(errno));
+		return FALSE;
+	}
+	if (read(info->fd_memory, buf, size_xen_crash_info)
+	    != size_xen_crash_info) {
+		ERRMSG("Can't read the dump memory(%s). %s\n",
+		       info->name_memory, strerror(errno));
+		return FALSE;
+	}
+
+	info->xen_crash_info.com = buf;
+	if (size_xen_crash_info >= sizeof(xen_crash_info_v2_t))
+		info->xen_crash_info_v = 2;
+	else if (size_xen_crash_info >= sizeof(xen_crash_info_t))
+		info->xen_crash_info_v = 1;
+	else
+		info->xen_crash_info_v = 0;
 
+	return TRUE;
+}
+
+int
+get_xen_phys_start(void)
+{
 	if (info->xen_phys_start)
 		return TRUE;
 
-	get_xen_crash_info(&offset_xen_crash_info, &size_xen_crash_info);
-	if (size_xen_crash_info >= SIZE_XEN_CRASH_INFO_V2) {
-		offset = offset_xen_crash_info + size_xen_crash_info
-			 - sizeof(unsigned long) * 2;
-		if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
-			ERRMSG("Can't seek the dump memory(%s). %s\n",
-			    info->name_memory, strerror(errno));
-			return FALSE;
-		}
-		if (read(info->fd_memory, &xen_phys_start, sizeof(unsigned long))
-		    != sizeof(unsigned long)) {
-			ERRMSG("Can't read the dump memory(%s). %s\n",
-			    info->name_memory, strerror(errno));
-			return FALSE;
-		}
-		info->xen_phys_start = xen_phys_start;
-	}
+#if defined(__x86__) || defined(__x86_64__)
+	if (info->xen_crash_info_v >= 2)
+		info->xen_phys_start = info->xen_crash_info.v2->xen_phys_start;
+#endif
 
 	return TRUE;
 }
@@ -5506,6 +5538,12 @@ show_data_xen(void)
 	MSG("OFFSET(domain.next_in_list): %ld\n", OFFSET(domain.next_in_list));
 
 	MSG("\n");
+	if (info->xen_crash_info.com) {
+		MSG("xen_major_version: %lx\n",
+		    info->xen_crash_info.com->xen_major_version);
+		MSG("xen_minor_version: %lx\n",
+		    info->xen_crash_info.com->xen_minor_version);
+	}
 	MSG("xen_phys_start: %lx\n", info->xen_phys_start);
 	MSG("frame_table_vaddr: %lx\n", info->frame_table_vaddr);
 	MSG("xen_heap_start: %lx\n", info->xen_heap_start);
@@ -5785,6 +5823,8 @@ initial_xen(void)
 		return FALSE;
 	}
 #endif
+	if (!init_xen_crash_info())
+		return FALSE;
 	if (!fallback_to_current_page_size())
 		return FALSE;
 	/*
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -416,8 +416,6 @@ do { \
 #define SIZE_BUF_STDIN	(4096)
 #define STRLEN_OSRELEASE (65)	/* same length as diskdump.h */
 
-#define SIZE_XEN_CRASH_INFO_V2	(sizeof(unsigned long) * 10)
-
 /*
  * The value of dependence on machine
  */
@@ -719,6 +717,43 @@ unsigned long long vaddr_to_paddr_ia64(u
 #define pfn_to_paddr(X) \
 	(((unsigned long long)(X) + ARCH_PFN_OFFSET) << PAGESHIFT())
 
+/* Format of Xen crash info ELF note */
+typedef struct {
+	unsigned long xen_major_version;
+	unsigned long xen_minor_version;
+	unsigned long xen_extra_version;
+	unsigned long xen_changeset;
+	unsigned long xen_compiler;
+	unsigned long xen_compile_date;
+	unsigned long xen_compile_time;
+	unsigned long tainted;
+} xen_crash_info_com_t;
+
+typedef struct {
+	xen_crash_info_com_t com;
+#if defined(__x86__) || defined(__x86_64__)
+	/* added by changeset 2b43fb3afb3e: */
+	unsigned long dom0_pfn_to_mfn_frame_list_list;
+#endif
+#if defined(__ia64__)
+	/* added by changeset d7c3b12014b3: */
+	unsigned long dom0_mm_pgd_mfn;
+#endif
+} xen_crash_info_t;
+
+/* changeset 439a3e9459f2 added xen_phys_start
+ * to the middle of the struct... */
+typedef struct {
+	xen_crash_info_com_t com;
+#if defined(__x86__) || defined(__x86_64__)
+	unsigned long xen_phys_start;
+	unsigned long dom0_pfn_to_mfn_frame_list_list;
+#endif
+#if defined(__ia64__)
+	unsigned long dom0_mm_pgd_mfn;
+#endif
+} xen_crash_info_v2_t;
+
 struct mem_map_data {
 	unsigned long long	pfn_start;
 	unsigned long long	pfn_end;
@@ -902,6 +937,16 @@ struct DumpInfo {
 	/*
 	 * for Xen extraction
 	 */
+	union {				/* Both versions of Xen crash info: */
+		xen_crash_info_com_t *com;   /* common fields */
+		xen_crash_info_t *v1;	     /* without xen_phys_start */
+		xen_crash_info_v2_t *v2;     /* changeset 439a3e9459f2 */
+	} xen_crash_info;
+	int xen_crash_info_v;		/* Xen crash info version:
+					 *   0 .. xen_crash_info_com_t
+					 *   1 .. xen_crash_info_t
+					 *   2 .. xen_crash_info_v2_t */
+
 	unsigned long long	dom0_mapnr;  /* The number of page in domain-0.
 					      * Different from max_mapnr.
 					      * max_mapnr is the number of page
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -30,6 +30,18 @@ is_vmalloc_addr(ulong vaddr)
 	    || (vaddr >= MODULES_VADDR && vaddr <= MODULES_END));
 }
 
+static unsigned long
+get_xen_p2m_mfn(void)
+{
+	if (info->xen_crash_info_v >= 2)
+		return info->xen_crash_info.v2->
+			dom0_pfn_to_mfn_frame_list_list;
+	if (info->xen_crash_info_v >= 1)
+		return info->xen_crash_info.v1->
+			dom0_pfn_to_mfn_frame_list_list;
+	return NOT_FOUND_LONG_VALUE;
+}
+
 int
 get_phys_base_x86_64(void)
 {
@@ -59,6 +71,7 @@ get_phys_base_x86_64(void)
 int
 get_machdep_info_x86_64(void)
 {
+	unsigned long p2m_mfn;
 	int i, j, mfns[MAX_X86_64_FRAMES];
 	unsigned long frame_mfn[MAX_X86_64_FRAMES];
 	unsigned long buf[MFNS_PER_FRAME];
@@ -72,9 +85,14 @@ get_machdep_info_x86_64(void)
 	 * Get the information for translating domain-0's physical
 	 * address into machine address.
 	 */
-	if (!readmem(MADDR_XEN, pfn_to_paddr(get_xen_p2m_mfn()),
-					 &frame_mfn, PAGESIZE())) {
-		ERRMSG("Can't get p2m_mfn.\n");
+	p2m_mfn = get_xen_p2m_mfn();
+	if (p2m_mfn == (unsigned long)NOT_FOUND_LONG_VALUE) {
+		ERRMSG("Can't get p2m_mfn address.\n");
+		return FALSE;
+	}
+	if (!readmem(MADDR_XEN, pfn_to_paddr(p2m_mfn),
+		     &frame_mfn, PAGESIZE())) {
+		ERRMSG("Can't read p2m_mfn.\n");
 		return FALSE;
 	}
 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
