Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dE5am-0000wI-RF
 for kexec@lists.infradead.org; Fri, 26 May 2017 03:07:10 +0000
Received: by mail-pf0-f176.google.com with SMTP id n23so184428010pfb.2
 for <kexec@lists.infradead.org>; Thu, 25 May 2017 20:06:48 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile PATCH v4 1/2] makedumpfile: add runtime kaslr offset if
 it exists
Date: Fri, 26 May 2017 08:36:39 +0530
Message-Id: <302c16ede3723264ca0abb5eef9c9f553ffcfbd7.1495767738.git.panand@redhat.com>
In-Reply-To: <cover.1495767738.git.panand@redhat.com>
References: <cover.1495767738.git.panand@redhat.com>
In-Reply-To: <cover.1495767738.git.panand@redhat.com>
References: <cover.1495767738.git.panand@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, bhe@redhat.com, kexec@lists.infradead.org, xlpang@redhat.com, d.hatayama@jp.fujitsu.com, dyoung@redhat.com

If we have to erase a symbol from vmcore whose address is not present in
vmcoreinfo, then we need to pass vmlinux as well to get the symbol
address.
When kaslr is enabled, virtual address of all the kernel symbols are
randomized with an offset. vmlinux  always has a static address, but all
the arch specific calculation are based on run time kernel address. So
we need to find a way to translate symbol address from vmlinux to kernel
run time address.

without this patch:
   # cat > scrub.conf << EOF
   [vmlinux]
   erase jiffies
   erase init_task.utime
   for tsk in init_task.tasks.next within task_struct:tasks
       erase tsk.utime
   endfor
   EOF

    # makedumpfile --split  -d 5 -x vmlinux --config scrub.conf vmcore dumpfile_{1,2,3}

    readpage_kdump_compressed: pfn(f97ea) is excluded from vmcore.
    readmem: type_addr: 1, addr:f97eaff8, size:8
    vtop4_x86_64: Can't get pml4 (page_dir:f97eaff8).
    readmem: Can't convert a virtual address(ffffffff819f1284) to physical address.
    readmem: type_addr: 0, addr:ffffffff819f1284, size:390
    check_release: Can't get the address of system_utsname.

After this patch check_release() is ok, and also we are able to erase
symbol from vmcore.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/x86_64.c  | 36 ++++++++++++++++++++++++++++++++++++
 erase_info.c   |  1 +
 makedumpfile.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h | 16 ++++++++++++++++
 4 files changed, 99 insertions(+)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index e978a36f8878..fd2e8ac154d6 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -33,6 +33,42 @@ get_xen_p2m_mfn(void)
 	return NOT_FOUND_LONG_VALUE;
 }
 
+unsigned long
+get_kaslr_offset_x86_64(unsigned long vaddr)
+{
+	unsigned int i;
+	char buf[BUFSIZE_FGETS], *endp;
+
+	if (!info->kaslr_offset && info->file_vmcoreinfo) {
+		if (fseek(info->file_vmcoreinfo, 0, SEEK_SET) < 0) {
+			ERRMSG("Can't seek the vmcoreinfo file(%s). %s\n",
+					info->name_vmcoreinfo, strerror(errno));
+			return FALSE;
+		}
+
+		while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
+			i = strlen(buf);
+			if (!i)
+				break;
+			if (buf[i - 1] == '\n')
+				buf[i - 1] = '\0';
+			if (strncmp(buf, STR_KERNELOFFSET,
+					strlen(STR_KERNELOFFSET)) == 0)
+				info->kaslr_offset =
+					strtoul(buf+strlen(STR_KERNELOFFSET),&endp,16);
+		}
+	}
+	if (vaddr >= __START_KERNEL_map &&
+			vaddr < __START_KERNEL_map + info->kaslr_offset)
+		return info->kaslr_offset;
+	else
+		/*
+		 * TODO: we need to check if it is vmalloc/vmmemmap/module
+		 * address, we will have different offset
+		 */
+		return 0;
+}
+
 static int
 get_page_offset_x86_64(void)
 {
diff --git a/erase_info.c b/erase_info.c
index f2ba9149e93e..60abfa1a1adf 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -1088,6 +1088,7 @@ resolve_config_entry(struct config_entry *ce, unsigned long long base_vaddr,
 							ce->line, ce->name);
 			return FALSE;
 		}
+		ce->sym_addr += get_kaslr_offset(ce->sym_addr);
 		ce->type_name = get_symbol_type_name(ce->name,
 					DWARF_INFO_GET_SYMBOL_TYPE,
 					&ce->size, &ce->type_flag);
