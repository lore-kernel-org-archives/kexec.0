Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XLl3r-0000NB-Qn
 for kexec@lists.infradead.org; Mon, 25 Aug 2014 03:35:16 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 4/8] set vmcoreinfo for kcore
Date: Mon, 25 Aug 2014 11:33:08 +0800
Message-Id: <1408937592-2609-5-git-send-email-bhe@redhat.com>
In-Reply-To: <1408937592-2609-1-git-send-email-bhe@redhat.com>
References: <1408937592-2609-1-git-send-email-bhe@redhat.com>
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

In vmcore dumping, note program of vmcoreinfo is set in elf header
of /proc/vmcore. In 1st kernel, the vmcoreinfo is also needed for
kcore analyzing. So in this patch information of vmcoreinfo is
parsed and set in offset_vmcoreinfo and size_vmcoreinfo.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 elf_info.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 elf_info.h     |  1 +
 makedumpfile.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/elf_info.c b/elf_info.c
index 69d3fdb..d50124d 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -395,6 +395,53 @@ get_pt_note_info(void)
 	return TRUE;
 }
 
+#define UNINITIALIZED  ((ulong)(-1))
+int set_kcore_vmcoreinfo(uint64_t vmcoreinfo_addr, uint64_t vmcoreinfo_len)
+{
+	int i;
+	ulong kvaddr;
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
+	if (offset == UNINITIALIZED){
+		ERRMSG("Can't get the offset of VMCOREINFO(%s). %s\n",
+		    name_memory, strerror(errno));
+		return FALSE;
+	}
+
+        if (lseek(fd_memory, offset, SEEK_SET) != offset){
+		ERRMSG("Can't seek the dump memory(%s). %s\n",
+		    name_memory, strerror(errno));
+		return FALSE;
+	}
+
+	if (read(fd_memory, note, MAX_SIZE_NHDR) != MAX_SIZE_NHDR){
+		ERRMSG("Can't read the dump memory(%s). %s\n",
+		    name_memory, strerror(errno));
+		return FALSE;
+	}
+
+	size_desc   = note_descsz(note);
+	offset_desc = offset + offset_note_desc(note);
+
+	set_vmcoreinfo(offset_desc, size_desc);
+
+	return TRUE;
+}
 
 /*
  * External functions.
diff --git a/elf_info.h b/elf_info.h
index 263d993..3ce0138 100644
--- a/elf_info.h
+++ b/elf_info.h
@@ -45,6 +45,7 @@ int get_elf32_ehdr(int fd, char *filename, Elf32_Ehdr *ehdr);
 int get_elf_info(int fd, char *filename);
 void free_elf_info(void);
 int get_elf_loads(int fd, char *filename);
+int set_kcore_vmcoreinfo(uint64_t vmcoreinfo_addr, uint64_t vmcoreinfo_len);
 
 int is_elf64_memory(void);
 int is_xen_memory(void);
diff --git a/makedumpfile.c b/makedumpfile.c
index 8c8ca91..d43d02d 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -9143,6 +9143,39 @@ static int get_page_offset()
 	return TRUE;
 }
 
+
+/* Returns the physical address of start of crash notes buffer for a kernel. */
+static int get_sys_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
+{
+	char line[BUFSIZE_FGETS];
+	int count;
+	FILE *fp;
+	unsigned long long temp, temp2;
+
+	*addr = 0;
+	*len = 0;
+
+	if (!(fp = fopen("/sys/kernel/vmcoreinfo", "r")))
+		return FALSE;
+
+	if (!fgets(line, sizeof(line), fp)) {
+		ERRMSG("Cannot parse %s: %s, fgets failed.\n", "/sys/kernel/vmcoreinfo", strerror(errno));
+		return FALSE;
+	}
+	count = sscanf(line, "%Lx %Lx", &temp, &temp2);
+	if (count != 2){
+		ERRMSG("Cannot parse %s: %s, sscanf failed.\n", "/sys/kernel/vmcoreinfo", strerror(errno));
+		return FALSE;
+	}
+
+	*addr = (uint64_t) temp;
+	*len = (uint64_t) temp2;
+
+	fclose(fp);
+	return TRUE;
+}
+
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
