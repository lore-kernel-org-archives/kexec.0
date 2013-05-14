Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uc4VI-0002jt-Sa
 for kexec@lists.infradead.org; Tue, 14 May 2013 01:58:14 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id EFEF03EE0BD
 for <kexec@lists.infradead.org>; Tue, 14 May 2013 10:57:47 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id D8AF445DE51
 for <kexec@lists.infradead.org>; Tue, 14 May 2013 10:57:47 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id B93E745DE4E
 for <kexec@lists.infradead.org>; Tue, 14 May 2013 10:57:47 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id A9794E18001
 for <kexec@lists.infradead.org>; Tue, 14 May 2013 10:57:47 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4AF971DB8037
 for <kexec@lists.infradead.org>; Tue, 14 May 2013 10:57:47 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v5 7/8] vmcore: calculate vmcore file size from buffer size
 and total size of vmcore objects
Date: Tue, 14 May 2013 10:57:46 +0900
Message-ID: <20130514015746.18697.1089.stgit@localhost6.localdomain6>
In-Reply-To: <20130514015622.18697.77191.stgit@localhost6.localdomain6>
References: <20130514015622.18697.77191.stgit@localhost6.localdomain6>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, zhangyanfei@cn.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, cpw@sgi.com, jingbai.ma@hp.com

The previous patches newly added holes before each chunk of memory and
the holes need to be count in vmcore file size. There are two ways to
count file size in such a way:

1) supporse p as a poitner to the last program header entry with
PT_LOAD type, then roundup(p->p_offset + p->p_memsz, PAGE_SIZE), or

2) calculate sum of size of buffers for ELF header, program headers,
ELF note segments and objects in vmcore_list.

Although 1) is more direct and simpler than 2), 2) seems better in
that it reflects internal object structure of /proc/vmcore. Thus, this
patch changes get_vmcore_size_elf{64, 32} so that it calculates size
in the way of 2).

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   40 ++++++++++++++++++----------------------
 1 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index eb7ff29..ad6da17 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -210,36 +210,28 @@ static struct vmcore* __init get_new_element(void)
 	return kzalloc(sizeof(struct vmcore), GFP_KERNEL);
 }
 
-static u64 __init get_vmcore_size_elf64(char *elfptr, size_t elfsz)
+static u64 __init get_vmcore_size_elf64(size_t elfsz, size_t elfnotesegsz,
+					struct list_head *vc_list)
 {
-	int i;
 	u64 size;
-	Elf64_Ehdr *ehdr_ptr;
-	Elf64_Phdr *phdr_ptr;
+	struct vmcore *m;
 
-	ehdr_ptr = (Elf64_Ehdr *)elfptr;
-	phdr_ptr = (Elf64_Phdr*)(elfptr + sizeof(Elf64_Ehdr));
-	size = elfsz;
-	for (i = 0; i < ehdr_ptr->e_phnum; i++) {
-		size += phdr_ptr->p_memsz;
-		phdr_ptr++;
+	size = elfsz + elfnotesegsz;
+	list_for_each_entry(m, vc_list, list) {
+		size += m->size;
 	}
 	return size;
 }
 
-static u64 __init get_vmcore_size_elf32(char *elfptr, size_t elfsz)
+static u64 __init get_vmcore_size_elf32(size_t elfsz, size_t elfnotesegsz,
+					struct list_head *vc_list)
 {
-	int i;
 	u64 size;
-	Elf32_Ehdr *ehdr_ptr;
-	Elf32_Phdr *phdr_ptr;
+	struct vmcore *m;
 
-	ehdr_ptr = (Elf32_Ehdr *)elfptr;
-	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr));
-	size = elfsz;
-	for (i = 0; i < ehdr_ptr->e_phnum; i++) {
-		size += phdr_ptr->p_memsz;
-		phdr_ptr++;
+	size = elfsz + elfnotesegsz;
+	list_for_each_entry(m, vc_list, list) {
+		size += m->size;
 	}
 	return size;
 }
@@ -755,14 +747,18 @@ static int __init parse_crash_elf_headers(void)
 			return rc;
 
 		/* Determine vmcore size. */
-		vmcore_size = get_vmcore_size_elf64(elfcorebuf, elfcorebuf_sz);
+		vmcore_size = get_vmcore_size_elf64(elfcorebuf_sz,
+						    elfnotesegbuf_sz,
+						    &vmcore_list);
 	} else if (e_ident[EI_CLASS] == ELFCLASS32) {
 		rc = parse_crash_elf32_headers();
 		if (rc)
 			return rc;
 
 		/* Determine vmcore size. */
-		vmcore_size = get_vmcore_size_elf32(elfcorebuf, elfcorebuf_sz);
+		vmcore_size = get_vmcore_size_elf32(elfcorebuf_sz,
+						    elfnotesegbuf_sz,
+						    &vmcore_list);
 	} else {
 		pr_warn("Warning: Core image elf header is not sane\n");
 		return -EINVAL;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
