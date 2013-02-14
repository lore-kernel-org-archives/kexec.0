Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U5vnH-0002r4-PC
 for kexec@lists.infradead.org; Thu, 14 Feb 2013 10:11:57 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 2891F3EE0C0
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:11:50 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0F91245DE5B
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:11:50 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id E042F45DE5A
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:11:49 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id CF2521DB8055
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:11:49 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 70DF4E08002
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:11:49 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 01/13] vmcore: allocate buffer for ELF headers on page-size
 alignment
Date: Thu, 14 Feb 2013 19:11:48 +0900
Message-ID: <20130214101148.22466.97735.stgit@localhost6.localdomain6>
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

Allocate buffer for ELF headers on page-size aligned boudary to
satisfy mmap() requirement. For this, __get_free_pages() is used
instead of kmalloc().

Also, later patch will decrease actually used buffer size for ELF
headers, so it's necessary to keep original buffer size and actually
used buffer size separately. elfcorebuf_sz_orig keeps the original one
and elfcorebuf_sz the actually used one.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 0d5071d..85714c3 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -30,6 +30,7 @@ static LIST_HEAD(vmcore_list);
 /* Stores the pointer to the buffer containing kernel elf core headers. */
 static char *elfcorebuf;
 static size_t elfcorebuf_sz;
+static size_t elfcorebuf_sz_orig;
 
 /* Total size of vmcore file. */
 static u64 vmcore_size;
@@ -560,26 +561,31 @@ static int __init parse_crash_elf64_headers(void)
 
 	/* Read in all elf headers. */
 	elfcorebuf_sz = sizeof(Elf64_Ehdr) + ehdr.e_phnum * sizeof(Elf64_Phdr);
-	elfcorebuf = kmalloc(elfcorebuf_sz, GFP_KERNEL);
+	elfcorebuf_sz_orig = elfcorebuf_sz;
+	elfcorebuf = (void *) __get_free_pages(GFP_KERNEL | __GFP_ZERO,
+					       get_order(elfcorebuf_sz));
 	if (!elfcorebuf)
 		return -ENOMEM;
 	addr = elfcorehdr_addr;
 	rc = read_from_oldmem(elfcorebuf, elfcorebuf_sz, &addr, 0);
 	if (rc < 0) {
-		kfree(elfcorebuf);
+		free_pages((unsigned long)elfcorebuf,
+			   get_order(elfcorebuf_sz_orig));
 		return rc;
 	}
 
 	/* Merge all PT_NOTE headers into one. */
 	rc = merge_note_headers_elf64(elfcorebuf, &elfcorebuf_sz, &vmcore_list);
 	if (rc) {
-		kfree(elfcorebuf);
+		free_pages((unsigned long)elfcorebuf,
+			   get_order(elfcorebuf_sz_orig));
 		return rc;
 	}
 	rc = process_ptload_program_headers_elf64(elfcorebuf, elfcorebuf_sz,
 							&vmcore_list);
 	if (rc) {
-		kfree(elfcorebuf);
+		free_pages((unsigned long)elfcorebuf,
+			   get_order(elfcorebuf_sz_orig));
 		return rc;
 	}
 	set_vmcore_list_offsets_elf64(elfcorebuf, &vmcore_list);
@@ -616,26 +622,31 @@ static int __init parse_crash_elf32_headers(void)
 
 	/* Read in all elf headers. */
 	elfcorebuf_sz = sizeof(Elf32_Ehdr) + ehdr.e_phnum * sizeof(Elf32_Phdr);
-	elfcorebuf = kmalloc(elfcorebuf_sz, GFP_KERNEL);
+	elfcorebuf_sz_orig = elfcorebuf_sz;
+	elfcorebuf = (void *) __get_free_pages(GFP_KERNEL | __GFP_ZERO,
+					       get_order(elfcorebuf_sz));
 	if (!elfcorebuf)
 		return -ENOMEM;
 	addr = elfcorehdr_addr;
 	rc = read_from_oldmem(elfcorebuf, elfcorebuf_sz, &addr, 0);
 	if (rc < 0) {
-		kfree(elfcorebuf);
+		free_pages((unsigned long)elfcorebuf,
+			   get_order(elfcorebuf_sz_orig));
 		return rc;
 	}
 
 	/* Merge all PT_NOTE headers into one. */
 	rc = merge_note_headers_elf32(elfcorebuf, &elfcorebuf_sz, &vmcore_list);
 	if (rc) {
-		kfree(elfcorebuf);
+		free_pages((unsigned long)elfcorebuf,
+			   get_order(elfcorebuf_sz_orig));
 		return rc;
 	}
 	rc = process_ptload_program_headers_elf32(elfcorebuf, elfcorebuf_sz,
 								&vmcore_list);
 	if (rc) {
-		kfree(elfcorebuf);
+		free_pages((unsigned long)elfcorebuf,
+			   get_order(elfcorebuf_sz_orig));
 		return rc;
 	}
 	set_vmcore_list_offsets_elf32(elfcorebuf, &vmcore_list);
@@ -719,7 +730,8 @@ void vmcore_cleanup(void)
 		list_del(&m->list);
 		kfree(m);
 	}
-	kfree(elfcorebuf);
+	free_pages((unsigned long)elfcorebuf,
+		   get_order(elfcorebuf_sz_orig));
 	elfcorebuf = NULL;
 }
 EXPORT_SYMBOL_GPL(vmcore_cleanup);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
