Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U5vo0-0003Bk-Pv
 for kexec@lists.infradead.org; Thu, 14 Feb 2013 10:12:41 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 339003EE0AE
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:39 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1B39345DD78
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:39 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0433F45DD74
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:39 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id E8849E08001
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:38 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A23E11DB802C
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:38 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 10/13] vmcore: round-up offset of vmcore object in page-size
 boundary
Date: Thu, 14 Feb 2013 19:12:38 +0900
Message-ID: <20130214101238.22466.95192.stgit@localhost6.localdomain6>
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

To satisfy mmap()'s page-size bounary requirement, round-up offset of
each vmcore objects in page-size boundary.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index ccf0dc5..afedb5f 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -517,7 +517,7 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 }
 
 /* Sets offset fields of vmcore elements. */
-static void __init set_vmcore_list_offsets_elf64(char *elfptr,
+static void __init set_vmcore_list_offsets_elf64(char *elfptr, size_t elfsz,
 						struct list_head *vc_list)
 {
 	loff_t vmcore_off;
@@ -527,12 +527,11 @@ static void __init set_vmcore_list_offsets_elf64(char *elfptr,
 	ehdr_ptr = (Elf64_Ehdr *)elfptr;
 
 	/* Skip Elf header and program headers. */
-	vmcore_off = sizeof(Elf64_Ehdr) +
-			(ehdr_ptr->e_phnum) * sizeof(Elf64_Phdr);
+	vmcore_off = elfsz;
 
 	list_for_each_entry(m, vc_list, list) {
 		m->offset = vmcore_off;
-		vmcore_off += m->size;
+		vmcore_off += roundup(m->size, PAGE_SIZE);
 	}
 }
 
@@ -613,7 +612,7 @@ static int __init parse_crash_elf64_headers(void)
 			   get_order(elfcorebuf_sz_orig));
 		return rc;
 	}
-	set_vmcore_list_offsets_elf64(elfcorebuf, &vmcore_list);
+	set_vmcore_list_offsets_elf64(elfcorebuf, elfcorebuf_sz, &vmcore_list);
 	return 0;
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
