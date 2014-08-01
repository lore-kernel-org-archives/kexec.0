Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XD78K-0004O3-MY
 for kexec@lists.infradead.org; Fri, 01 Aug 2014 07:20:09 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [Patch v3 4/7] set vmcoreinfo for kcore
Date: Fri, 1 Aug 2014 07:12:12 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9724660F@BPXM01GP.gisp.nec.co.jp>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
 <1406535606-16303-5-git-send-email-bhe@redhat.com>
In-Reply-To: <1406535606-16303-5-git-send-email-bhe@redhat.com>
Content-Language: ja-JP
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
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

>In vmcore dumping, note program of vmcoreinfo is set in elf header
>of /proc/vmcore. In 1st kernel, the vmcoreinfo is also needed for
>kcore analyzing. So in this patch information of vmcoreinfo is
>parsed and set in offset_vmcoreinfo and size_vmcoreinfo.
>
>Signed-off-by: Baoquan He <bhe@redhat.com>
>---
> elf_info.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> elf_info.h     |  1 +
> makedumpfile.c | 29 +++++++++++++++++++++++++++++
> 3 files changed, 77 insertions(+)
>
>diff --git a/elf_info.c b/elf_info.c
>index 69d3fdb..edbfc97 100644
>--- a/elf_info.c
>+++ b/elf_info.c
>@@ -395,6 +395,53 @@ get_pt_note_info(void)
> 	return TRUE;
> }
>
>+#define UNINITIALIZED  ((ulong)(-1))
>+int set_kcore_vmcoreinfo(uint64_t vmcoreinfo_addr, uint64_t vmcoreinfo_len)
>+{
>+	int i;
>+	ulong kvaddr;
>+	off_t offset;
>+	char note[MAX_SIZE_NHDR];
>+	int size_desc;
>+	off_t offset_desc;
>+
>+	offset = UNINITIALIZED;
>+	kvaddr = (ulong)vmcoreinfo_addr | PAGE_OFFSET;
>+
>+	for (i = 0; i < num_pt_loads; ++i) {
>+		struct pt_load_segment *p = &pt_loads[i];
>+		if ((kvaddr >= p->virt_start) && (kvaddr < p->virt_end)) {
>+			offset = (off_t)(kvaddr - p->virt_start) +
>+			(off_t)p->file_offset;
>+			break;
>+		}
>+	}
>+
>+	if (offset == UNINITIALIZED){
>+		ERRMSG("Can't seek the dump memory(%s). %s\n",
>+		    name_memory, strerror(errno));
>+		return FALSE;
>+	}
>+
>+        if (lseek(fd_memory, offset, SEEK_SET) != offset){
>+		ERRMSG("Can't seek the dump memory(%s). %s\n",
>+		    name_memory, strerror(errno));
>+		return FALSE;
>+	}

These two error messages are the same, they aren't helpful for debugging.
I think the former should be like "Can't get the offset of VMCOREINFO".

>+
>+	if (read(fd_memory, note, MAX_SIZE_NHDR) != MAX_SIZE_NHDR){
>+		ERRMSG("Can't read the dump memory(%s). %s\n",
>+		    name_memory, strerror(errno));
>+		return FALSE;
>+	}
>+
>+	size_desc   = note_descsz(note);
>+	offset_desc = offset + offset_note_desc(note);
>+
>+	set_vmcoreinfo(offset_desc, size_desc);
>+
>+	return TRUE;
>+}
>
> /*
>  * External functions.
>diff --git a/elf_info.h b/elf_info.h
>index 263d993..3ce0138 100644
>--- a/elf_info.h
>+++ b/elf_info.h
>@@ -45,6 +45,7 @@ int get_elf32_ehdr(int fd, char *filename, Elf32_Ehdr *ehdr);
> int get_elf_info(int fd, char *filename);
> void free_elf_info(void);
> int get_elf_loads(int fd, char *filename);
>+int set_kcore_vmcoreinfo(uint64_t vmcoreinfo_addr, uint64_t vmcoreinfo_len);
>
> int is_elf64_memory(void);
> int is_xen_memory(void);
>diff --git a/makedumpfile.c b/makedumpfile.c
>index 78aa7a5..84857e0 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -9085,6 +9085,35 @@ static int get_page_offset()
> 	return TRUE;
> }
>
>+
>+/* Returns the physical address of start of crash notes buffer for a kernel. */
>+static int get_sys_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
>+{

This function just return the result status, so please use TRUE or FALSE
as the return value instead of 0 or -1.

>+	char line[BUFSIZE_FGETS];
>+	int count;
>+	FILE *fp;
>+	unsigned long long temp, temp2;
>+
>+	*addr = 0;
>+	*len = 0;
>+
>+	if (!(fp = fopen("/sys/kernel/vmcoreinfo", "r")))
>+		return -1;
>+
>+	if (!fgets(line, sizeof(line), fp))
>+		ERRMSG("Cannot parse %s: %s\n", "/sys/kernel/vmcoreinfo", strerror(errno));
>+	count = sscanf(line, "%Lx %Lx", &temp, &temp2);
>+	if (count != 2)
>+		ERRMSG("Cannot parse %s: %s\n", "/sys/kernel/vmcoreinfo", strerror(errno));

The messages are the same, too.


Thanks
Atsushi Kumagai

>+
>+	*addr = (uint64_t) temp;
>+	*len = (uint64_t) temp2;
>+
>+	fclose(fp);
>+	return 0;
>+}
>+
>+
> static struct option longopts[] = {
> 	{"split", no_argument, NULL, OPT_SPLIT},
> 	{"reassemble", no_argument, NULL, OPT_REASSEMBLE},
>--
>1.8.5.3

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