diff --git a/makedumpfile.c b/makedumpfile.c
index 301772a8820c..9babf1a07154 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3782,6 +3782,46 @@ free_for_parallel()
 }
 
 int
+find_kaslr_offsets()
+{
+	off_t offset;
+	unsigned long size;
+	int ret = FALSE;
+
+	get_vmcoreinfo(&offset, &size);
+
+	if (!(info->name_vmcoreinfo = strdup(FILENAME_VMCOREINFO))) {
+		MSG("Can't duplicate strings(%s).\n", FILENAME_VMCOREINFO);
+		return FALSE;
+	}
+	if (!copy_vmcoreinfo(offset, size))
+		goto out;
+
+	if (!open_vmcoreinfo("r"))
+		goto out;
+
+	unlink(info->name_vmcoreinfo);
+
+	/*
+	 * This arch specific function should update info->kaslr_offset. If
+	 * kaslr is not enabled then offset will be set to 0. arch specific
+	 * function might need to read from vmcoreinfo, therefore we have
+	 * called this function between open_vmcoreinfo() and
+	 * close_vmcoreinfo()
+	 */
+	get_kaslr_offset(SYMBOL(_stext));
+
+	close_vmcoreinfo();
+
+	ret = TRUE;
+out:
+	free(info->name_vmcoreinfo);
+	info->name_vmcoreinfo = NULL;
+
+	return ret;
+}
+
+int
 initial(void)
 {
 	off_t offset;
@@ -3833,6 +3873,9 @@ initial(void)
 		set_dwarf_debuginfo("vmlinux", NULL,
 					info->name_vmlinux, info->fd_vmlinux);
 
+		if (has_vmcoreinfo() && !find_kaslr_offsets())
+			return FALSE;
+
 		if (!get_symbol_info())
 			return FALSE;
 
@@ -8635,6 +8678,7 @@ close_vmcoreinfo(void)
 	if(fclose(info->file_vmcoreinfo) < 0)
 		ERRMSG("Can't close the vmcoreinfo file(%s). %s\n",
 		    info->name_vmcoreinfo, strerror(errno));
+	info->file_vmcoreinfo = NULL;
 }
 
 void
@@ -11026,11 +11070,13 @@ main(int argc, char *argv[])
 		    strerror(errno));
 		goto out;
 	}
+	info->file_vmcoreinfo = NULL;
 	info->fd_vmlinux = -1;
 	info->fd_xen_syms = -1;
 	info->fd_memory = -1;
 	info->fd_dumpfile = -1;
 	info->fd_bitmap = -1;
+	info->kaslr_offset = 0;
 	initialize_tables();
 
 	/*
diff --git a/makedumpfile.h b/makedumpfile.h
index e32e567018f6..9f16becadd55 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -253,10 +253,14 @@ static inline int string_exists(char *s) { return (s ? TRUE : FALSE); }
 #define SYMBOL_INIT(symbol, str_symbol) \
 do { \
 	SYMBOL(symbol) = get_symbol_addr(str_symbol); \
+	if (SYMBOL(symbol) != NOT_FOUND_SYMBOL) \
+		SYMBOL(symbol) += info->kaslr_offset; \
 } while (0)
 #define SYMBOL_INIT_NEXT(symbol, str_symbol) \
 do { \
 	SYMBOL(symbol) = get_next_symbol_addr(str_symbol); \
+	if (SYMBOL(symbol) != NOT_FOUND_SYMBOL) \
+		SYMBOL(symbol) += info->kaslr_offset; \
 } while (0)
 #define WRITE_SYMBOL(str_symbol, symbol) \
 do { \
@@ -495,6 +499,7 @@ do { \
 #define STR_CONFIG_X86_PAE	"CONFIG_X86_PAE=y"
 #define STR_CONFIG_PGTABLE_4	"CONFIG_PGTABLE_4=y"
 #define STR_CONFIG_PGTABLE_3	"CONFIG_PGTABLE_3=y"
+#define STR_KERNELOFFSET	"KERNELOFFSET="
 
 /*
  * common value
@@ -838,6 +843,7 @@ int get_xen_info_arm64(void);
 #define get_phys_base()		get_phys_base_arm64()
 #define get_machdep_info()	get_machdep_info_arm64()
 #define get_versiondep_info()	get_versiondep_info_arm64()
+#define get_kaslr_offset(X)	FALSE
 #define get_xen_basic_info_arch(X) get_xen_basic_info_arm64(X)
 #define get_xen_info_arch(X) get_xen_info_arm64(X)
 #define is_phys_addr(X)		stub_true_ul(X)
@@ -851,6 +857,7 @@ unsigned long long vaddr_to_paddr_arm(unsigned long vaddr);
 #define get_phys_base()		get_phys_base_arm()
 #define get_machdep_info()	get_machdep_info_arm()
 #define get_versiondep_info()	stub_true()
+#define get_kaslr_offset(X)	FALSE
 #define vaddr_to_paddr(X)	vaddr_to_paddr_arm(X)
 #define is_phys_addr(X)		stub_true_ul(X)
 #endif /* arm */
