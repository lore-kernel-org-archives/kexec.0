Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1msPxn-008son-GM
 for kexec@lists.infradead.org; Wed, 01 Dec 2021 13:48:01 +0000
Received: by mail-ed1-x532.google.com with SMTP id o20so101330779eds.10
 for <kexec@lists.infradead.org>; Wed, 01 Dec 2021 05:47:59 -0800 (PST)
From: Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>
Subject: [RFC makedumpfile: add userinfo elf section 4/4] elf: add ability to
 read the userinfo data from note segment
Date: Wed,  1 Dec 2021 15:47:30 +0200
Message-Id: <20211201134730.15943-5-ikhoronz@cisco.com>
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

Previously were added the ability to save userinfo data to separate
ELF note subsection. This patch adds read mechanism.
The command to retrieve user specific information:
makedumpfile -U userinfofile dumpfile.

Signed-off-by: Ivan Khoronzhuk <ikhoronz@cisco.com>
---
 makedumpfile.c | 224 +++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |   2 +
 2 files changed, 226 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 6b6b4d2..0d29b87 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1519,6 +1519,60 @@ open_files_for_generating_vmcoreinfo(void)
 	return TRUE;
 }
 
+int
+open_files_for_generating_userinfo(void)
+{
+	FILE *file_userinfo;
+	int fd;
+
+	if ((file_userinfo = fopen(info->name_userinfo, "w+")) < 0) {
+		ERRMSG("Can't open the userinfo file(%s). %s\n",
+		    info->name_userinfo, strerror(errno));
+		return FALSE;
+	}
+
+	info->file_userinfo = file_userinfo;
+
+	if ((fd = open(info->name_dumpfile, O_RDONLY)) < 0) {
+		ERRMSG("Can't open the dump file(%s). %s\n",
+		    info->name_dumpfile, strerror(errno));
+		return FALSE;
+	}
+	info->fd_dumpfile = fd;
+
+	return TRUE;
+}
+
+int
+get_phdr_dumpfile(int index, Elf64_Phdr *phdr)
+{
+	Elf32_Phdr phdr32;
+
+	if (is_elf64_memory()) { /* ELF64 */
+		if (!get_elf64_phdr(info->fd_dumpfile, info->name_dumpfile,
+				    index, phdr)) {
+			ERRMSG("Can't find Phdr %d.\n", index);
+			return FALSE;
+		}
+	} else {
+		if (!get_elf32_phdr(info->fd_dumpfile, info->name_dumpfile,
+				    index, &phdr32)) {
+			ERRMSG("Can't find Phdr %d.\n", index);
+			return FALSE;
+		}
+		memset(phdr, 0, sizeof(Elf64_Phdr));
+		phdr->p_type   = phdr32.p_type;
+		phdr->p_flags  = phdr32.p_flags;
+		phdr->p_offset = phdr32.p_offset;
+		phdr->p_vaddr  = phdr32.p_vaddr;
+		phdr->p_paddr  = phdr32.p_paddr;
+		phdr->p_filesz = phdr32.p_filesz;
+		phdr->p_memsz  = phdr32.p_memsz;
+		phdr->p_align  = phdr32.p_align;
+	}
+	return TRUE;
+}
+
 /*
  * Open the following file when it rearranges the dump data.
  * - dump file
@@ -4758,6 +4812,122 @@ read_cache(struct cache_data *cd)
 	return TRUE;
 }
 
+int
+copy_userinfo(struct cache_data *cd)
+{
+	size_t buf_size, size;
+	char buf[BUFSIZE_FGETS];
+
+	cd->buf = buf;
+	buf_size = info->size_elf_userinfo;
+
+	while (buf_size > 0) {
+		size = buf_size >= BUFSIZE_FGETS ? BUFSIZE_FGETS : buf_size;
+
+		cd->cache_size = size;
+		if (!read_cache(cd))
+			return FALSE;
+
+		if (fwrite(cd->buf, size, 1, info->file_userinfo) != size)
+			return FALSE;
+
+		buf_size -= BUFSIZE_FGETS;
+	}
+
+	return TRUE;
+}
+
+int
+generate_userinfo(void)
+{
+	char buf[USERINFO_NOTE_NAME_BYTES];
+	size_t nhdr_size, size_note;
+	off_t userinfo_offset = 0;
+	Elf64_Phdr note_phdr;
+	struct cache_data ui;
+	Elf64_Ehdr ehdr64;
+	Elf32_Ehdr ehdr32;
+	int i, phnum;
+	off_t offset;
+	void *note;
+
+	if (!info->flag_elf_dumpfile)
+		return FALSE;
+
+	if (is_elf64_memory()) { /* ELF64 */
+		if (!get_elf64_ehdr(info->fd_dumpfile, info->name_dumpfile,
+				    &ehdr64)) {
+			ERRMSG("Can't get ehdr64.\n");
+			return FALSE;
+		}
+		phnum = ehdr64.e_phnum;
+
+	} else { /* ELF32 */
+		if (!get_elf32_ehdr(info->fd_dumpfile, info->name_dumpfile,
+				    &ehdr32)) {
+			ERRMSG("Can't get ehdr32.\n");
+			return FALSE;
+		}
+		phnum = ehdr32.e_phnum;
+	}
+
+	for (i = 0; i < phnum; i++) {
+		if (!get_phdr_dumpfile(i, &note_phdr))
+			return FALSE;
+
+		if (note_phdr.p_type == PT_NOTE)
+			break;
+	}
+
+	if (note_phdr.p_type != PT_NOTE) {
+		ERRMSG("Can't get a PT_NOTE header.\n");
+		return FALSE;
+	}
+
+	size_note = note_phdr.p_filesz;
+	ui.offset = note_phdr.p_offset;
+	ui.fd = info->fd_dumpfile;
+	ui.file_name = info->name_dumpfile;
+	ui.buf = buf;
+
+	nhdr_size = is_elf64_memory() ? sizeof(Elf64_Nhdr) :
+					sizeof(Elf32_Nhdr);
+
+	ui.cache_size = nhdr_size + USERINFO_NOTE_NAME_BYTES;
+
+	/* find userinfo section */
+	while (size_note > 0) {
+		if (!read_cache(&ui))
+			return FALSE;
+
+		note = ui.buf;
+		if (strcmp(note + nhdr_size, USERINFO_NOTE_NAME) == 0) {
+			userinfo_offset = ui.offset;
+			info->size_elf_userinfo = note_descsz(note);
+			break;
+		}
+
+		offset = offset_next_note(note);
+		size_note -= offset;
+
+		/* set next pnhdr */
+		ui.offset += note_descsz(note);
+	}
+
+	if (!userinfo_offset) {
+		ERRMSG("Can't get a USERINFO header.\n");
+		return FALSE;
+	}
+
+	ui.offset = userinfo_offset;
+
+	if (!copy_userinfo(&ui))
+		return FALSE;
+
+	return TRUE;
+}
+
+
 int
 is_bigendian(void)
 {
@@ -9450,6 +9620,15 @@ close_files_for_generating_vmcoreinfo(void)
 	return TRUE;
 }
 
