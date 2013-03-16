Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHmL1-00060O-JH
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 02:31:44 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 893373EE0C0
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:40 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6C46345DE59
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:40 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4AEF645DE54
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:40 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3CCE01DB802C
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:40 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D853FE38002
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:39 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v3 18/21] vmcore: check if vmcore objects satify mmap()'s
 page-size boundary requirement
Date: Sat, 16 Mar 2013 13:02:29 +0900
Message-ID: <20130316040228.15064.28019.stgit@localhost6.localdomain6>
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

If there's some vmcore object that doesn't satisfy page-size boundary
requirement, remap_pfn_range() fails to remap it to user-space.

Objects that posisbly don't satisfy the requirement are ELF note
segments only. The memory chunks corresponding to PT_LOAD entries are
guaranteed to satisfy page-size boundary requirement by the copy from
old memory to buffer in 2nd kernel done in later patch.

This patch doesn't copy each note segment into the 2nd kernel since
they amount to so large in total if there are multiple CPUs. For
example, current maximum number of CPUs in x86_64 is 5120, where note
segments exceed 1MB with NT_PRSTATUS only.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 2a0f885..0077a9a 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -38,6 +38,8 @@ static u64 vmcore_size;
 
 static struct proc_dir_entry *proc_vmcore = NULL;
 
+static bool support_mmap_vmcore;
+
 /*
  * Returns > 0 for RAM pages, 0 for non-RAM pages, < 0 on error
  * The called function has to take care of module refcounting.
@@ -911,6 +913,7 @@ static int __init parse_crash_elf_headers(void)
 static int __init vmcore_init(void)
 {
 	int rc = 0;
+	struct vmcore *m;
 
 	/* If elfcorehdr= has been passed in cmdline, then capture the dump.*/
 	if (!(is_vmcore_usable()))
@@ -921,6 +924,25 @@ static int __init vmcore_init(void)
 		return rc;
 	}
 
+	/* If some object doesn't satisfy PAGE_SIZE boundary
+	 * requirement, mmap_vmcore() is not exported to
+	 * user-space. */
+	support_mmap_vmcore = true;
+	list_for_each_entry(m, &vmcore_list, list) {
+		u64 paddr;
+
+		if (m->flag & MEM_TYPE_CURRENT_KERNEL)
+			paddr = (u64)__pa(m->buf);
+		else
+			paddr = m->paddr;
+
+		if ((m->offset & ~PAGE_MASK) || (paddr & ~PAGE_MASK)
+		    || (m->size & ~PAGE_MASK)) {
+			support_mmap_vmcore = false;
+			break;
+		}
+	}
+
 	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &proc_vmcore_operations);
 	if (proc_vmcore)
 		proc_vmcore->size = vmcore_size;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
