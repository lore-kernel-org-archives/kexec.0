Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USlF6-0000A9-FZ
 for kexec@lists.infradead.org; Thu, 18 Apr 2013 09:35:02 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id E35193EE081
 for <kexec@lists.infradead.org>; Thu, 18 Apr 2013 18:34:58 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id C718645DEB7
 for <kexec@lists.infradead.org>; Thu, 18 Apr 2013 18:34:58 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id AEB3445DEB5
 for <kexec@lists.infradead.org>; Thu, 18 Apr 2013 18:34:58 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id A27791DB8040
 for <kexec@lists.infradead.org>; Thu, 18 Apr 2013 18:34:58 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 48B2B1DB803B
 for <kexec@lists.infradead.org>; Thu, 18 Apr 2013 18:34:58 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v4 4/8] vmcore: Add helper function vmcore_add()
Date: Sat, 13 Apr 2013 09:21:28 +0900
Message-ID: <20130413002128.18245.77348.stgit@localhost6.localdomain6>
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

Later patch will introduce a helper function, vmcore_add_per_unit, to
add memory chunks per a given size in vmcore_list. As a preparation
this patch introduces a helper function that adds a given memory chunk
in vmcore_list in a simple manner.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   44 ++++++++++++++++++++------------------------
 1 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 7e7c7ca..131d8fa 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -186,6 +186,20 @@ static struct vmcore* __init get_new_element(void)
 	return kzalloc(sizeof(struct vmcore), GFP_KERNEL);
 }
 
+static int __init vmcore_add(struct list_head *vc_list, u64 paddr, u64 size)
+{
+	struct vmcore *new;
+
+	new = get_new_element();
+	if (!new)
+		return -ENOMEM;
+	new->paddr = paddr;
+	new->size = size;
+	list_add_tail(&new->list, vc_list);
+
+	return 0;
+}
+
 static u64 __init get_vmcore_size_elf64(char *elfptr, size_t elfsz)
 {
 	int i;
@@ -236,7 +250,6 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
 		int j;
 		void *notes_section;
-		struct vmcore *new;
 		u64 offset, max_sz, sz, real_sz = 0;
 		if (phdr_ptr->p_type != PT_NOTE)
 			continue;
@@ -263,14 +276,11 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 		}
 
 		/* Add this contiguous chunk of notes section to vmcore list.*/
-		new = get_new_element();
-		if (!new) {
+		if (vmcore_add(vc_list, phdr_ptr->p_offset, real_sz)) {
 			kfree(notes_section);
 			return -ENOMEM;
 		}
-		new->paddr = phdr_ptr->p_offset;
-		new->size = real_sz;
-		list_add_tail(&new->list, vc_list);
+
 		phdr_sz += real_sz;
 		kfree(notes_section);
 	}
@@ -319,7 +329,6 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
 	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
 		int j;
 		void *notes_section;
-		struct vmcore *new;
 		u64 offset, max_sz, sz, real_sz = 0;
 		if (phdr_ptr->p_type != PT_NOTE)
 			continue;
@@ -346,14 +355,11 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
 		}
 
 		/* Add this contiguous chunk of notes section to vmcore list.*/
-		new = get_new_element();
-		if (!new) {
+		if (vmcore_add(vc_list, phdr_ptr->p_offset, real_sz)) {
 			kfree(notes_section);
 			return -ENOMEM;
 		}
-		new->paddr = phdr_ptr->p_offset;
-		new->size = real_sz;
-		list_add_tail(&new->list, vc_list);
+
 		phdr_sz += real_sz;
 		kfree(notes_section);
 	}
@@ -396,7 +402,6 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 	Elf64_Ehdr *ehdr_ptr;
 	Elf64_Phdr *phdr_ptr;
 	loff_t vmcore_off;
-	struct vmcore *new;
 
 	ehdr_ptr = (Elf64_Ehdr *)elfptr;
 	phdr_ptr = (Elf64_Phdr*)(elfptr + sizeof(Elf64_Ehdr)); /* PT_NOTE hdr */
@@ -409,12 +414,8 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 			continue;
 
 		/* Add this contiguous chunk of memory to vmcore list.*/
-		new = get_new_element();
-		if (!new)
+		if (vmcore_add(vc_list, phdr_ptr->p_offset, phdr_ptr->p_memsz))
 			return -ENOMEM;
-		new->paddr = phdr_ptr->p_offset;
-		new->size = phdr_ptr->p_memsz;
-		list_add_tail(&new->list, vc_list);
 
 		/* Update the program header offset. */
 		phdr_ptr->p_offset = vmcore_off;
@@ -431,7 +432,6 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 	Elf32_Ehdr *ehdr_ptr;
 	Elf32_Phdr *phdr_ptr;
 	loff_t vmcore_off;
-	struct vmcore *new;
 
 	ehdr_ptr = (Elf32_Ehdr *)elfptr;
 	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr)); /* PT_NOTE hdr */
@@ -444,12 +444,8 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 			continue;
 
 		/* Add this contiguous chunk of memory to vmcore list.*/
-		new = get_new_element();
-		if (!new)
+		if (vmcore_add(vc_list, phdr_ptr->p_offset, phdr_ptr->p_memsz))
 			return -ENOMEM;
-		new->paddr = phdr_ptr->p_offset;
-		new->size = phdr_ptr->p_memsz;
-		list_add_tail(&new->list, vc_list);
 
 		/* Update the program header offset */
 		phdr_ptr->p_offset = vmcore_off;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
