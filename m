Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XBgBt-0005LX-At
 for kexec@lists.infradead.org; Mon, 28 Jul 2014 08:21:54 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [Patch v3 3/7] preparation functions for parsing vmcoreinfo
Date: Mon, 28 Jul 2014 16:20:02 +0800
Message-Id: <1406535606-16303-4-git-send-email-bhe@redhat.com>
In-Reply-To: <1406535606-16303-1-git-send-email-bhe@redhat.com>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
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

Add 2 preparation functions get_elf_loads and get_page_offset, later
they will be needed for parsing vmcoreinfo.

Meanwhile since get_kernel_version need be called to get page_offset
before initial() in mem_usage code flow, and surely it will be called
inside initial() again. Add a static variable to avoid this duplicate
calling.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 elf_info.c     | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 elf_info.h     |  1 +
 makedumpfile.c | 23 +++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/elf_info.c b/elf_info.c
index b277f69..69d3fdb 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -681,6 +681,56 @@ get_elf32_ehdr(int fd, char *filename, Elf32_Ehdr *ehdr)
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
+
 /*
  * Get ELF information about /proc/vmcore.
  */
diff --git a/elf_info.h b/elf_info.h
index 801faff..263d993 100644
--- a/elf_info.h
+++ b/elf_info.h
@@ -44,6 +44,7 @@ int get_elf64_ehdr(int fd, char *filename, Elf64_Ehdr *ehdr);
 int get_elf32_ehdr(int fd, char *filename, Elf32_Ehdr *ehdr);
 int get_elf_info(int fd, char *filename);
 void free_elf_info(void);
+int get_elf_loads(int fd, char *filename);
 
 int is_elf64_memory(void);
 int is_xen_memory(void);
diff --git a/makedumpfile.c b/makedumpfile.c
index 220570e..78aa7a5 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -681,6 +681,10 @@ get_kernel_version(char *release)
 	int32_t version;
 	long maj, min, rel;
 	char *start, *end;
+	static int done = 0;
+
+	if (done)
+		return info->kernel_version;
 
 	/*
 	 * This method checks that vmlinux and vmcore are same kernel version.
@@ -706,6 +710,9 @@ get_kernel_version(char *release)
 		MSG("The kernel version is not supported.\n");
 		MSG("The created dumpfile may be incomplete.\n");
 	}
+
+	done = 1;
+
 	return version;
 }
 
@@ -9062,6 +9069,22 @@ int is_crashkernel_mem_reserved(void)
         return !!crash_reserved_mem_nr;
 }
 
+static int get_page_offset()
+{
+#ifdef __x86_64__
+	struct utsname utsname;
+	if (uname(&utsname)) {
+		ERRMSG("Cannot get name and information about current kernel : %s", strerror(errno));
+		return FALSE;
+	}
+
+	info->kernel_version = get_kernel_version(utsname.release);
+	get_versiondep_info_x86_64();
+#endif /* x86_64 */
+
+	return TRUE;
+}
+
 static struct option longopts[] = {
 	{"split", no_argument, NULL, OPT_SPLIT},
 	{"reassemble", no_argument, NULL, OPT_REASSEMBLE},
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