@@ -863,11 +870,13 @@ unsigned long long vaddr_to_paddr_x86(unsigned long vaddr);
 #define get_phys_base()		stub_true()
 #define get_machdep_info()	get_machdep_info_x86()
 #define get_versiondep_info()	get_versiondep_info_x86()
+#define get_kaslr_offset(X)	FALSE
 #define vaddr_to_paddr(X)	vaddr_to_paddr_x86(X)
 #define is_phys_addr(X)		stub_true_ul(X)
 #endif /* x86 */
 
 #ifdef __x86_64__
+unsigned long get_kaslr_offset_x86_64(unsigned long vaddr);
 int get_phys_base_x86_64(void);
 int get_machdep_info_x86_64(void);
 int get_versiondep_info_x86_64(void);
@@ -876,6 +885,7 @@ unsigned long long vtop4_x86_64(unsigned long vaddr);
 #define get_phys_base()		get_phys_base_x86_64()
 #define get_machdep_info()	get_machdep_info_x86_64()
 #define get_versiondep_info()	get_versiondep_info_x86_64()
+#define get_kaslr_offset(X)	get_kaslr_offset_x86_64(X)
 #define vaddr_to_paddr(X)	vtop4_x86_64(X)
 #define is_phys_addr(X)		stub_true_ul(X)
 #endif /* x86_64 */
@@ -888,6 +898,7 @@ unsigned long long vaddr_to_paddr_ppc64(unsigned long vaddr);
 #define get_phys_base()		stub_true()
 #define get_machdep_info()	get_machdep_info_ppc64()
 #define get_versiondep_info()	get_versiondep_info_ppc64()
+#define get_kaslr_offset(X)	FALSE
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
 #define is_phys_addr(X)		stub_true_ul(X)
 #endif          /* powerpc64 */
@@ -899,6 +910,7 @@ unsigned long long vaddr_to_paddr_ppc(unsigned long vaddr);
 #define get_phys_base()		stub_true()
 #define get_machdep_info()	get_machdep_info_ppc()
 #define get_versiondep_info()	stub_true()
+#define get_kaslr_offset(X)	FALSE
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc(X)
 #define is_phys_addr(X)		stub_true_ul(X)
 #endif          /* powerpc32 */
@@ -911,6 +923,7 @@ int is_iomem_phys_addr_s390x(unsigned long addr);
 #define get_phys_base()		stub_true()
 #define get_machdep_info()	get_machdep_info_s390x()
 #define get_versiondep_info()	stub_true()
+#define get_kaslr_offset(X)	FALSE
 #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
 #define is_phys_addr(X)		is_iomem_phys_addr_s390x(X)
 #endif          /* s390x */
@@ -923,6 +936,7 @@ unsigned long long vaddr_to_paddr_ia64(unsigned long vaddr);
 #define get_machdep_info()	get_machdep_info_ia64()
 #define get_phys_base()		get_phys_base_ia64()
 #define get_versiondep_info()	stub_true()
+#define get_kaslr_offset(X)	FALSE
 #define vaddr_to_paddr(X)	vaddr_to_paddr_ia64(X)
 #define VADDR_REGION(X)		(((unsigned long)(X)) >> REGION_SHIFT)
 #define is_phys_addr(X)		stub_true_ul(X)
@@ -1152,6 +1166,7 @@ struct DumpInfo {
 	int		vmemmap_psize;
 	int		vmemmap_cnt;
 	struct ppc64_vmemmap	*vmemmap_list;
+	unsigned long	kaslr_offset;
 
 	/*
 	 * page table info for ppc64
@@ -1803,6 +1818,7 @@ struct memory_range {
 struct memory_range crash_reserved_mem[CRASH_RESERVED_MEM_NR];
 int crash_reserved_mem_nr;
 
+unsigned long read_vmcoreinfo_symbol(char *str_symbol);
 int readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size);
 int get_str_osrelease_from_vmlinux(void);
 int read_vmcoreinfo_xen(void);
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
