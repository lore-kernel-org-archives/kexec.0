Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WuhpW-00014c-H1
 for kexec@lists.infradead.org; Wed, 11 Jun 2014 12:40:40 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH] Makedumpfile: vmcore size estimate
Date: Wed, 11 Jun 2014 20:39:05 +0800
Message-Id: <1402490345-18656-1-git-send-email-bhe@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, Baoquan He <bhe@redhat.com>, vgoyal@redhat.com

User want to get a rough estimate of vmcore size, then they can decide
how much storage space is reserved for vmcore dumping. This can help them
to deploy their machines better, possibly hundreds of machines.

In this draft patch, a new configuration option is added,
    "--vmcore-estimate"
User can execute below command to get a dumped kcore. Since kcore is a
elf file to map the whole memory of current kernel, it's  equal to the
memory of crash kernel though it's not exact. Content of kcore is dynamic
though /proc/vmcore is fixed once crash happened. But for vmcore size
estimate, it is better enough.

sudo makedumpfile -E -d 31 --vmcore-estimate /proc/kcore /var/crash/kcore-dump

Questions:
1. Or we can get the dumpable page numbers only, then calculate the estimated
vmcore size by a predifined factor if it's kdump compressed dumping. E.g if
lzo dump, we assume the compression ratio is 45%, then the estimate size is
equal to: (dumpable page numbers) * 4096* 45%.

This is easier but too rough, does anybody like this better compared with the
real dumping implemented in this draft patch.

2. If dump the /proc/kcore, there's still a bug I can't fixed. When elf dump,
in function write_elf_header()  it will pre-calculate a num_loads_dumpfile which
is the number of program segment which will be dumped. However during dumping,
the content of /proc/kcore is dynamic, the final num_loads_dumpfile may change
when call write_elf_pages_cyclic/write_elf_pages(). This will cause the final
dumped elf file has a bad file format. When you execute
"readelf -a /var/crash/kcore-dump", you will be a little surprised.

3. This is not a formal patch, if the final solution is decided, I will post a
patch, maybe a patchset. If you have suggestions about the code or implementation,
please post your comment.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 elf_info.c     | 136 ++++++++++++++++--
 elf_info.h     |  17 +++
 makedumpfile.c | 438 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 makedumpfile.h |   5 +
 4 files changed, 560 insertions(+), 36 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index b277f69..1b05ad1 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -36,16 +36,9 @@
 
 #define XEN_ELFNOTE_CRASH_INFO	(0x1000001)
 
-struct pt_load_segment {
-	off_t			file_offset;
-	unsigned long long	phys_start;
-	unsigned long long	phys_end;
-	unsigned long long	virt_start;
-	unsigned long long	virt_end;
-};
 
 static int			nr_cpus;             /* number of cpu */
-static off_t			max_file_offset;
+off_t			max_file_offset;
 
 /*
  * File information about /proc/vmcore:
@@ -60,9 +53,9 @@ static int			flags_memory;
 /*
  * PT_LOAD information about /proc/vmcore:
  */
-static unsigned int		num_pt_loads;
-static struct pt_load_segment	*pt_loads;
-static off_t			offset_pt_load_memory;
+unsigned int		num_pt_loads;
+struct pt_load_segment	*pt_loads;
+off_t			offset_pt_load_memory;
 
 /*
  * PT_NOTE information about /proc/vmcore:
@@ -395,7 +388,49 @@ get_pt_note_info(void)
 	return TRUE;
 }
 
+#define UNINITIALIZED  ((ulong)(-1))
 
+#define SEEK_ERROR       (-1)
+#define READ_ERROR       (-2)
+int set_kcore_vmcoreinfo(uint64_t vmcoreinfo_addr, uint64_t vmcoreinfo_len)
+{
+	int i;
+	ulong kvaddr;
+	Elf64_Nhdr *note64;
+	off_t offset;
+	char note[MAX_SIZE_NHDR];
+	int size_desc;
+	off_t offset_desc;
+
+	offset = UNINITIALIZED;
+	kvaddr = (ulong)vmcoreinfo_addr | PAGE_OFFSET;
+
+	for (i = 0; i < num_pt_loads; ++i) {
+		struct pt_load_segment *p = &pt_loads[i];
+		if ((kvaddr >= p->virt_start) && (kvaddr < p->virt_end)) {
+			offset = (off_t)(kvaddr - p->virt_start) +
+			(off_t)p->file_offset;
+			break;
+		}
+	}
+
+	if (offset == UNINITIALIZED)
+		return SEEK_ERROR;
+
+        if (lseek(fd_memory, offset, SEEK_SET) != offset)
+		perror("lseek");
+
+	if (read(fd_memory, note, MAX_SIZE_NHDR) != MAX_SIZE_NHDR)
+		return READ_ERROR;
+
+	note64 = (Elf64_Nhdr *)note;
+	size_desc   = note_descsz(note);
+	offset_desc = offset + offset_note_desc(note);
+
+	set_vmcoreinfo(offset_desc, size_desc);
+
+	return 0;
+}
 /*
  * External functions.
  */
