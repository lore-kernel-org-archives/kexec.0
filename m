Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V1epA-0007AR-9K
 for kexec@lists.infradead.org; Tue, 23 Jul 2013 15:48:30 +0000
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Tue, 23 Jul 2013 16:42:28 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id C41FF2190063
 for <kexec@lists.infradead.org>; Tue, 23 Jul 2013 16:52:08 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6NFlnYp35061862
 for <kexec@lists.infradead.org>; Tue, 23 Jul 2013 15:47:49 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r6NFm0Ma021199
 for <kexec@lists.infradead.org>; Tue, 23 Jul 2013 09:48:00 -0600
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH v8 5/6] vmcore: Enable /proc/vmcore mmap for s390
Date: Tue, 23 Jul 2013 17:47:58 +0200
Message-Id: <1374594479-64671-6-git-send-email-holzheu@linux.vnet.ibm.com>
In-Reply-To: <1374594479-64671-1-git-send-email-holzheu@linux.vnet.ibm.com>
References: <1374594479-64671-1-git-send-email-holzheu@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

The patch "s390/vmcore: Implement remap_oldmem_pfn_range for s390" allows
now to use mmap also on s390.

So enable mmap for s390 again.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 fs/proc/vmcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 3f6cf0e..532808e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -327,7 +327,7 @@ static inline char *alloc_elfnotes_buf(size_t notes_sz)
  * regions in the 1st kernel pointed to by PT_LOAD entries) into
  * virtually contiguous user-space in ELF layout.
  */
-#if defined(CONFIG_MMU) && !defined(CONFIG_S390)
+#ifdef CONFIG_MMU
 static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 {
 	size_t size = vma->vm_end - vma->vm_start;
-- 
1.8.2.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
