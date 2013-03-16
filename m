Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHmJW-00054l-4V
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 02:30:13 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 0ACD43EE0C5
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:07 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id C304345DD73
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:06 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 09B1845DE53
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:05 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id E8A25E38002
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:04 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 87243E08002
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:30:04 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v3 01/21] vmcore: reference e_phoff member explicitly to get
 position of program header table
Date: Sat, 16 Mar 2013 13:00:53 +0900
Message-ID: <20130316040053.15064.93652.stgit@localhost6.localdomain6>
In-Reply-To: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
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
Cc: zhangyanfei@cn.fujitsu.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Currently, the code assumes that position of program header table is
next to ELF header. But future change can break the assumption on
kexec-tools and the 1st kernel. To avoid worst case, reference e_phoff
member explicitly to get position of program header table in
file-offset.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   56 +++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index b870f74..163281e 100644
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
@@ -558,11 +558,19 @@ static int __init parse_crash_elf64_headers(void)
 	if (!elfcorebuf)
 		return -ENOMEM;
 	addr = elfcorehdr_addr;
-	rc = read_from_oldmem(elfcorebuf, elfcorebuf_sz, &addr, 0);
+	rc = read_from_oldmem(elfcorebuf, sizeof(Elf64_Ehdr), &addr, 0);
 	if (rc < 0) {
 		kfree(elfcorebuf);
 		return rc;
 	}
+	addr = elfcorehdr_addr + ehdr.e_phoff;
+	rc = read_from_oldmem(elfcorebuf + sizeof(Elf64_Ehdr),
+			      ehdr.e_phnum * sizeof(Elf64_Phdr), &addr, 0);
+	if (rc < 0) {
+		kfree(elfcorebuf);
+		return rc;
+	}
+	((Elf64_Ehdr *)elfcorebuf)->e_phoff = sizeof(Elf64_Ehdr);
 
 	/* Merge all PT_NOTE headers into one. */
 	rc = merge_note_headers_elf64(elfcorebuf, &elfcorebuf_sz, &vmcore_list);
@@ -613,11 +621,19 @@ static int __init parse_crash_elf32_headers(void)
 	if (!elfcorebuf)
 		return -ENOMEM;
 	addr = elfcorehdr_addr;
-	rc = read_from_oldmem(elfcorebuf, elfcorebuf_sz, &addr, 0);
+	rc = read_from_oldmem(elfcorebuf, sizeof(Elf32_Ehdr), &addr, 0);
+	if (rc < 0) {
+		kfree(elfcorebuf);
+		return rc;
+	}
+	addr = elfcorehdr_addr + ehdr.e_phoff;
+	rc = read_from_oldmem(elfcorebuf + sizeof(Elf32_Ehdr),
+			      ehdr.e_phnum * sizeof(Elf32_Phdr), &addr, 0);
 	if (rc < 0) {
 		kfree(elfcorebuf);
 		return rc;
 	}
+	((Elf32_Ehdr *)elfcorebuf)->e_phoff = sizeof(Elf32_Ehdr);
 
 	/* Merge all PT_NOTE headers into one. */
 	rc = merge_note_headers_elf32(elfcorebuf, &elfcorebuf_sz, &vmcore_list);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
