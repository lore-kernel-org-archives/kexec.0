Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1msPxi-008smf-RJ
 for kexec@lists.infradead.org; Wed, 01 Dec 2021 13:47:57 +0000
Received: by mail-ed1-x532.google.com with SMTP id r11so102119477edd.9
 for <kexec@lists.infradead.org>; Wed, 01 Dec 2021 05:47:54 -0800 (PST)
From: Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>
Subject: [RFC makedumpfile: add userinfo elf section 2/4] elf: add new
 "userinfo" ELF section to traverse debug information
Date: Wed,  1 Dec 2021 15:47:28 +0200
Message-Id: <20211201134730.15943-3-ikhoronz@cisco.com>
In-Reply-To: <20211201134730.15943-1-ikhoronz@cisco.com>
References: <20211201134730.15943-1-ikhoronz@cisco.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: Ivan Khoronzhuk <ikhoronz@cisco.com>

It's only for elf dumpfile, for compressed version should be added in
separate file. It adds new note section to the NOTE segment.

Signed-off-by: Ivan Khoronzhuk <ikhoronz@cisco.com>
---
 elf_info.h     |   3 +
 makedumpfile.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++-
 makedumpfile.h |  10 ++++
 3 files changed, 167 insertions(+), 1 deletion(-)

diff --git a/elf_info.h b/elf_info.h
index d5416b3..ca96935 100644
--- a/elf_info.h
+++ b/elf_info.h
@@ -25,6 +25,9 @@
 #define ERASEINFO_NOTE_NAME		"ERASEINFO"
 #define ERASEINFO_NOTE_NAME_BYTES	(sizeof(ERASEINFO_NOTE_NAME))
 
+#define USERINFO_NOTE_NAME		"USERINFO"
+#define USERINFO_NOTE_NAME_BYTES	(sizeof(USERINFO_NOTE_NAME))
+
 #define MAX_SIZE_NHDR	MAX(sizeof(Elf64_Nhdr), sizeof(Elf32_Nhdr))
 
 int get_elf64_phdr(int fd, char *filename, int index, Elf64_Phdr *phdr);
diff --git a/makedumpfile.c b/makedumpfile.c
index 6b62b92..6b6b4d2 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1396,6 +1396,23 @@ open_dump_file(void)
 	return TRUE;
 }
 
+int
+open_userinfo_file(void)
+{
+	FILE *file_userinfo;
+
+	if (info->flag_flatten || info->flag_dry_run ||
+	    !info->flag_insert_userinfo) {
+		file_userinfo = NULL;
+	} else if ((file_userinfo = fopen(info->name_userinfo, "r")) < 0) {
+		ERRMSG("Can't open the userinfo file(%s). %s\n",
+		    info->name_userinfo, strerror(errno));
+		return FALSE;
+	}
+	info->file_userinfo = file_userinfo;
+	return TRUE;
+}
+
 int
 check_file_is_writable(const char *path)
 {
@@ -7080,12 +7097,26 @@ write_elf_phdr(struct cache_data *cd_hdr, Elf64_Phdr *load)
 	return TRUE;
 }
 
+unsigned long
+get_size_userinfo(void)
+{
+	unsigned long size_userinfo = 0;
+
+	if (info->file_userinfo) {
+		fseek(info->file_userinfo, 0, SEEK_END);
+		size_userinfo = ftell(info->file_userinfo);
+		fseek(info->file_userinfo, 0, SEEK_SET);
+	}
+
+	return size_userinfo;
+}
+
 int
 write_elf_header(struct cache_data *cd_header)
 {
 	int i, num_loads_dumpfile, phnum;
 	off_t offset_note_memory, offset_note_dumpfile;
-	size_t size_note, size_eraseinfo = 0;
+	size_t size_note, size_eraseinfo = 0, size_userinfo;
 	Elf64_Ehdr ehdr64;
 	Elf32_Ehdr ehdr32;
 	Elf64_Phdr note;
@@ -7148,6 +7179,13 @@ write_elf_header(struct cache_data *cd_header)
 	 */
 	info->size_elf_eraseinfo = size_eraseinfo;
 
+	size_userinfo = get_size_userinfo();
+	/*
+	 * Store the size_userinfo for later use in write_elf_userinfo()
+	 * function.
+	 */
+	info->size_elf_userinfo = size_userinfo;
+
 	/*
 	 * Write a PT_NOTE header.
 	 */
@@ -7224,6 +7262,19 @@ write_elf_header(struct cache_data *cd_header)
 					roundup(size_eraseinfo, 4);
 	}
 
