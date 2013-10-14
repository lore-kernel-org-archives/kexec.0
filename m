Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVeZw-0000Wk-A3
 for kexec@lists.infradead.org; Mon, 14 Oct 2013 09:36:45 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 145E43EE1D6
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:24 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 03A2945DE50
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:24 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id DE98545DE4E
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:23 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D29061DB803C
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:23 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 873491DB8038
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:23 +0900 (JST)
Subject: [PATCH 3/3] procfs: clean up proc_reg_get_unmapped_area for
 80-column limit
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Mon, 14 Oct 2013 18:36:22 +0900
Message-ID: <20131014093622.9801.75614.stgit@localhost6.localdomain6>
In-Reply-To: <20131014093606.9801.11175.stgit@localhost6.localdomain6>
References: <20131014093606.9801.11175.stgit@localhost6.localdomain6>
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
To: akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, davem@davemloft.net, ebiederm@xmission.com, holzheu@linux.vnet.ibm.com, adobriyan@gmail.com, vgoyal@redhat.com

Clean up proc_reg_get_unmapped_area due to its 80-column limit
violation.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 fs/proc/inode.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 8eaa1ba..28955d4 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -285,19 +285,23 @@ static int proc_reg_mmap(struct file *file, struct vm_area_struct *vma)
 	return rv;
 }
 
-static unsigned long proc_reg_get_unmapped_area(struct file *file, unsigned long orig_addr, unsigned long len, unsigned long pgoff, unsigned long flags)
+static unsigned long
+proc_reg_get_unmapped_area(struct file *file, unsigned long orig_addr,
+			   unsigned long len, unsigned long pgoff,
+			   unsigned long flags)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	unsigned long rv = -EIO;
-	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long) = NULL;
+	unsigned long (*get_area)(struct file *, unsigned long, unsigned long,
+				  unsigned long, unsigned long) = NULL;
 	if (use_pde(pde)) {
 #ifdef CONFIG_MMU
-		get_unmapped_area = current->mm->get_unmapped_area;
+		get_area = current->mm->get_unmapped_area;
 #endif
 		if (pde->proc_fops->get_unmapped_area)
-			get_unmapped_area = pde->proc_fops->get_unmapped_area;
-		if (get_unmapped_area)
-			rv = get_unmapped_area(file, orig_addr, len, pgoff, flags);
+			get_area = pde->proc_fops->get_unmapped_area;
+		if (get_area)
+			rv = get_area(file, orig_addr, len, pgoff, flags);
 		unuse_pde(pde);
 	}
 	return rv;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
