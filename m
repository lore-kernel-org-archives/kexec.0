Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UClvt-0006bo-Tb
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 07:05:07 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 3EF9C3EE0C8
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:01 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 18DA545DE4E
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:01 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id F399445DD6C
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:00 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 85D601DB803E
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:00 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 337091DB803A
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:00 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 01/20] vmcore: refer to e_phoff member explicitly
Date: Sat, 02 Mar 2013 17:35:54 +0900
Message-ID: <20130302083554.31252.30615.stgit@localhost6.localdomain6>
In-Reply-To: <20130302083447.31252.93914.stgit@localhost6.localdomain6>
References: <20130302083447.31252.93914.stgit@localhost6.localdomain6>
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
To: vgoyal@redhat.com, ebiederm@xmission.com, cpw@sgi.com, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com, heiko.carstens@de.ibm.com, akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Code around /proc/vmcore currently assumes program header table is
next to ELF header. But future change can break the assumption on
kexec-tools and the 1st kernel. To avoid worst case, now refer to
e_phoff member that indicates position of program header table in
file-offset.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index b870f74..abf4f01 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -221,8 +221,8 @@ static u64 __init get_vmcore_size_elf64(char *elfptr)
 	Elf64_Phdr *phdr_ptr;
 
 	ehdr_ptr = (Elf64_Ehdr *)elfptr;
-	phdr_ptr = (Elf64_Phdr*)(elfptr + sizeof(Elf64_Ehdr));
-	size = sizeof(Elf64_Ehdr) + ((ehdr_ptr->e_phnum) * sizeof(Elf64_Phdr));
+	phdr_ptr = (Elf64_Phdr*)(elfptr + ehdr_ptr->e_phoff);
+	size = ehdr_ptr->e_phoff + ((ehdr_ptr->e_phnum) * sizeof(Elf64_Phdr));
 	for (i = 0; i < ehdr_ptr->e_phnum; i++) {
 		size += phdr_ptr->p_memsz;
 		phdr_ptr++;
@@ -238,8 +238,8 @@ static u64 __init get_vmcore_size_elf32(char *elfptr)
 	Elf32_Phdr *phdr_ptr;
 
 	ehdr_ptr = (Elf32_Ehdr *)elfptr;
-	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr));
-	size = sizeof(Elf32_Ehdr) + ((ehdr_ptr->e_phnum) * sizeof(Elf32_Phdr));
+	phdr_ptr = (Elf32_Phdr*)(elfptr + ehdr_ptr->e_phoff);
+	size = ehdr_ptr->e_phoff + ((ehdr_ptr->e_phnum) * sizeof(Elf32_Phdr));
 	for (i = 0; i < ehdr_ptr->e_phnum; i++) {
 		size += phdr_ptr->p_memsz;
 		phdr_ptr++;
@@ -259,7 +259,7 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 	u64 phdr_sz = 0, note_off;
 
 	ehdr_ptr = (Elf64_Ehdr *)elfptr;
-	phdr_ptr = (Elf64_Phdr*)(elfptr + sizeof(Elf64_Ehdr));
+	phdr_ptr = (Elf64_Phdr*)(elfptr + ehdr_ptr->e_phoff);
 	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
 		int j;
 		void *notes_section;
@@ -305,7 +305,7 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 	/* Prepare merged PT_NOTE program header. */
 	phdr.p_type    = PT_NOTE;
 	phdr.p_flags   = 0;
-	note_off = sizeof(Elf64_Ehdr) +
+	note_off = ehdr_ptr->e_phoff +
 			(ehdr_ptr->e_phnum - nr_ptnote +1) * sizeof(Elf64_Phdr);
 	phdr.p_offset  = note_off;
 	phdr.p_vaddr   = phdr.p_paddr = 0;
@@ -313,14 +313,14 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 	phdr.p_align   = 0;
 
 	/* Add merged PT_NOTE program header*/
-	tmp = elfptr + sizeof(Elf64_Ehdr);
+	tmp = elfptr + ehdr_ptr->e_phoff;
 	memcpy(tmp, &phdr, sizeof(phdr));
 	tmp += sizeof(phdr);
 
 	/* Remove unwanted PT_NOTE program headers. */
 	i = (nr_ptnote - 1) * sizeof(Elf64_Phdr);
 	*elfsz = *elfsz - i;
-	memmove(tmp, tmp+i, ((*elfsz)-sizeof(Elf64_Ehdr)-sizeof(Elf64_Phdr)));
+	memmove(tmp, tmp+i, ((*elfsz)-ehdr_ptr->e_phoff-sizeof(Elf64_Phdr)));
 
 	/* Modify e_phnum to reflect merged headers. */
 	ehdr_ptr->e_phnum = ehdr_ptr->e_phnum - nr_ptnote + 1;
@@ -340,7 +340,7 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
 	u64 phdr_sz = 0, note_off;
 
 	ehdr_ptr = (Elf32_Ehdr *)elfptr;
-	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr));
+	phdr_ptr = (Elf32_Phdr*)(elfptr + ehdr_ptr->e_phoff);
 	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
 		int j;
 		void *notes_section;