+	/*
+	 * Modify the note size in PT_NOTE header to accomodate userinfo data.
+	 * Userinfo will be written later.
+	 */
+	if (info->size_elf_userinfo) {
+		if (is_elf64_memory())
+			note.p_filesz += sizeof(Elf64_Nhdr);
+		else
+			note.p_filesz += sizeof(Elf32_Nhdr);
+		note.p_filesz += roundup(USERINFO_NOTE_NAME_BYTES, 4) +
+					roundup(size_userinfo, 4);
+	}
+
 	if (!write_elf_phdr(cd_header, &note))
 		goto out;
 
@@ -8892,6 +8943,27 @@ out:
 	return ret;
 }
 
+/*
+ * Traverse through userinfo nodes and write it to the o/p dumpfile.
+ */
+int
+write_userinfo(struct cache_data *cd_page)
+{
+	char buf[BUFSIZE_FGETS];
+	int len;
+
+	while (fgets(buf, BUFSIZE_FGETS, info->file_userinfo)) {
+		len = strlen(buf);
+		if (!len)
+			break;
+
+		if (!write_cache(cd_page, buf, len))
+			return FALSE;
+	}
+
+	return TRUE;
+}
+
 int
 write_elf_eraseinfo(struct cache_data *cd_header)
 {
@@ -8957,6 +9029,64 @@ write_elf_eraseinfo(struct cache_data *cd_header)
 	return TRUE;
 }
 
+static int
+write_elf_userinfo(struct cache_data *cd_header)
+{
+	char note[MAX_SIZE_NHDR];
+	char buf[USERINFO_NOTE_NAME_BYTES + 4];
+	off_t offset_userinfo;
+	unsigned long note_header_size, size_note;
+
+	DEBUG_MSG("user info size: %lu\n", info->size_elf_userinfo);
+
+	if (!info->size_elf_userinfo)
+		return TRUE;
+
+	DEBUG_MSG("Writing user info...\n");
+
+	/* calculate the userinfo ELF note offset */
+	get_pt_note(NULL, &size_note);
+	cd_header->offset = info->offset_note_dumpfile +
+				roundup(size_note, 4) +
+				roundup(info->size_elf_eraseinfo, 4);
+
+	/* Write userinfo ELF note header. */
+	memset(note, 0, sizeof(note));
+	if (is_elf64_memory()) {
+		Elf64_Nhdr *nh = (Elf64_Nhdr *)note;
+
+		note_header_size = sizeof(Elf64_Nhdr);
+		nh->n_namesz = USERINFO_NOTE_NAME_BYTES;
+		nh->n_descsz = info->size_elf_userinfo;
+		nh->n_type = 0;
+	} else {
+		Elf32_Nhdr *nh = (Elf32_Nhdr *)note;
+
+		note_header_size = sizeof(Elf32_Nhdr);
+		nh->n_namesz = USERINFO_NOTE_NAME_BYTES;
+		nh->n_descsz = info->size_elf_userinfo;
+		nh->n_type = 0;
+	}
+	if (!write_cache(cd_header, note, note_header_size))
+		return FALSE;
+
+	/* Write userinfo Note name */
+	memset(buf, 0, sizeof(buf));
+	memcpy(buf, USERINFO_NOTE_NAME, USERINFO_NOTE_NAME_BYTES);
+	if (!write_cache(cd_header, buf,
+				roundup(USERINFO_NOTE_NAME_BYTES, 4)))
+		return FALSE;
+
+	offset_userinfo = cd_header->offset;
+	if (!write_userinfo(cd_header))
+		return FALSE;
+
+	DEBUG_MSG("offset_userinfo: %llx, size_userinfo: %ld\n",
+		(unsigned long long)offset_userinfo, info->size_elf_userinfo);
+
+	return TRUE;
+}
+
 int
 write_kdump_eraseinfo(struct cache_data *cd_page)
 {
@@ -9260,6 +9390,18 @@ close_dump_file(void)
 	info->fd_dumpfile = -1;
 }
 
