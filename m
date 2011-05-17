Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QMQZL-0002X2-BQ
	for kexec@lists.infradead.org; Tue, 17 May 2011 20:08:41 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p4HK2e0H027871
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 06:02:40 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4HK8Mrp1167480
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 06:08:22 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4HK8ZaI001391
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 06:08:35 +1000
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH v2 8/8] makedumpfile: Add erase information in ELF formatted
	dumpfile
Date: Wed, 18 May 2011 01:37:46 +0530
Message-ID: <20110517200715.12740.67863.stgit@mars.in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, V Srivatsa <vsrivatsa@in.ibm.com>, Dave Anderson <anderson@redhat.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

This patch implements support for inclusion of erase information in ELF
formatted dumpfile. This patch introduces an additional ELF Note section
that contains erase information.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---

 makedumpfile.c |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |   17 ++++++++
 2 files changed, 137 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b5ad5f7..f7842d2 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3352,6 +3352,9 @@ get_pt_note_info(off_t off_note, unsigned long sz_note)
 				return FALSE;
 			}
 			info->p2m_mfn = p2m_mfn;
+		} else if (n_type == NT_ERASE_INFO) {
+			info->offset_eraseinfo = offset_desc;
+			info->size_eraseinfo = size_desc;
 		}
 		offset += offset_next_note(note);
 	}
@@ -4647,6 +4650,15 @@ write_cache_bufsz(struct cache_data *cd)
 }
 
 int
+write_cache_zero(struct cache_data *cd, size_t size)
+{
+	memset(cd->buf + cd->buf_size, 0, size);
+	cd->buf_size += size;
+
+	return write_cache_bufsz(cd);
+}
+
+int
 read_buf_from_stdin(void *buf, int buf_size)
 {
 	int read_size = 0, tmp_read_size = 0;
@@ -5799,10 +5811,12 @@ write_elf_header(struct cache_data *cd_header)
 {
 	int i, num_loads_dumpfile, phnum;
 	off_t offset_note_memory, offset_note_dumpfile;
-	size_t size_note;
+	size_t size_note, size_eraseinfo = 0;
 	Elf64_Ehdr ehdr64;
 	Elf32_Ehdr ehdr32;
 	Elf64_Phdr note;
+	char size_str[MAX_SIZE_STR_LEN];
+	struct filter_info *fl_info = filter_info;
 
 	char *buf = NULL;
 	const off_t failed = (off_t)-1;
@@ -5855,6 +5869,36 @@ write_elf_header(struct cache_data *cd_header)
 	}
 
 	/*
+	 * Pre-calculate the required size to store eraseinfo in ELF note
+	 * section so that we can add enough space in ELF notes section and
+	 * adjust the PT_LOAD offset accordingly.
+	 */
+	while (fl_info) {
+		struct erase_info *ei;
+
+		if (!fl_info->erase_info_idx)
+			continue;
+		ei = &erase_info[fl_info->erase_info_idx];
+		if (fl_info->nullify)
+			sprintf(size_str, "nullify\n");
+		else
+			sprintf(size_str, "%ld\n", fl_info->size);
+
+		size_eraseinfo += strlen("erase ") +
+				strlen(ei->symbol_expr) + 1 +
+				strlen(size_str);
+		fl_info = fl_info->next;
+	}
+
+	/*
+	 * Store the size_eraseinfo for later use in write_elf_eraseinfo()
+	 * function. This will overwrite the size fetched during
+	 * get elf_info() function but we are ok with that.
+	 */
+	info->size_eraseinfo = size_eraseinfo;
+	DEBUG_MSG("erase info size: %lu\n", info->size_eraseinfo);
+
+	/*
 	 * Write a PT_NOTE header.
 	 */
 	if (!(phnum = get_phnum_memory()))
@@ -5884,6 +5928,17 @@ write_elf_header(struct cache_data *cd_header)
 	note.p_offset      = offset_note_dumpfile;
 	size_note          = note.p_filesz;
 
+	/*
+	 * Modify the note size in PT_NOTE header to accomodate eraseinfo data.
+	 * Eraseinfo will be written later.
+	 */
+	if (info->flag_elf64_memory)
+		note.p_filesz += sizeof(Elf64_Nhdr);
+	else
+		note.p_filesz += sizeof(Elf32_Nhdr);
+	note.p_filesz += roundup(ERASEINFO_NOTE_NAME_BYTES, 4) +
+				roundup(size_eraseinfo, 4);
+
 	if (!write_elf_phdr(cd_header, &note))
 		goto out;
 
@@ -5910,10 +5965,14 @@ write_elf_header(struct cache_data *cd_header)
 	    size_note, info->name_dumpfile))
 		goto out;
 
