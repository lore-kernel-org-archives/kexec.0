Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USlFD-0000BO-3s
 for kexec@lists.infradead.org; Thu, 18 Apr 2013 09:35:07 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 87DA33EE0BC
 for <kexec@lists.infradead.org>; Thu, 18 Apr 2013 18:35:05 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6CA0445DEB6
 for <kexec@lists.infradead.org>; Thu, 18 Apr 2013 18:35:05 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5066445DEB2
 for <kexec@lists.infradead.org>; Thu, 18 Apr 2013 18:35:05 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3E8A41DB803C
 for <kexec@lists.infradead.org>; Thu, 18 Apr 2013 18:35:05 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id DC47D1DB803E
 for <kexec@lists.infradead.org>; Thu, 18 Apr 2013 18:35:04 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v4 5/8] vmcore: copy ELF note segments in the 2nd kernel per
 page vmcore objects
Date: Sat, 13 Apr 2013 09:21:33 +0900
Message-ID: <20130413002133.18245.91528.stgit@localhost6.localdomain6>
In-Reply-To: <20130413002000.18245.21513.stgit@localhost6.localdomain6>
References: <20130413002000.18245.21513.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: vgoyal@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, zhangyanfei@cn.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, cpw@sgi.com, jingbai.ma@hp.com

Copy ELF note segmnets in buffer on the 2nd kernel and the buffer is
allocated on page boundary for the purpose of mmap.

The reason why we don't allocate ELF note segments in the 1st kernel
(old memory) on page boundary is to keep backward compatibility for
old kernels, and one more reason is that if doing so, we waste not a
little memory due to round-up operation to fit the memory to page
boundary since most of the buffers are in per-cpu area.

ELF notes are per-cpu, so total size of ELF note segments increases
according to the number of CPUs. The current maximum number of CPUs on
x86_64 is 5192, and there's already system with 4192 CPUs in SGI,
where total size amounts to 1MB. This can be larger in the neare
futrue or possibly even now on another architecture. Thus, to avoid
the case where memory allocation for large block fails, we allocate
vmcore objects per pages.

Note that we cannot use remap_vmalloc_range here since the vma passed
to it as the first argument needs to cover a full range of memory. We
need to be able to specify where to map in pages, but we cannot do it
by remap_vmalloc_range.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 131d8fa..e27da40 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -200,7 +200,62 @@ static int __init vmcore_add(struct list_head *vc_list, u64 paddr, u64 size)
 	return 0;
 }
 
+struct vmcore_per_unit_state {
+	struct vmcore *last;
+	u64 pos;
+	u64 unit;
+	struct list_head *vc_list;
+};
+
+/*
+ * Assumptions:
+ * - given physical addresses are all exclusive; don't check exclusiveness.
+ */
+static int __init vmcore_add_per_unit(struct vmcore_per_unit_state *state,
+				      u64 paddr, u64 size)
+{
+	u64 offset = paddr, remaining_bytes = size;
+	int rc;
+
+	while (remaining_bytes > 0) {
+		u64 read_bytes;
+
+		BUG_ON(state->pos > state->unit);
+
+		if (!state->last || state->pos == state->unit) {
+			struct vmcore *new;
+
+			new = get_new_element();
+			if (!new)
+				return -ENOMEM;
+			new->flag = MEM_TYPE_CURRENT_KERNEL;
+			new->size = PAGE_SIZE;
+			new->buf = (char *)get_zeroed_page(GFP_KERNEL);
+			if (!new->buf) {
+				kfree(new);
+				return -ENOMEM;
+			}
+			list_add_tail(&new->list, state->vc_list);
+			state->last = new;
+			state->pos = 0;
+		}
+
+		read_bytes = min(remaining_bytes, state->unit - state->pos);
+
+		rc = read_from_oldmem(state->last->buf + state->pos, read_bytes,
+				      &offset, 0);
+		if (rc < 0)
+			return rc;
+
+		state->pos += read_bytes;
+		remaining_bytes -= read_bytes;
+	}
+
+	return 0;
+}
+
 static u64 __init get_vmcore_size_elf64(char *elfptr, size_t elfsz)
+
 {
 	int i;
 	u64 size;
@@ -244,6 +299,12 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 	Elf64_Phdr phdr, *phdr_ptr;
 	Elf64_Nhdr *nhdr_ptr;
 	u64 phdr_sz = 0, note_off;
+	struct vmcore_per_unit_state state = {
+		.last = NULL,
+		.pos = 0,
+		.unit = PAGE_SIZE,
+		.vc_list = vc_list,
+	};
 
 	ehdr_ptr = (Elf64_Ehdr *)elfptr;
 	phdr_ptr = (Elf64_Phdr*)(elfptr + sizeof(Elf64_Ehdr));
@@ -276,7 +337,7 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 		}
 
 		/* Add this contiguous chunk of notes section to vmcore list.*/
-		if (vmcore_add(vc_list, phdr_ptr->p_offset, real_sz)) {
+		if (vmcore_add_per_unit(&state, phdr_ptr->p_offset, real_sz)) {
 			kfree(notes_section);
 			return -ENOMEM;
 		}
@@ -323,6 +384,12 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
 	Elf32_Phdr phdr, *phdr_ptr;
 	Elf32_Nhdr *nhdr_ptr;
 	u64 phdr_sz = 0, note_off;
+	struct vmcore_per_unit_state state = {
+		.last = NULL,
+		.pos = 0,
+		.unit = PAGE_SIZE,
+		.vc_list = vc_list,
+	};
 
 	ehdr_ptr = (Elf32_Ehdr *)elfptr;
 	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr));
@@ -355,7 +422,7 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
 		}
 
 		/* Add this contiguous chunk of notes section to vmcore list.*/
-		if (vmcore_add(vc_list, phdr_ptr->p_offset, real_sz)) {
+		if (vmcore_add_per_unit(&state, phdr_ptr->p_offset, real_sz)) {
 			kfree(notes_section);
 			return -ENOMEM;
 		}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