+int
+close_files_for_generating_userinfo(void)
+{
+	close_dump_file();
+	close_userinfo_file();
+
+	return TRUE;
+}
+
 /*
  * Close the following file when it rearranges the dump data.
  * - dump file
@@ -9458,6 +9637,7 @@ int
 close_files_for_rearranging_dumpdata(void)
 {
 	close_dump_file();
+	close_userinfo_file();
 
 	return TRUE;
 }
@@ -11302,6 +11482,23 @@ check_param_for_rearranging_dumpdata(int argc, char *argv[])
 	return TRUE;
 }
 
+int
+check_param_for_creating_userinfo_file(int argc, char *argv[])
+{
+	if (argc != optind + 1)
+		return FALSE;
+
+	if (info->flag_compress        || info->dump_level
+	    || info->flag_elf_dumpfile || info->flag_read_vmcoreinfo
+	    || info->name_vmlinux      || info->name_xen_syms
+	    || info->flag_flatten      || info->flag_generate_vmcoreinfo
+	    || info->flag_exclude_xen_dom || info->flag_rearrange)
+		return FALSE;
+
+	info->name_dumpfile = argv[optind];
+	return TRUE;
+}
+
 /*
  * Parameters for reassembling multiple dumpfiles into one dumpfile.
  */
@@ -11974,6 +12171,10 @@ main(int argc, char *argv[])
 			info->flag_insert_userinfo = 1;
 			info->name_userinfo = optarg;
 			break;
+		case OPT_GENERATE_USERINFO:
+			info->flag_generate_userinfo = 1;
+			info->name_userinfo = optarg;
+			break;
 		case OPT_XEN_PHYS_START:
 			info->xen_phys_start = strtoul(optarg, NULL, 0);
 			break;
@@ -12097,6 +12298,29 @@ main(int argc, char *argv[])
 
 		MSG("\n");
 		MSG("The vmcoreinfo is saved to %s.\n", info->name_vmcoreinfo);
+	} else if (info->flag_generate_userinfo) {
+		if (!check_param_for_creating_userinfo_file(argc, argv)) {
+			MSG("Commandline parameter is invalid.\n");
+			MSG("Try `makedumpfile --help' for more information.\n");
+			goto out;
+		}
+		if (info->flag_check_params)
+			goto check_ok;
+
+		if (!check_file_is_writable(info->name_userinfo))
+			goto out;
+
+		if (!open_files_for_generating_userinfo())
+			goto out;
+
+		if (!generate_userinfo())
+			goto out;
+
+		if (!close_files_for_generating_userinfo())
+			goto out;
+
+		MSG("\n");
+		MSG("The userinfo file is saved to %s.\n", info->name_userinfo);
 
 	} else if (info->flag_rearrange) {
 		if (!check_param_for_rearranging_dumpdata(argc, argv)) {
diff --git a/makedumpfile.h b/makedumpfile.h
index b28b0a5..26f44c9 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1360,6 +1360,7 @@ struct DumpInfo {
 	int		flag_generate_vmcoreinfo;/* flag of generating vmcoreinfo file */
 	int		flag_read_vmcoreinfo;    /* flag of reading vmcoreinfo file */
 	int		flag_insert_userinfo;    /* flag of inserting userinfo file into ELF note section */
+	int		flag_generate_userinfo;    /* flag of inserting userinfo file into ELF note section */
 	int		flag_show_usage;     /* flag of showing usage */
 	int		flag_show_version;   /* flag of showing version */
 	int		flag_check_params;   /* only check parameters */
@@ -2491,6 +2492,7 @@ struct elf_prstatus {
 #define OPT_VMLINUX             'x'
 #define OPT_COMPRESS_ZSTD       'z'
 #define OPT_USERINFO            'u'
+#define OPT_GENERATE_USERINFO   'U'
 #define OPT_START               256
 #define OPT_SPLIT               OPT_START+0
 #define OPT_REASSEMBLE          OPT_START+1
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
