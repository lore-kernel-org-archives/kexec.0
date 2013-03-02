Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UClxK-00074O-A3
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 07:06:35 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 998323EE0C1
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:06:32 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6C5402AEA89
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:06:32 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4E10745DE59
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:06:32 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 39257E08005
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:06:32 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id E18E51DB804F
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:06:31 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 17/20] vmcore: check if vmcore objects satify mmap()'s
 page-size boundary requirement
Date: Sat, 02 Mar 2013 17:37:25 +0900
Message-ID: <20130302083725.31252.54610.stgit@localhost6.localdomain6>
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

If there's some vmcore object that doesn't satisfy page-size boundary
requirement, remap_pfn_range() fails to remap it to user-space.

Objects that posisbly don't satisfy the requirement are ELF note
segments only. The memory chunks corresponding to PT_LOAD entries are
guaranteed to satisfy page-size boundary requirement by the copy from
old memory to buffer in 2nd kernel done in later patch.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index e432946..5582aaa 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -38,6 +38,8 @@ static u64 vmcore_size;
 
 static struct proc_dir_entry *proc_vmcore = NULL;
 
+static bool support_mmap_vmcore;
+
 /*
  * Returns > 0 for RAM pages, 0 for non-RAM pages, < 0 on error
  * The called function has to take care of module refcounting.
@@ -897,6 +899,7 @@ static int __init parse_crash_elf_headers(void)
 static int __init vmcore_init(void)
 {
 	int rc = 0;
+	struct vmcore *m;
 
 	/* If elfcorehdr= has been passed in cmdline, then capture the dump.*/
 	if (!(is_vmcore_usable()))
@@ -907,6 +910,25 @@ static int __init vmcore_init(void)
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