@@ -386,7 +386,7 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
 	/* Prepare merged PT_NOTE program header. */
 	phdr.p_type    = PT_NOTE;
 	phdr.p_flags   = 0;
-	note_off = sizeof(Elf32_Ehdr) +
+	note_off = ehdr_ptr->e_phoff +
 			(ehdr_ptr->e_phnum - nr_ptnote +1) * sizeof(Elf32_Phdr);
 	phdr.p_offset  = note_off;
 	phdr.p_vaddr   = phdr.p_paddr = 0;
@@ -394,14 +394,14 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
 	phdr.p_align   = 0;
 
 	/* Add merged PT_NOTE program header*/
-	tmp = elfptr + sizeof(Elf32_Ehdr);
+	tmp = elfptr + ehdr_ptr->e_phoff;
 	memcpy(tmp, &phdr, sizeof(phdr));
 	tmp += sizeof(phdr);
 
 	/* Remove unwanted PT_NOTE program headers. */
 	i = (nr_ptnote - 1) * sizeof(Elf32_Phdr);
 	*elfsz = *elfsz - i;
-	memmove(tmp, tmp+i, ((*elfsz)-sizeof(Elf32_Ehdr)-sizeof(Elf32_Phdr)));
+	memmove(tmp, tmp+i, ((*elfsz)-ehdr_ptr->e_phoff-sizeof(Elf32_Phdr)));
 
 	/* Modify e_phnum to reflect merged headers. */
 	ehdr_ptr->e_phnum = ehdr_ptr->e_phnum - nr_ptnote + 1;
@@ -422,10 +422,10 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 	struct vmcore *new;
 
 	ehdr_ptr = (Elf64_Ehdr *)elfptr;
-	phdr_ptr = (Elf64_Phdr*)(elfptr + sizeof(Elf64_Ehdr)); /* PT_NOTE hdr */
+	phdr_ptr = (Elf64_Phdr*)(elfptr + ehdr_ptr->e_phoff); /* PT_NOTE hdr */
 
 	/* First program header is PT_NOTE header. */
-	vmcore_off = sizeof(Elf64_Ehdr) +
+	vmcore_off = ehdr_ptr->e_phoff +
 			(ehdr_ptr->e_phnum) * sizeof(Elf64_Phdr) +
 			phdr_ptr->p_memsz; /* Note sections */
 
@@ -459,10 +459,10 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 	struct vmcore *new;
 
 	ehdr_ptr = (Elf32_Ehdr *)elfptr;
-	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr)); /* PT_NOTE hdr */
+	phdr_ptr = (Elf32_Phdr*)(elfptr + ehdr_ptr->e_phoff); /* PT_NOTE hdr */
 
 	/* First program header is PT_NOTE header. */
-	vmcore_off = sizeof(Elf32_Ehdr) +
+	vmcore_off = ehdr_ptr->e_phoff +
 			(ehdr_ptr->e_phnum) * sizeof(Elf32_Phdr) +
 			phdr_ptr->p_memsz; /* Note sections */
 
@@ -496,7 +496,7 @@ static void __init set_vmcore_list_offsets_elf64(char *elfptr,
 	ehdr_ptr = (Elf64_Ehdr *)elfptr;
 
 	/* Skip Elf header and program headers. */
-	vmcore_off = sizeof(Elf64_Ehdr) +
+	vmcore_off = ehdr_ptr->e_phoff +
 			(ehdr_ptr->e_phnum) * sizeof(Elf64_Phdr);
 
 	list_for_each_entry(m, vc_list, list) {
@@ -516,7 +516,7 @@ static void __init set_vmcore_list_offsets_elf32(char *elfptr,
 	ehdr_ptr = (Elf32_Ehdr *)elfptr;
 
 	/* Skip Elf header and program headers. */
-	vmcore_off = sizeof(Elf32_Ehdr) +
+	vmcore_off = ehdr_ptr->e_phoff +
 			(ehdr_ptr->e_phnum) * sizeof(Elf32_Phdr);
 
 	list_for_each_entry(m, vc_list, list) {
@@ -553,7 +553,7 @@ static int __init parse_crash_elf64_headers(void)
 	}
 
 	/* Read in all elf headers. */
-	elfcorebuf_sz = sizeof(Elf64_Ehdr) + ehdr.e_phnum * sizeof(Elf64_Phdr);
+	elfcorebuf_sz = ehdr.e_phoff + ehdr.e_phnum * sizeof(Elf64_Phdr);
 	elfcorebuf = kmalloc(elfcorebuf_sz, GFP_KERNEL);
 	if (!elfcorebuf)
 		return -ENOMEM;
@@ -608,7 +608,7 @@ static int __init parse_crash_elf32_headers(void)
 	}
 
 	/* Read in all elf headers. */
-	elfcorebuf_sz = sizeof(Elf32_Ehdr) + ehdr.e_phnum * sizeof(Elf32_Phdr);
+	elfcorebuf_sz = ehdr.e_phoff + ehdr.e_phnum * sizeof(Elf32_Phdr);
 	elfcorebuf = kmalloc(elfcorebuf_sz, GFP_KERNEL);
 	if (!elfcorebuf)
 		return -ENOMEM;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
