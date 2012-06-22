Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Si64I-00060Z-9B
 for kexec@lists.infradead.org; Fri, 22 Jun 2012 15:46:43 +0000
Received: from sanpedro.osd.mch.fsc.net (sanpedro.osd.mch.fsc.net
 [172.17.20.6])
 by sanpedro.mch.fsc.net (Postfix) with ESMTP id 5A03C968415
 for <kexec@lists.infradead.org>; Fri, 22 Jun 2012 17:46:40 +0200 (CEST)
From: Norbert Trapp <Norbert.Trapp@ts.fujitsu.com>
Subject: [PATCH 1/3] makedumpfile: Xen4: determine Xen version
Date: Fri, 22 Jun 2012 17:46:39 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <201206221746.40036.Norbert.Trapp@ts.fujitsu.com>
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
To: kexec@lists.infradead.org

The core file contains information about the xen version. The
Xen version is determined and different functions will be
called for different Xen versions. Additionally a Xen3 problem
with the page_info _domain offset for x86_64 gets repaired.

In Xen3 xen/common/kexec.c the page_info _domain offset was set with:
    VMCOREINFO_OFFSET_ALIAS(page_info, u, _domain);
which is wrong for x86_in because the _domain is in union v.
(xen/include/asm-x86/mm.h)
For Xen3 in makedumpfile.c the offset is simply modified to 24
for x86_64.

For Xen4 we asked Xen development to use:
    #ifdef __ia64__
	VMCOREINFO_OFFSET_SUB(page_info, u.inuse, _domain);
    #else
	VMCOREINFO_OFFSET_SUB(page_info, v.inuse, _domain);
    #endif

