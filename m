Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Ji5-0005vX-Dn
 for kexec@lists.infradead.org; Fri, 29 Jan 2021 02:40:34 +0000
Received: by mail-pl1-x630.google.com with SMTP id b17so4454547plz.6
 for <kexec@lists.infradead.org>; Thu, 28 Jan 2021 18:40:33 -0800 (PST)
From: kazuhito.hagio@gmail.com
Subject: [PATCH 1/3] Use vmcoreinfo note in /proc/kcore for --mem-usage option
Date: Fri, 29 Jan 2021 11:40:23 +0900
Message-Id: <1611888025-29321-2-git-send-email-kazuhito.hagio@gmail.com>
In-Reply-To: <1611888025-29321-1-git-send-email-kazuhito.hagio@gmail.com>
References: <1611888025-29321-1-git-send-email-kazuhito.hagio@gmail.com>
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
To: bhupesh.linux@gmail.com, piliu@redhat.com, kexec@lists.infradead.org

From: Kazuhito Hagio <k-hagio-ab@nec.com>

kernel commit 23c85094fe18 added vmcoreinfo note to /proc/kcore.
Use the vmcoreinfo note to get necessary information, especially
page_offset and phys_base on arm64, for the --mem-usage option.

Signed-off-by: Kazuhito Hagio <k-hagio-ab@nec.com>
---
 elf_info.c     | 49 -------------------------------------------------
 elf_info.h     |  1 -
 makedumpfile.c | 26 +++++++++++++++++++++-----
 3 files changed, 21 insertions(+), 55 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index a6624b5..e8affb7 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -698,55 +698,6 @@ get_elf32_ehdr(int fd, char *filename, Elf32_Ehdr *ehdr)
 	return TRUE;
 }
 
-int
-get_elf_loads(int fd, char *filename)
-{
-	int i, j, phnum, elf_format;
-	Elf64_Phdr phdr;
-
-	/*
-	 * Check ELF64 or ELF32.
-	 */
-	elf_format = check_elf_format(fd, filename, &phnum, &num_pt_loads);
-	if (elf_format == ELF64)
-		flags_memory |= MEMORY_ELF64;
-	else if (elf_format != ELF32)
-		return FALSE;
-
-	if (!num_pt_loads) {
-		ERRMSG("Can't get the number of PT_LOAD.\n");
-		return FALSE;
-	}
-
-	/*
-	 * The below file information will be used as /proc/vmcore.
-	 */
-	fd_memory   = fd;
-	name_memory = filename;
-
-	pt_loads = calloc(sizeof(struct pt_load_segment), num_pt_loads);
-	if (pt_loads == NULL) {
-		ERRMSG("Can't allocate memory for the PT_LOAD. %s\n",
-		    strerror(errno));
-		return FALSE;
-	}
-	for (i = 0, j = 0; i < phnum; i++) {
-		if (!get_phdr_memory(i, &phdr))
-			return FALSE;
-
-		if (phdr.p_type != PT_LOAD)
-			continue;
-
-		if (j >= num_pt_loads)
-			return FALSE;
-		if (!dump_Elf_load(&phdr, j))
-			return FALSE;
-		j++;
-	}
-
-	return TRUE;
-}
-
 static int exclude_segment(struct pt_load_segment **pt_loads,
 			   unsigned int	*num_pt_loads, uint64_t start, uint64_t end)
 {
diff --git a/elf_info.h b/elf_info.h
index d9b5d05..d5416b3 100644
--- a/elf_info.h
+++ b/elf_info.h
@@ -44,7 +44,6 @@ int get_elf64_ehdr(int fd, char *filename, Elf64_Ehdr *ehdr);
 int get_elf32_ehdr(int fd, char *filename, Elf32_Ehdr *ehdr);
 int get_elf_info(int fd, char *filename);
 void free_elf_info(void);
-int get_elf_loads(int fd, char *filename);
 int set_kcore_vmcoreinfo(uint64_t vmcoreinfo_addr, uint64_t vmcoreinfo_len);
 int get_kcore_dump_loads(void);
 
diff --git a/makedumpfile.c b/makedumpfile.c
index ba0003a..768eda4 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -11445,6 +11445,7 @@ int show_mem_usage(void)
 {
 	uint64_t vmcoreinfo_addr, vmcoreinfo_len;
 	struct cycle cycle = {0};
+	int vmcoreinfo = FALSE;
 
 	if (!is_crashkernel_mem_reserved()) {
 		ERRMSG("No memory is reserved for crashkernel!\n");
@@ -11456,9 +11457,22 @@ int show_mem_usage(void)
 	if (!open_files_for_creating_dumpfile())
 		return FALSE;
 
-	if (!get_elf_loads(info->fd_memory, info->name_memory))
+	if (!get_elf_info(info->fd_memory, info->name_memory))
 		return FALSE;
 
+	/*
+	 * /proc/kcore on Linux 4.19 and later kernels have vmcoreinfo note in
+	 * NOTE segment.  See commit 23c85094fe18.
+	 */
+	if (has_vmcoreinfo()) {
+		off_t offset;
+		unsigned long size;
+
+		get_vmcoreinfo(&offset, &size);
+		vmcoreinfo = read_vmcoreinfo_from_vmcore(offset, size, FALSE);
+		DEBUG_MSG("Read vmcoreinfo from NOTE segment: %d\n", vmcoreinfo);
+	}
+
 	if (!get_page_offset())
 		return FALSE;
 
@@ -11466,11 +11480,13 @@ int show_mem_usage(void)
 	if (!get_phys_base())
 		return FALSE;
 
-	if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
-		return FALSE;
+	if (!vmcoreinfo) {
+		if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
+			return FALSE;
 
-	if (!set_kcore_vmcoreinfo(vmcoreinfo_addr, vmcoreinfo_len))
-		return FALSE;
+		if (!set_kcore_vmcoreinfo(vmcoreinfo_addr, vmcoreinfo_len))
+			return FALSE;
+	}
 
 	if (!initial())
 		return FALSE;
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