@@ -681,6 +716,55 @@ get_elf32_ehdr(int fd, char *filename, Elf32_Ehdr *ehdr)
 	return TRUE;
 }
 
+int
+get_elf_loads(int fd, char *filename)
+{
+	int i, j, phnum, elf_format;
+	Elf64_Phdr phdr;
+
+	/*
+	 * Check ELF64 or ELF32.
+	 */
+	elf_format = check_elf_format(fd, filename, &phnum, &num_pt_loads);
+	if (elf_format == ELF64)
+		flags_memory |= MEMORY_ELF64;
+	else if (elf_format != ELF32)
+		return FALSE;
+
+	if (!num_pt_loads) {
+		ERRMSG("Can't get the number of PT_LOAD.\n");
+		return FALSE;
+	}
+
+	/*
+	 * The below file information will be used as /proc/vmcore.
+	 */
+	fd_memory   = fd;
+	name_memory = filename;
+
+	pt_loads = calloc(sizeof(struct pt_load_segment), num_pt_loads);
+	if (pt_loads == NULL) {
+		ERRMSG("Can't allocate memory for the PT_LOAD. %s\n",
+		    strerror(errno));
+		return FALSE;
+	}
+	for (i = 0, j = 0; i < phnum; i++) {
+		if (!get_phdr_memory(i, &phdr))
+			return FALSE;
+
+		if (phdr.p_type != PT_LOAD)
+			continue;
+
+		if (j >= num_pt_loads)
+			return FALSE;
+		if(!dump_Elf_load(&phdr, j))
+			return FALSE;
+		j++;
+	}
+
+	return TRUE;
+}
+
 /*
  * Get ELF information about /proc/vmcore.
  */
@@ -826,6 +910,36 @@ get_phdr_memory(int index, Elf64_Phdr *phdr)
 	return TRUE;
 }
 
