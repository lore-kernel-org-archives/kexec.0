Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVeZq-0000Wj-Vt
 for kexec@lists.infradead.org; Mon, 14 Oct 2013 09:36:40 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id B84193EE0BD
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:18 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id A4D6D45DE50
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:18 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8C8CE45DDCF
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:18 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7E9E11DB803C
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:18 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 32BE51DB8038
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:18 +0900 (JST)
Subject: [PATCH 2/3] procfs: Call default get_unmapped_area on MMU-present
 architectures
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Mon, 14 Oct 2013 18:36:17 +0900
Message-ID: <20131014093617.9801.68068.stgit@localhost6.localdomain6>
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

commit c4fe24485729fc2cbff324c111e67a1cc2f9adea added
proc_reg_get_unmapped_area in proc_reg_file_ops and
proc_reg_file_ops_no_compat, by which now mmap always returns EIO if
get_unmapped_area method is not defiend for the target procfs file,
which causes regression of mmap on /proc/vmcore.

To address this issue, like get_unmapped_area(), call default
current->mm->get_unmapped_area on MMU-present architectures if
pde->proc_fops->get_unmapped_area, i.e. the one in actual file
operation in the procfs file, is not defined.

Reported-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/inode.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 6c501c4..8eaa1ba 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -289,9 +289,13 @@ static unsigned long proc_reg_get_unmapped_area(struct file *file, unsigned long
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	unsigned long rv = -EIO;
-	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long) = NULL;
 	if (use_pde(pde)) {
-		get_unmapped_area = pde->proc_fops->get_unmapped_area;
+#ifdef CONFIG_MMU
+		get_unmapped_area = current->mm->get_unmapped_area;
+#endif
+		if (pde->proc_fops->get_unmapped_area)
+			get_unmapped_area = pde->proc_fops->get_unmapped_area;
 		if (get_unmapped_area)
 			rv = get_unmapped_area(file, orig_addr, len, pgoff, flags);
 		unuse_pde(pde);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