Signed-off-by: Norbert Trapp <norbert.trapp@ts.fujitsu.com>
---
 elf_info.c     |    2 +
 makedumpfile.c |   90 +++++++++++++++++++++++++++++++++++++++++++-------------
 makedumpfile.h |    3 ++
 3 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index cf476a3..e723720 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -159,6 +159,7 @@ check_elf_format(int fd, char *filename, int *phnum, unsigned int *num_load)
 	if ((ehdr64.e_ident[EI_CLASS] == ELFCLASS64)
 	    && (ehdr32.e_ident[EI_CLASS] != ELFCLASS32)) {
 		(*phnum) = ehdr64.e_phnum;
+		info->elf_machine = ehdr64.e_machine;
 		for (i = 0; i < ehdr64.e_phnum; i++) {
 			if (!get_elf64_phdr(fd, filename, i, &load64)) {
 				ERRMSG("Can't find Phdr %d.\n", i);
@@ -172,6 +173,7 @@ check_elf_format(int fd, char *filename, int *phnum, unsigned int *num_load)
 	} else if ((ehdr64.e_ident[EI_CLASS] != ELFCLASS64)
 	    && (ehdr32.e_ident[EI_CLASS] == ELFCLASS32)) {
 		(*phnum) = ehdr32.e_phnum;
+		info->elf_machine = ehdr32.e_machine;
 		for (i = 0; i < ehdr32.e_phnum; i++) {
 			if (!get_elf32_phdr(fd, filename, i, &load32)) {
 				ERRMSG("Can't find Phdr %d.\n", i);
diff --git a/makedumpfile.c b/makedumpfile.c
index d024e95..7398f17 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5300,10 +5300,7 @@ get_structure_info_xen(void)
 {
 	SIZE_INIT(page_info, "page_info");
 	OFFSET_INIT(page_info.count_info, "page_info", "count_info");
-	/*
-	 * _domain is the first member of union u
-	 */
-	OFFSET_INIT(page_info._domain, "page_info", "u");
+	OFFSET_IN_UNION_INIT(page_info._domain, "page_info", "_domain");
 
 	SIZE_INIT(domain, "domain");
 	OFFSET_INIT(domain.domain_id, "domain", "domain_id");
@@ -5313,6 +5310,41 @@ get_structure_info_xen(void)
 }
 
 int
+get_xen_version(void)
+{
+	unsigned long   xen_major_version;
+	unsigned long   xen_minor_version;
+	off_t           offset_xen_crash_info;
+	unsigned long   size_xen_crash_info;
+	const off_t     failed = (off_t)-1;
+
+	get_xen_crash_info(&offset_xen_crash_info, &size_xen_crash_info);
+	if (info->xen_major_version && info->xen_minor_version)
+		return TRUE;
+
+	if (lseek(info->fd_memory, offset_xen_crash_info, SEEK_SET) == failed) {
+		ERRMSG("Can't seek the dump memory(%s). %s\n",
+		    info->name_memory, strerror(errno));
+		return FALSE;
+	}
+	if (read(info->fd_memory, &xen_major_version, sizeof(xen_major_version))
+	    != sizeof(xen_major_version)) {
+		ERRMSG("Can't read the dump memory(%s). %s\n",
+		    info->name_memory, strerror(errno));
+		return FALSE;
+	}
+	if (read(info->fd_memory, &xen_minor_version, sizeof(xen_minor_version))
+	    != sizeof(xen_major_version)) {
+		ERRMSG("Can't read the dump memory(%s). %s\n",
+		    info->name_memory, strerror(errno));
+		return FALSE;
+	}
+	info->xen_major_version = xen_major_version;
+	info->xen_minor_version = xen_minor_version;
+	return TRUE;
+}
+
+int
 get_xen_phys_start(void)
 {
 	off_t offset, offset_xen_crash_info;
@@ -5350,23 +5382,25 @@ get_xen_info(void)
 	unsigned int domain_id;
 	int num_domain;
 
-	if (SYMBOL(alloc_bitmap) == NOT_FOUND_SYMBOL) {
-		ERRMSG("Can't get the symbol of alloc_bitmap.\n");
-		return FALSE;
-	}
-	if (!readmem(VADDR_XEN, SYMBOL(alloc_bitmap), &info->alloc_bitmap,
-	      sizeof(info->alloc_bitmap))) {
-		ERRMSG("Can't get the value of alloc_bitmap.\n");
-		return FALSE;
-	}
-	if (SYMBOL(max_page) == NOT_FOUND_SYMBOL) {
-		ERRMSG("Can't get the symbol of max_page.\n");
-		return FALSE;
-	}
-	if (!readmem(VADDR_XEN, SYMBOL(max_page), &info->max_page,
-	    sizeof(info->max_page))) {
-		ERRMSG("Can't get the value of max_page.\n");
-		return FALSE;
+	if (info->xen_major_version <= 3) {
+		if (SYMBOL(alloc_bitmap) == NOT_FOUND_SYMBOL) {
+			ERRMSG("Can't get the symbol of alloc_bitmap.\n");
+			return FALSE;
+		}
+		if (!readmem(VADDR_XEN, SYMBOL(alloc_bitmap), &info->alloc_bitmap,
+		      sizeof(info->alloc_bitmap))) {
+			ERRMSG("Can't get the value of alloc_bitmap.\n");
+			return FALSE;
+		}
+		if (SYMBOL(max_page) == NOT_FOUND_SYMBOL) {
+			ERRMSG("Can't get the symbol of max_page.\n");
+			return FALSE;
+		}
+		if (!readmem(VADDR_XEN, SYMBOL(max_page), &info->max_page,
+		    sizeof(info->max_page))) {
+			ERRMSG("Can't get the value of max_page.\n");
+			return FALSE;
+		}
 	}
 
 	/*
@@ -5503,6 +5537,8 @@ show_data_xen(void)
 	MSG("OFFSET(domain.next_in_list): %ld\n", OFFSET(domain.next_in_list));
 
 	MSG("\n");
+	MSG("xen_major_version: %lx\n", info->xen_major_version);
+	MSG("xen_minor_version: %lx\n", info->xen_minor_version);
 	MSG("xen_phys_start: %lx\n", info->xen_phys_start);
 	MSG("frame_table_vaddr: %lx\n", info->frame_table_vaddr);
 	MSG("xen_heap_start: %lx\n", info->xen_heap_start);
@@ -5640,6 +5676,12 @@ read_vmcoreinfo_xen(void)
 
 	READ_MEMBER_OFFSET("page_info.count_info", page_info.count_info);
 	READ_MEMBER_OFFSET("page_info._domain", page_info._domain);
+	if (info->elf_machine == EM_X86_64) {
+		if (info->xen_major_version < 4) {
+			MSG("modified offset_table.page_info._domain from %ld to 24\n", offset_table.page_info._domain);
+			offset_table.page_info._domain = 24;
+		}
+	}
 	READ_MEMBER_OFFSET("domain.domain_id", domain.domain_id);
 	READ_MEMBER_OFFSET("domain.next_in_list", domain.next_in_list);
 
@@ -5763,6 +5805,12 @@ initial_xen(void)
 	off_t offset;
 	unsigned long size;
 
+	if (!get_xen_version())
+		return FALSE;
+	if ((info->elf_machine != EM_X86_64) && (info->xen_major_version >= 4)) {
+		MSG("Xen major version %lu is not supported yet for this machine.\n", info->xen_major_version);
+		return FALSE;
+	}
 #if defined(__powerpc64__) || defined(__powerpc32__)
 	MSG("\n");
 	MSG("Xen is not supported on powerpc.\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index 6f5489d..d8d7779 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -843,6 +843,7 @@ struct DumpInfo {
 	/*
 	 * ELF header info:
 	 */
+	int			elf_machine;
 	unsigned int		num_load_dumpfile;
 	size_t			offset_load_dumpfile;
 
@@ -902,6 +903,8 @@ struct DumpInfo {
 	/*
 	 * for Xen extraction
 	 */
+	unsigned long		xen_major_version;
+	unsigned long		xen_minor_version;
 	unsigned long long	dom0_mapnr;  /* The number of page in domain-0.
 					      * Different from max_mapnr.
 					      * max_mapnr is the number of page
-- 
1.6.0.2

With kind regards

Norbert Trapp
PDG ES&S SWE OS 6

FUJITSU
Fujitsu Technology Solutions GmbH
Domagkstrasse 28, D-80807 Muenchen, Germany
E-mail: Norbert.Trapp@xxxxxxxxxxxxxx
Web: ts.fujitsu.com
Company details: ts.fujitsu.com/imprint
Please be advised that neither Fujitsu, its affiliates, its employees or agents accept liability for any errors,
omissions or damages caused by delays of receipt or by any virus infection in this message or its attachments,
or which may otherwise arise as a result of this e-mail transmission.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