+int
+get_phdr_load(int index, Elf64_Phdr *phdr)
+{
+	Elf32_Phdr phdr32;
+
+	if (is_elf64_memory()) { /* ELF64 */
+		phdr->p_type = PT_LOAD;
+		phdr->p_vaddr = pt_loads[index].virt_start;
+		phdr->p_paddr = pt_loads[index].phys_start;
+		phdr->p_memsz  = pt_loads[index].phys_end - pt_loads[index].phys_start;
+		phdr->p_filesz = phdr->p_memsz;
+		phdr->p_offset = pt_loads[index].file_offset;
+	} else {
+		if (!get_elf32_phdr(fd_memory, name_memory, index, &phdr32)) {
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
 off_t
 get_offset_pt_load_memory(void)
 {
diff --git a/elf_info.h b/elf_info.h
index 801faff..0c67d74 100644
--- a/elf_info.h
+++ b/elf_info.h
@@ -27,6 +27,19 @@
 
 #define MAX_SIZE_NHDR	MAX(sizeof(Elf64_Nhdr), sizeof(Elf32_Nhdr))
 
+struct pt_load_segment {
+	off_t			file_offset;
+	unsigned long long	phys_start;
+	unsigned long long	phys_end;
+	unsigned long long	virt_start;
+	unsigned long long	virt_end;
+};
+
+extern off_t			max_file_offset;
+extern unsigned int		num_pt_loads;
+extern struct pt_load_segment	*pt_loads;
+
+extern off_t			offset_pt_load_memory;
 
 off_t paddr_to_offset(unsigned long long paddr);
 off_t paddr_to_offset2(unsigned long long paddr, off_t hint);
@@ -44,11 +57,14 @@ int get_elf64_ehdr(int fd, char *filename, Elf64_Ehdr *ehdr);
 int get_elf32_ehdr(int fd, char *filename, Elf32_Ehdr *ehdr);
 int get_elf_info(int fd, char *filename);
 void free_elf_info(void);
+int get_elf_loads(int fd, char *filename);
 
 int is_elf64_memory(void);
 int is_xen_memory(void);
 
 int get_phnum_memory(void);
+
+int get_phdr_load(int index, Elf64_Phdr *phdr);
 int get_phdr_memory(int index, Elf64_Phdr *phdr);
 off_t get_offset_pt_load_memory(void);
 int get_pt_load(int idx,
@@ -68,6 +84,7 @@ void get_pt_note(off_t *offset, unsigned long *size);
 int has_vmcoreinfo(void);
 void set_vmcoreinfo(off_t offset, unsigned long size);
 void get_vmcoreinfo(off_t *offset, unsigned long *size);
+int set_kcore_vmcoreinfo(uint64_t vmcoreinfo_addr, uint64_t vmcoreinfo_len);
 
 int has_vmcoreinfo_xen(void);
 void get_vmcoreinfo_xen(off_t *offset, unsigned long *size);
diff --git a/makedumpfile.c b/makedumpfile.c
index 34db997..ac02747 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5146,6 +5146,7 @@ create_dump_bitmap(void)
 
 	if (info->flag_cyclic) {
 
+		printf("create_dump_bitmap flag_cyclic\n");
 		if (info->flag_elf_dumpfile) {
 			if (!prepare_bitmap_buffer_cyclic())
 				goto out;
@@ -5189,14 +5190,23 @@ get_loads_dumpfile(void)
 
 	initialize_2nd_bitmap(&bitmap2);
 
-	if (!(phnum = get_phnum_memory()))
-		return FALSE;
-
-	for (i = 0; i < phnum; i++) {
-		if (!get_phdr_memory(i, &load))
+	if (info->flag_vmcore_estimate) {
+		phnum = num_pt_loads;
+	} else {
+		if (!(phnum = get_phnum_memory()))
 			return FALSE;
-		if (load.p_type != PT_LOAD)
-			continue;
+	}
+
+	for (i = 0; i < num_pt_loads; i++) {
+		if (info->flag_vmcore_estimate) {
+			get_phdr_load(i , &load);
+		} else {
+			if (!get_phdr_memory(i, &load))
+				return FALSE;
+
+			if (load.p_type != PT_LOAD)
+				continue;
+		}
 
 		pfn_start = paddr_to_pfn(load.p_paddr);
 		pfn_end   = paddr_to_pfn(load.p_paddr + load.p_memsz);
@@ -5734,17 +5744,26 @@ write_elf_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 	off_seg_load    = info->offset_load_dumpfile;
 	cd_page->offset = info->offset_load_dumpfile;
 
-	if (!(phnum = get_phnum_memory()))
-		return FALSE;
+	if (info->flag_vmcore_estimate) {
+		phnum = num_pt_loads;
+	} else { 
+		if (!(phnum = get_phnum_memory()))
+			return FALSE;
+	}
 
 	gettimeofday(&tv_start, NULL);
 
 	for (i = 0; i < phnum; i++) {
-		if (!get_phdr_memory(i, &load))
-			return FALSE;
+		if (info->flag_vmcore_estimate) {
+			memset(&load, 0, sizeof(load));
+			get_phdr_load(i , &load);
+		} else {
+			if (!get_phdr_memory(i, &load))
+				return FALSE;
 
-		if (load.p_type != PT_LOAD)
-			continue;
+			if (load.p_type != PT_LOAD)
+				continue;
+		}
 
 		off_memory= load.p_offset;
 		paddr     = load.p_paddr;
@@ -5923,14 +5942,24 @@ get_loads_dumpfile_cyclic(void)
 	Elf64_Phdr load;
 	struct cycle cycle = {0};
 
-	if (!(phnum = get_phnum_memory()))
-		return FALSE;
+	if (info->flag_vmcore_estimate) {
+		phnum = num_pt_loads;
+	} else {
+		if (!(phnum = get_phnum_memory()))
+			return FALSE;
+	}
 
 	for (i = 0; i < phnum; i++) {
-		if (!get_phdr_memory(i, &load))
-			return FALSE;
-		if (load.p_type != PT_LOAD)
-			continue;
+		if (info->flag_vmcore_estimate) {
+			memset(&load, 0, sizeof(load) );
+			get_phdr_load(i , &load);
+		} else {
+			if (!get_phdr_memory(i, &load))
+				return FALSE;
+
+			if (load.p_type != PT_LOAD)
+				continue;
+		}
 
 		pfn_start = paddr_to_pfn(load.p_paddr);
 		pfn_end = paddr_to_pfn(load.p_paddr + load.p_memsz);
@@ -6016,17 +6045,26 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	pfn_user = pfn_free = pfn_hwpoison = 0;
 	pfn_memhole = info->max_mapnr;
 
-	if (!(phnum = get_phnum_memory()))
-		return FALSE;
+	if (info->flag_vmcore_estimate) {
+		phnum = num_pt_loads;
+	} else { 
+		if (!(phnum = get_phnum_memory()))
+			return FALSE;
+	}
 
 	gettimeofday(&tv_start, NULL);
 
 	for (i = 0; i < phnum; i++) {
-		if (!get_phdr_memory(i, &load))
-			return FALSE;
+		if (info->flag_vmcore_estimate) {
+			memset(&load, 0, sizeof(load));
+			get_phdr_load(i , &load);
+		} else {
+			if (!get_phdr_memory(i, &load))
+				return FALSE;
 
-		if (load.p_type != PT_LOAD)
-			continue;
+			if (load.p_type != PT_LOAD)
+				continue;
+		}
 
 		off_memory= load.p_offset;
 		paddr = load.p_paddr;
@@ -8929,6 +8967,13 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
 		 */
 		info->name_memory   = argv[optind];
 
+	} else if ((argc == optind + 2) && info->flag_vmcore_estimate) {
+		/*
+		 * Parameters for get the /proc/kcore to estimate
+		 * the size of dumped vmcore
+		 */
+		info->name_memory   = argv[optind];
+		info->name_dumpfile = argv[optind+1];
 	} else
 		return FALSE;
 
@@ -9011,6 +9056,332 @@ out:
 	return free_size;
 }
 
+struct memory_range {
+        unsigned long long start, end;
+};
+
+#define CRASH_RESERVED_MEM_NR   8
+static struct memory_range crash_reserved_mem[CRASH_RESERVED_MEM_NR];
+static int crash_reserved_mem_nr;
+
+/*
+ * iomem_for_each_line()
+ *
+ * Iterate over each line in the file returned by proc_iomem(). If match is
+ * NULL or if the line matches with our match-pattern then call the
+ * callback if non-NULL.
+ *
+ * Return the number of lines matched.
+ */
+int iomem_for_each_line(char *match,
+			      int (*callback)(void *data,
+					      int nr,
+					      char *str,
+					      unsigned long base,
+					      unsigned long length),
+			      void *data)
+{
+	const char iomem[] = "/proc/iomem";
+	char line[MAX_LINE];
+	FILE *fp;
+	unsigned long long start, end, size;
+	char *str;
+	int consumed;
+	int count;
+	int nr = 0;
+
+	fp = fopen(iomem, "r");
+	if (!fp) {
+		ERRMSG("Cannot open %s\n", iomem);
+		exit(1);
+	}
+
+	while(fgets(line, sizeof(line), fp) != 0) {
+		count = sscanf(line, "%Lx-%Lx : %n", &start, &end, &consumed);
+		if (count != 2)
+			continue;
+		str = line + consumed;
+		size = end - start + 1;
+		if (!match || memcmp(str, match, strlen(match)) == 0) {
+			if (callback
+			    && callback(data, nr, str, start, size) < 0) {
+				break;
+			}
+			nr++;
+		}
+	}
+
+	fclose(fp);
+
+	return nr;
+}
+
+static int crashkernel_mem_callback(void *data, int nr,
+                                          char *str,
+                                          unsigned long base,
+                                          unsigned long length)
+{
+        if (nr >= CRASH_RESERVED_MEM_NR)
+                return 1;
+
+        crash_reserved_mem[nr].start = base;
+        crash_reserved_mem[nr].end   = base + length - 1;
+        return 0;
+}
+
+int is_crashkernel_mem_reserved(void)
+{
+        int ret;
+
+        ret = iomem_for_each_line("Crash kernel\n",
+                                        crashkernel_mem_callback, NULL);
+        crash_reserved_mem_nr = ret;
+
+        return !!crash_reserved_mem_nr;
+}
+
+/* Returns the physical address of start of crash notes buffer for a kernel. */
+static int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
+{
+	char line[MAX_LINE];
+	int count;
+	FILE *fp;
+	unsigned long long temp, temp2;
+
+	*addr = 0;
+	*len = 0;
+
+	if (!(fp = fopen("/sys/kernel/vmcoreinfo", "r")))
+		return -1;
+
+	if (!fgets(line, sizeof(line), fp))
+		ERRMSG("Cannot parse %s: %s\n", "/sys/kernel/vmcoreinfo", strerror(errno));
+	count = sscanf(line, "%Lx %Lx", &temp, &temp2);
+	if (count != 2)
+		ERRMSG("Cannot parse %s: %s\n", "/sys/kernel/vmcoreinfo", strerror(errno));
+
+	*addr = (uint64_t) temp;
+	*len = (uint64_t) temp2;
+
+	fclose(fp);
+	return 0;
+}
+
+
+static int exclude_segment(struct pt_load_segment **pt_loads, unsigned int	*num_pt_loads, uint64_t start, uint64_t end)
+{
+        int i, j, tidx = -1;
+	unsigned long long	vstart, vend, kvstart, kvend;
+        struct pt_load_segment temp_seg = {0};
+	kvstart = (ulong)start | PAGE_OFFSET;
+	kvend = (ulong)end | PAGE_OFFSET;
+	unsigned long size;
+
+        for (i = 0; i < (*num_pt_loads); i++) {
+                vstart = (*pt_loads)[i].virt_start;
+                vend = (*pt_loads)[i].virt_end;
+                if (kvstart <  vend && kvend > vstart) {
+                        if (kvstart != vstart && kvend != vend) {
+				/* Split load segment */
+				temp_seg.phys_start = end +1;
+				temp_seg.phys_end = (*pt_loads)[i].phys_end;
+				temp_seg.virt_start = kvend + 1;
+				temp_seg.virt_end = vend;
+				temp_seg.file_offset = (*pt_loads)[i].file_offset + temp_seg.virt_start - (*pt_loads)[i].virt_start;
+
+				(*pt_loads)[i].virt_end = kvstart - 1;
+				(*pt_loads)[i].phys_end =  start -1;
+
+				tidx = i+1;
+                        } else if (kvstart != vstart) {
+				(*pt_loads)[i].phys_end = start - 1;
+				(*pt_loads)[i].virt_end = kvstart - 1;
+                        } else {
+				(*pt_loads)[i].phys_start = end + 1;
+				(*pt_loads)[i].virt_start = kvend + 1;
+                        }
+                }
+        }
+        /* Insert split load segment, if any. */
+	if (tidx >= 0) {
+		size = (*num_pt_loads + 1) * sizeof((*pt_loads)[0]);
+		(*pt_loads) = realloc((*pt_loads), size);
+		if  (!(*pt_loads) ) {
+		    ERRMSG("Cannot realloc %ld bytes: %s\n",
+		            size + 0UL, strerror(errno));
+			exit(1);
+		}
+		for (j = (*num_pt_loads - 1); j >= tidx; j--)
+		        (*pt_loads)[j+1] = (*pt_loads)[j];
+		(*pt_loads)[tidx] = temp_seg;
+		(*num_pt_loads)++;
+        }
+        return 0;
+}
+
+static int
+process_dump_load(struct pt_load_segment	*pls)
+{
+	unsigned long long paddr;
+
+	paddr = vaddr_to_paddr(pls->virt_start);
+	pls->phys_start  = paddr;
+	pls->phys_end    = paddr + (pls->virt_end - pls->virt_start);
+	MSG("process_dump_load\n");
+	MSG("  phys_start : %llx\n", pls->phys_start);
+	MSG("  phys_end   : %llx\n", pls->phys_end);
+	MSG("  virt_start : %llx\n", pls->virt_start);
+	MSG("  virt_end   : %llx\n", pls->virt_end);
+
+	return TRUE;
+}
+
+int get_kcore_dump_loads()
+{
+	struct pt_load_segment	*pls;
+	int i, j, loads=0;
+	unsigned long long paddr;
+
+	for (i = 0; i < num_pt_loads; ++i) {
+		struct pt_load_segment *p = &pt_loads[i];
+		if (is_vmalloc_addr(p->virt_start))
+			continue;
+		loads++;
+	}
+
+	pls = calloc(sizeof(struct pt_load_segment), j);
+	if (pls == NULL) {
+		ERRMSG("Can't allocate memory for the PT_LOAD. %s\n",
+		    strerror(errno));
+		return FALSE;
+	}
+
+	for (i = 0, j=0; i < num_pt_loads; ++i) {
+		struct pt_load_segment *p = &pt_loads[i];
+		if (is_vmalloc_addr(p->virt_start))
+			continue;
+		if (j >= loads)
+			return FALSE;
+
+		if (j == 0) {
+			offset_pt_load_memory = p->file_offset;
+			if (offset_pt_load_memory == 0) {
+				ERRMSG("Can't get the offset of page data.\n");
+				return FALSE;
+			}
+		}
+
+		pls[j] = *p;
+		process_dump_load(&pls[j]);
+		j++;
+	}
+
+	free(pt_loads);
+	pt_loads = pls;
+	num_pt_loads = loads;
+
+	for (i=0; i<crash_reserved_mem_nr; i++)
+	{
+		exclude_segment(&pt_loads, &num_pt_loads, crash_reserved_mem[i].start, crash_reserved_mem[i].end);
+	}
+
+	max_file_offset = 0;
+	for (i = 0; i < num_pt_loads; ++i) {
+		struct pt_load_segment *p = &pt_loads[i];
+		max_file_offset = MAX(max_file_offset,
+				      p->file_offset + p->phys_end - p->phys_start);
+	}
+
+	for (i = 0; i < num_pt_loads; ++i) {
+		struct pt_load_segment *p = &pt_loads[i];
+		MSG("LOAD (%d)\n", i);
+		MSG("  phys_start : %llx\n", p->phys_start);
+		MSG("  phys_end   : %llx\n", p->phys_end);
+		MSG("  virt_start : %llx\n", p->virt_start);
+		MSG("  virt_end   : %llx\n", p->virt_end);
+	}
+
+	return TRUE;
+}
+
+int get_page_offset()
+{
+	struct utsname utsname;
+	if (uname(&utsname)) {
+		ERRMSG("Cannot get name and information about current kernel : %s", strerror(errno));
+		return FALSE;
+	}
+
+	info->kernel_version = get_kernel_version(utsname.release);
+	get_versiondep_info_x86_64();
+	return TRUE;
+}
+
+int vmcore_estimate(void)
+{
+	uint64_t vmcoreinfo_addr, vmcoreinfo_len;
+	int num_retry, status;
+
+	if (!is_crashkernel_mem_reserved()) {
+		ERRMSG("No memory is reserved for crashkenrel!\n");
+		exit(1);
+	}
+
+	get_page_offset();
+
+#if 1
+	if (!open_dump_memory())
+		return FALSE;
+#endif
+
+	if (info->flag_vmcore_estimate) {
+		if (!get_elf_loads(info->fd_memory, info->name_memory))
+			return FALSE;
+	}
+
+	if (get_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
+		return FALSE;
+
+	if (set_kcore_vmcoreinfo(vmcoreinfo_addr, vmcoreinfo_len))
+		return FALSE;
+
+	if (!get_kcore_dump_loads())
+		return FALSE;
+
+#if 1
+	if (!initial())
+		return FALSE;
+#endif
+
+retry:
+	if (!create_dump_bitmap())
+		return FALSE;
+
+	if ((status = writeout_dumpfile()) == FALSE)
+		return FALSE;
+
+	if (status == NOSPACE) {
+		/*
+		 * If specifying the other dump_level, makedumpfile tries
+		 * to create a dumpfile with it again.
+		 */
+		num_retry++;
+		if ((info->dump_level = get_next_dump_level(num_retry)) < 0)
+			return FALSE;
+		MSG("Retry to create a dumpfile by dump_level(%d).\n",
+		    info->dump_level);
+		if (!delete_dumpfile())
+			return FALSE;
+		goto retry;
+	}
+	print_report();
+
+	clear_filter_info();
+	if (!close_files_for_creating_dumpfile())
+		return FALSE;
+
+	return TRUE;
+}
 
 /*
  * Choose the lesser value of the two below as the size of cyclic buffer.
@@ -9063,6 +9434,7 @@ static struct option longopts[] = {
 	{"cyclic-buffer", required_argument, NULL, OPT_CYCLIC_BUFFER},
 	{"eppic", required_argument, NULL, OPT_EPPIC},
 	{"non-mmap", no_argument, NULL, OPT_NON_MMAP},
+	{"vmcore-estimate", no_argument, NULL, OPT_VMCORE_ESTIMATE},
 	{0, 0, 0, 0}
 };
 
@@ -9154,6 +9526,9 @@ main(int argc, char *argv[])
 		case OPT_DUMP_DMESG:
 			info->flag_dmesg = 1;
 			break;
+		case OPT_VMCORE_ESTIMATE:
+			info->flag_vmcore_estimate = 1;
+			break;
 		case OPT_COMPRESS_SNAPPY:
 			info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
 			break;
@@ -9294,6 +9669,19 @@ main(int argc, char *argv[])
 
 		MSG("\n");
 		MSG("The dmesg log is saved to %s.\n", info->name_dumpfile);
+	} else if (info->flag_vmcore_estimate) {
+#if 1
+		if (!check_param_for_creating_dumpfile(argc, argv)) {
+			MSG("Commandline parameter is invalid.\n");
+			MSG("Try `makedumpfile --help' for more information.\n");
+			goto out;
+		}
+#endif
+		if (!vmcore_estimate())
+			goto out;
+
+		MSG("\n");
+		MSG("vmcore size estimate successfully.\n");
 	} else {
 		if (!check_param_for_creating_dumpfile(argc, argv)) {
 			MSG("Commandline parameter is invalid.\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index 9402f05..c401337 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -216,6 +216,9 @@ isAnon(unsigned long mapping)
 #define FILENAME_STDOUT		"STDOUT"
 #define MAP_REGION		(4096*1024)
 
+#define MAX_LINE	160
+
+
 /*
  * Minimam vmcore has 2 ProgramHeaderTables(PT_NOTE and PT_LOAD).
  */
@@ -910,6 +913,7 @@ struct DumpInfo {
 	int		flag_force;	     /* overwrite existing stuff */
 	int		flag_exclude_xen_dom;/* exclude Domain-U from xen-kdump */
 	int             flag_dmesg;          /* dump the dmesg log out of the vmcore file */
+	int             flag_vmcore_estimate;          /* estimate the size  of vmcore in current system */
 	int		flag_use_printk_log; /* did we read printk_log symbol name? */
 	int		flag_nospace;	     /* the flag of "No space on device" error */
 	int		flag_vmemmap;        /* kernel supports vmemmap address space */
@@ -1764,6 +1768,7 @@ struct elf_prstatus {
 #define OPT_CYCLIC_BUFFER       OPT_START+11
 #define OPT_EPPIC               OPT_START+12
 #define OPT_NON_MMAP            OPT_START+13
+#define OPT_VMCORE_ESTIMATE            OPT_START+14
 
 /*
  * Function Prototype.
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
