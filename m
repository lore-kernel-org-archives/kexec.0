Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVeZq-0000Wi-Vs
 for kexec@lists.infradead.org; Mon, 14 Oct 2013 09:36:40 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 2BB173EE0AE
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:13 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1C27A45DE63
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:13 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0246445DE55
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:13 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id EA5111DB8050
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:12 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9FD341DB804C
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:12 +0900 (JST)
Subject: [PATCH 1/3] procfs: fix unintended truncation of returned mapped
 address
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Mon, 14 Oct 2013 18:36:12 +0900
Message-ID: <20131014093611.9801.26658.stgit@localhost6.localdomain6>
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

Currently, proc_reg_get_unmapped_area truncates upper 32-bit of the
mapped virtual address returned from get_unmapped_area method in
pde->proc_fops due to the variable rv of signed integer on
x86_64. This is too small to have vitual address of unsigned long on
x86_64 since on x86_64, signed integer is of 4 bytes while unsigned
long is of 8 bytes. To fix this issue, use unsigned long instead.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 fs/proc/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 9f8ef9b..6c501c4 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -288,7 +288,7 @@ static int proc_reg_mmap(struct file *file, struct vm_area_struct *vma)
 static unsigned long proc_reg_get_unmapped_area(struct file *file, unsigned long orig_addr, unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
-	int rv = -EIO;
+	unsigned long rv = -EIO;
 	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 	if (use_pde(pde)) {
 		get_unmapped_area = pde->proc_fops->get_unmapped_area;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