+void
+close_userinfo_file(void)
+{
+	if (info->flag_flatten || info->flag_dry_run)
+		return;
+
+	if (fclose(info->file_userinfo) < 0)
+		ERRMSG("Can't close the userinfo file(%s). %s\n",
+		    info->name_userinfo, strerror(errno));
+	info->file_userinfo = NULL;
+}
+
 void
 close_dump_bitmap(void)
 {
@@ -10193,6 +10335,9 @@ writeout_dumpfile(void)
 	if (!open_dump_file())
 		return FALSE;
 
+	if (!open_userinfo_file())
+		return FALSE;
+
 	if (info->flag_flatten) {
 		if (!write_start_flat_header())
 			return FALSE;
@@ -10211,6 +10356,8 @@ writeout_dumpfile(void)
 				goto write_cache_enospc;
 		if (!write_elf_eraseinfo(&cd_header))
 			goto out;
+		if (!write_elf_userinfo(&cd_header))
+			goto out;
 	} else {
 		if (!write_kdump_header())
 			goto out;
@@ -10235,6 +10382,7 @@ out:
 	free_cache_data(&cd_page);
 
 	close_dump_file();
+	close_userinfo_file();
 
 	if ((ret == FALSE) && info->flag_nospace)
 		return NOSPACE;
@@ -11693,6 +11841,7 @@ static struct option longopts[] = {
 	{"check-params", no_argument, NULL, OPT_CHECK_PARAMS},
 	{"dry-run", no_argument, NULL, OPT_DRY_RUN},
 	{"show-stats", no_argument, NULL, OPT_SHOW_STATS},
+	{"userinfo", required_argument, NULL, OPT_USERINFO},
 	{0, 0, 0, 0}
 };
 
@@ -11821,6 +11970,10 @@ main(int argc, char *argv[])
 		case OPT_COMPRESS_ZSTD:
 			info->flag_compress = DUMP_DH_COMPRESSED_ZSTD;
 			break;
+		case OPT_USERINFO:
+			info->flag_insert_userinfo = 1;
+			info->name_userinfo = optarg;
+			break;
 		case OPT_XEN_PHYS_START:
 			info->xen_phys_start = strtoul(optarg, NULL, 0);
 			break;
diff --git a/makedumpfile.h b/makedumpfile.h
index d583249..b28b0a5 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1359,6 +1359,7 @@ struct DumpInfo {
 	int		flag_elf_dumpfile;   /* flag of creating ELF dumpfile */
 	int		flag_generate_vmcoreinfo;/* flag of generating vmcoreinfo file */
 	int		flag_read_vmcoreinfo;    /* flag of reading vmcoreinfo file */
+	int		flag_insert_userinfo;    /* flag of inserting userinfo file into ELF note section */
 	int		flag_show_usage;     /* flag of showing usage */
 	int		flag_show_version;   /* flag of showing version */
 	int		flag_check_params;   /* only check parameters */
@@ -1469,6 +1470,9 @@ struct DumpInfo {
 	int			fd_xen_syms;
 	char			*name_xen_syms;
 
+	FILE			*file_userinfo;
+	char			*name_userinfo;
+
 	/*
 	 * Dump memory image info:
 	 */
@@ -1512,6 +1516,11 @@ struct DumpInfo {
 	 */
 	unsigned long           size_elf_eraseinfo;
 
+	/*
+	 * userinfo in dump memory image info:
+	 */
+	unsigned long           size_elf_userinfo;
+
 	/*
 	 * for Xen extraction
 	 */
@@ -2481,6 +2490,7 @@ struct elf_prstatus {
 #define OPT_EXCLUDE_XEN_DOM     'X'
 #define OPT_VMLINUX             'x'
 #define OPT_COMPRESS_ZSTD       'z'
+#define OPT_USERINFO            'u'
 #define OPT_START               256
 #define OPT_SPLIT               OPT_START+0
 #define OPT_REASSEMBLE          OPT_START+1
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
