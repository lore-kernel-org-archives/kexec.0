Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X9qsl-0004XY-Lf
 for kexec@lists.infradead.org; Wed, 23 Jul 2014 07:22:36 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH 5/7] prepare the dump loads for kcore analysis
Date: Wed, 23 Jul 2014 07:20:32 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9724346D@BPXM01GP.gisp.nec.co.jp>
References: <1405062964-11406-1-git-send-email-bhe@redhat.com>
 <1405062964-11406-5-git-send-email-bhe@redhat.com>
In-Reply-To: <1405062964-11406-5-git-send-email-bhe@redhat.com>
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

>In kcore, only  "System Ram" and "kernel text" program segments
>are needed. And to be more precise, exclude the crashkernel
>memory range.
>
>Signed-off-by: Baoquan He <bhe@redhat.com>

Please fix the compiler warnings below:

warning.c:858: warning: implicit declaration of function ‘is_vmalloc_addr’
warning.c:854: warning: unused variable ‘paddr’


Thanks
Atsushi Kumagai

>---
> elf_info.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> elf_info.h |   1 +
> 2 files changed, 136 insertions(+)
>
>diff --git a/elf_info.c b/elf_info.c
>index 1a3e3bd..ca63d34 100644
>--- a/elf_info.c
>+++ b/elf_info.c
>@@ -779,6 +779,141 @@ get_elf_loads(int fd, char *filename)
> 	return TRUE;
> }
>
>+static int exclude_segment(struct pt_load_segment **pt_loads, unsigned int	*num_pt_loads, uint64_t start,
>uint64_t end)
>+{
>+        int i, j, tidx = -1;
>+	unsigned long long	vstart, vend, kvstart, kvend;
>+        struct pt_load_segment temp_seg = {0};
>+	kvstart = (ulong)start | PAGE_OFFSET;
>+	kvend = (ulong)end | PAGE_OFFSET;
>+	unsigned long size;
>+
>+        for (i = 0; i < (*num_pt_loads); i++) {
>+                vstart = (*pt_loads)[i].virt_start;
>+                vend = (*pt_loads)[i].virt_end;
>+                if (kvstart <  vend && kvend > vstart) {
>+                        if (kvstart != vstart && kvend != vend) {
>+				/* Split load segment */
>+				temp_seg.phys_start = end +1;
>+				temp_seg.phys_end = (*pt_loads)[i].phys_end;
>+				temp_seg.virt_start = kvend + 1;
>+				temp_seg.virt_end = vend;
>+				temp_seg.file_offset = (*pt_loads)[i].file_offset + temp_seg.virt_start -
>(*pt_loads)[i].virt_start;
>+
>+				(*pt_loads)[i].virt_end = kvstart - 1;
>+				(*pt_loads)[i].phys_end =  start -1;
>+
>+				tidx = i+1;
>+                        } else if (kvstart != vstart) {
>+				(*pt_loads)[i].phys_end = start - 1;
>+				(*pt_loads)[i].virt_end = kvstart - 1;
>+                        } else {
>+				(*pt_loads)[i].phys_start = end + 1;
>+				(*pt_loads)[i].virt_start = kvend + 1;
>+                        }
>+                }
>+        }
>+        /* Insert split load segment, if any. */
>+	if (tidx >= 0) {
>+		size = (*num_pt_loads + 1) * sizeof((*pt_loads)[0]);
>+		(*pt_loads) = realloc((*pt_loads), size);
>+		if  (!(*pt_loads) ) {
>+		    ERRMSG("Cannot realloc %ld bytes: %s\n",
>+		            size + 0UL, strerror(errno));
>+			exit(1);
>+		}
>+		for (j = (*num_pt_loads - 1); j >= tidx; j--)
>+		        (*pt_loads)[j+1] = (*pt_loads)[j];
>+		(*pt_loads)[tidx] = temp_seg;
>+		(*num_pt_loads)++;
>+        }
>+        return 0;
>+}
>+
>+static int
>+process_dump_load(struct pt_load_segment	*pls)
>+{
>+	unsigned long long paddr;
>+
>+	paddr = vaddr_to_paddr(pls->virt_start);
>+	pls->phys_start  = paddr;
>+	pls->phys_end    = paddr + (pls->virt_end - pls->virt_start);
>+	DEBUG_MSG("process_dump_load\n");
>+	DEBUG_MSG("  phys_start : %llx\n", pls->phys_start);
>+	DEBUG_MSG("  phys_end   : %llx\n", pls->phys_end);
>+	DEBUG_MSG("  virt_start : %llx\n", pls->virt_start);
>+	DEBUG_MSG("  virt_end   : %llx\n", pls->virt_end);
>+
>+	return TRUE;
>+}
>+
>+int get_kcore_dump_loads()
>+{
>+	struct pt_load_segment	*pls;
>+	int i, j, loads=0;
>+	unsigned long long paddr;
>+
>+	for (i = 0; i < num_pt_loads; ++i) {
>+		struct pt_load_segment *p = &pt_loads[i];
>+		if (is_vmalloc_addr(p->virt_start))
>+			continue;
>+		loads++;
>+	}
>+
>+	pls = calloc(sizeof(struct pt_load_segment), loads);
>+	if (pls == NULL) {
>+		ERRMSG("Can't allocate memory for the PT_LOAD. %s\n",
>+		    strerror(errno));
>+		return FALSE;
>+	}
>+
>+	for (i = 0, j=0; i < num_pt_loads; ++i) {
>+		struct pt_load_segment *p = &pt_loads[i];
>+		if (is_vmalloc_addr(p->virt_start))
>+			continue;
>+		if (j >= loads)
>+			return FALSE;
>+
>+		if (j == 0) {
>+			offset_pt_load_memory = p->file_offset;
>+			if (offset_pt_load_memory == 0) {
>+				ERRMSG("Can't get the offset of page data.\n");
>+				return FALSE;
>+			}
>+		}
>+
>+		pls[j] = *p;
>+		process_dump_load(&pls[j]);
>+		j++;
>+	}
>+
>+	free(pt_loads);
>+	pt_loads = pls;
>+	num_pt_loads = loads;
>+
>+	for (i=0; i<crash_reserved_mem_nr; i++)
>+	{
>+		exclude_segment(&pt_loads, &num_pt_loads, crash_reserved_mem[i].start, crash_reserved_mem[i].end);
>+	}
>+
>+	max_file_offset = 0;
>+	for (i = 0; i < num_pt_loads; ++i) {
>+		struct pt_load_segment *p = &pt_loads[i];
>+		max_file_offset = MAX(max_file_offset,
>+				      p->file_offset + p->phys_end - p->phys_start);
>+	}
>+
>+	for (i = 0; i < num_pt_loads; ++i) {
>+		struct pt_load_segment *p = &pt_loads[i];
>+		DEBUG_MSG("LOAD (%d)\n", i);
>+		DEBUG_MSG("  phys_start : %llx\n", p->phys_start);
>+		DEBUG_MSG("  phys_end   : %llx\n", p->phys_end);
>+		DEBUG_MSG("  virt_start : %llx\n", p->virt_start);
>+		DEBUG_MSG("  virt_end   : %llx\n", p->virt_end);
>+	}
>+
>+	return TRUE;
>+}
>
> /*
>  * Get ELF information about /proc/vmcore.
>diff --git a/elf_info.h b/elf_info.h
>index 3ce0138..ba27fdf 100644
>--- a/elf_info.h
>+++ b/elf_info.h
>@@ -46,6 +46,7 @@ int get_elf_info(int fd, char *filename);
> void free_elf_info(void);
> int get_elf_loads(int fd, char *filename);
> int set_kcore_vmcoreinfo(uint64_t vmcoreinfo_addr, uint64_t vmcoreinfo_len);
>+int get_kcore_dump_loads();
>
> int is_elf64_memory(void);
> int is_xen_memory(void);
>--
>1.8.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
