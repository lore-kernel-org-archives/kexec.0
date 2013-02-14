Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U5vnv-00038n-GS
 for kexec@lists.infradead.org; Thu, 14 Feb 2013 10:12:37 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id DCC5B3EE0C1
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:33 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id BE53A45DD74
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:33 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id A58B845DE50
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:33 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9774AE08005
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:33 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3EE271DB8038
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:33 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 09/13] vmcore: copy ELF note segments in buffer on 2nd kernel
Date: Thu, 14 Feb 2013 19:12:32 +0900
Message-ID: <20130214101232.22466.44026.stgit@localhost6.localdomain6>
In-Reply-To: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ebiederm@xmission.com, vgoyal@redhat.com, cpw@sgi.com, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Objects exported from ELF note segments are in fact located apart from
each other on old memory. But on /proc/vmcore they are exported as a
single ELF note segment. To satisfy mmap()'s page-size boundary
requirement, copy them in a page-size aligned buffer allocated by
__get_free_pages() on 2nd kernel and remap the buffer to user-space.

The buffer for ELF note segments is added to vmcore_list as the object
of VMCORE_2ND_KERNEL type.

Copy of ELF note segments is done in two pass: first pass tries to
calculate real total size of ELF note segments, and then 2nd pass
copies the segment data into the buffer of the real total size.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   78 +++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 3aedb52..ccf0dc5 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -230,27 +230,25 @@ static u64 __init get_vmcore_size_elf32(char *elfptr)
 	return size;
 }
 
-/* Merges all the PT_NOTE headers into one. */
-static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
-						struct list_head *vc_list)
+static int __init parse_note_segments_elf64(char *elfptr, int *nr_ptnote,
+					    u64 *phdr_sz, char *notebuf)
 {
-	int i, nr_ptnote=0, rc=0;
-	char *tmp;
+	int i, rc=0;
+	loff_t notebuf_off = 0;
 	Elf64_Ehdr *ehdr_ptr;
-	Elf64_Phdr phdr, *phdr_ptr;
 	Elf64_Nhdr *nhdr_ptr;
-	u64 phdr_sz = 0, note_off;
+	Elf64_Phdr *phdr_ptr;
 
 	ehdr_ptr = (Elf64_Ehdr *)elfptr;
 	phdr_ptr = (Elf64_Phdr*)(elfptr + sizeof(Elf64_Ehdr));
 	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
 		int j;
 		void *notes_section;
-		struct vmcore *new;
 		u64 offset, max_sz, sz, real_sz = 0;
 		if (phdr_ptr->p_type != PT_NOTE)
 			continue;
-		nr_ptnote++;
+		if (nr_ptnote)
+			*nr_ptnote = *nr_ptnote + 1;
 		max_sz = phdr_ptr->p_memsz;
 		offset = phdr_ptr->p_offset;
 		notes_section = kmalloc(max_sz, GFP_KERNEL);
@@ -271,20 +269,51 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 			real_sz += sz;
 			nhdr_ptr = (Elf64_Nhdr*)((char*)nhdr_ptr + sz);
 		}
-
-		/* Add this contiguous chunk of notes section to vmcore list.*/
-		new = get_new_element();
-		if (!new) {
-			kfree(notes_section);
-			return -ENOMEM;
+		if (phdr_sz)
+			*phdr_sz += real_sz;
+		if (notebuf) {
+			memcpy(notebuf + notebuf_off, notes_section, real_sz);
+			notebuf_off += real_sz;
 		}
-		new->paddr = phdr_ptr->p_offset;
-		new->size = real_sz;
-		list_add_tail(&new->list, vc_list);
-		phdr_sz += real_sz;
 		kfree(notes_section);
 	}
 
+	return 0;
+}
+
+/* Merges all the PT_NOTE headers into one. */
+static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
+						struct list_head *vc_list)
+{
+	int i, nr_ptnote, rc=0;
+	char *tmp, *notebuf;
+	Elf64_Ehdr *ehdr_ptr;
+	Elf64_Phdr phdr;
+	u64 phdr_sz, note_off, notebuf_sz;
+	struct vmcore *new;
+
+	ehdr_ptr = (Elf64_Ehdr *)elfptr;
+
+	/* The 1st pass calculates real size of ELF note segments. */
+	nr_ptnote = 0;
+	phdr_sz = 0;
+	rc = parse_note_segments_elf64(elfptr, &nr_ptnote, &phdr_sz, NULL);
+	if (rc < 0)
+		return rc;
+
+	/* The 2nd pass copies the ELF note segments into the buffer
+	 * of the exact size. */
+	notebuf_sz = roundup(phdr_sz, PAGE_SIZE);
+	notebuf = (char *) __get_free_pages(GFP_KERNEL | __GFP_ZERO,
+					    get_order(notebuf_sz));
+	if (!notebuf)
+		return -ENOMEM;
+	rc = parse_note_segments_elf64(elfptr, NULL, NULL, notebuf);
+	if (rc < 0) {
+		free_pages((unsigned long)notebuf, get_order(notebuf_sz));
+		return rc;
+	}
+
 	/* Prepare merged PT_NOTE program header. */
 	phdr.p_type    = PT_NOTE;
 	phdr.p_flags   = 0;
@@ -315,6 +344,17 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 
 	*elfsz = roundup(*elfsz, PAGE_SIZE);
 
+	/* Add the merged unique ELF note segments in vmcore_list. */
+	new = get_new_element();
+	if (!new) {
+		free_pages((unsigned long)notebuf, get_order(notebuf_sz));
+		return -ENOMEM;
+	}
+	new->type = VMCORE_2ND_KERNEL;
+	new->buf = notebuf;
+	new->size = notebuf_sz;
+	list_add_tail(&new->list, vc_list);
+
 	return 0;
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