+	/* Set the size_note with new size. */
+	size_note          = note.p_filesz;
+
 	/*
 	 * Set an offset of PT_LOAD segment.
 	 */
 	info->offset_load_dumpfile = offset_note_dumpfile + size_note;
+	info->offset_note_dumpfile = offset_note_dumpfile;
 
 	ret = TRUE;
 out:
@@ -6728,6 +6787,64 @@ out:
 }
 
 int
+write_elf_eraseinfo(struct cache_data *cd_header)
+{
+	char note[MAX_SIZE_NHDR];
+	char buf[ERASEINFO_NOTE_NAME_BYTES + 4];
+	unsigned long note_header_size, size_eraseinfo;
+
+	DEBUG_MSG("Writing erase info...\n");
+
+	/* calculate the eraseinfo ELF note offset */
+	cd_header->offset = info->offset_note_dumpfile +
+				roundup(info->size_note, 4);
+
+	/* Write eraseinfo ELF note header. */
+	memset(note, 0, sizeof(note));
+	if (info->flag_elf64_memory) {
+		Elf64_Nhdr *nh = (Elf64_Nhdr *)note;
+
+		note_header_size = sizeof(Elf64_Nhdr);
+		nh->n_namesz = ERASEINFO_NOTE_NAME_BYTES;
+		nh->n_descsz = info->size_eraseinfo;
+		nh->n_type = NT_ERASE_INFO;
+	} else {
+		Elf32_Nhdr *nh = (Elf32_Nhdr *)note;
+
+		note_header_size = sizeof(Elf32_Nhdr);
+		nh->n_namesz = ERASEINFO_NOTE_NAME_BYTES;
+		nh->n_descsz = info->size_eraseinfo;
+		nh->n_type = NT_ERASE_INFO;
+	}
+	if (!write_cache(cd_header, note, note_header_size))
+		return FALSE;
+
+	/* Write eraseinfo Note name */
+	memset(buf, 0, sizeof(buf));
+	memcpy(buf, ERASEINFO_NOTE_NAME, ERASEINFO_NOTE_NAME_BYTES);
+	if (!write_cache(cd_header, buf,
+				roundup(ERASEINFO_NOTE_NAME_BYTES, 4)))
+		return FALSE;
+
+	info->offset_eraseinfo = cd_header->offset;
+	if (!write_eraseinfo(cd_header, &size_eraseinfo))
+		return FALSE;
+
+	/*
+	 * The actual eraseinfo written may be less than pre-calculated size.
+	 * Hence fill up the rest of size with zero's.
+	 */
+	if (size_eraseinfo < info->size_eraseinfo)
+		write_cache_zero(cd_header,
+				info->size_eraseinfo - size_eraseinfo);
+
+	DEBUG_MSG("offset_eraseinfo: %lx, size_eraseinfo: %ld\n",
+			info->offset_eraseinfo, info->size_eraseinfo);
+
+	return TRUE;
+}
+
+int
 write_kdump_eraseinfo(struct cache_data *cd_page)
 {
 	off_t offset_eraseinfo;
@@ -7581,6 +7698,8 @@ writeout_dumpfile(void)
 			goto out;
 		if (!write_elf_pages(&cd_header, &cd_page))
 			goto out;
+		if (!write_elf_eraseinfo(&cd_header))
+			goto out;
 	} else {
 		if (!write_kdump_header())
 			goto out;
diff --git a/makedumpfile.h b/makedumpfile.h
index 2e4b902..662bc97 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -504,6 +504,22 @@ do { \
 #define MAX_SIZE_STR_LEN (21)
 
 /*
+ * ELF note section for erase information
+ *
+ * According to elf.h the unused values are 0x15(21) through 0xff. The value
+ * range 0x1XX, 0x2XX and 0x3XX is been used for PPC, i386 and s390
+ * respectively.
+ *
+ * Using 0xff to be on safer side so that any new Elf Note addition in elf.h
+ * after 0x15 value would not clash.
+ */
+#ifndef NT_ERASE_INFO
+#define NT_ERASE_INFO (0xff)	/* Contains erased information. */
+#endif
+#define ERASEINFO_NOTE_NAME		"ERASEINFO"
+#define ERASEINFO_NOTE_NAME_BYTES	(sizeof(ERASEINFO_NOTE_NAME))
+
+/*
  * The value of dependence on machine
  */
 #define PAGE_OFFSET		(info->page_offset)
@@ -977,6 +993,7 @@ struct DumpInfo {
 	 * ELF NOTE section in dump memory image info:
 	 */
 	off_t			offset_note;
+	off_t			offset_note_dumpfile;
 	unsigned long		size_note;
 
 	/*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
