Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U5vnk-00033w-He
 for kexec@lists.infradead.org; Thu, 14 Feb 2013 10:12:25 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id E999D3EE0BD
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:22 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id BCB7545DEBA
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:22 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id A53DD45DEB7
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:22 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 973551DB803E
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:22 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 49EABE18002
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:22 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 07/13] vmcore: modify read_vmcore() to read buffer on 2nd
 kernel
Date: Thu, 14 Feb 2013 19:12:21 +0900
Message-ID: <20130214101221.22466.97636.stgit@localhost6.localdomain6>
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

If a given vmcore object has VMCORE_2ND_KERNEL type, target data is in
the buffer on 2nd kernel.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   64 ++++++++++++++++++++++++++----------------------------
 1 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 77e0a0e..4125a65 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -146,8 +146,7 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
 {
 	ssize_t acc = 0, tmp;
 	size_t tsz;
-	u64 start, nr_bytes;
-	struct vmcore *curr_m = NULL;
+	struct vmcore *m;
 
 	if (buflen == 0 || *fpos >= vmcore_size)
 		return 0;
@@ -173,39 +172,38 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
 			return acc;
 	}
 
-	start = map_offset_to_paddr(*fpos, &vmcore_list, &curr_m);
-	if (!curr_m)
-        	return -EINVAL;
-	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
-		tsz = buflen;
-
-	/* Calculate left bytes in current memory segment. */
-	nr_bytes = (curr_m->size - (start - curr_m->paddr));
-	if (tsz > nr_bytes)
-		tsz = nr_bytes;
-
-	while (buflen) {
-		tmp = read_from_oldmem(buffer, tsz, &start, 1);
-		if (tmp < 0)
-			return tmp;
-		buflen -= tsz;
-		*fpos += tsz;
-		buffer += tsz;
-		acc += tsz;
-		if (start >= (curr_m->paddr + curr_m->size)) {
-			if (curr_m->list.next == &vmcore_list)
-				return acc;	/*EOF*/
-			curr_m = list_entry(curr_m->list.next,
-						struct vmcore, list);
-			start = curr_m->paddr;
+	list_for_each_entry(m, &vmcore_list, list) {
+		if (*fpos < m->offset + m->size) {
+			tsz = m->offset + m->size - *fpos;
+			if (buflen < tsz)
+				tsz = buflen;
+			switch (m->type) {
+			case VMCORE_OLD_MEMORY: {
+				u64 paddr = m->paddr + *fpos - m->offset;
+
+				tmp = read_from_oldmem(buffer, tsz, &paddr, 1);
+				if (tmp < 0)
+					return tmp;
+				break;
+			}
+			case VMCORE_2ND_KERNEL:
+				if (copy_to_user(buffer,
+						 m->buf + (*fpos - m->offset),
+						 tsz))
+					return -EFAULT;
+				break;
+			}
+			buflen -= tsz;
+			*fpos += tsz;
+			buffer += tsz;
+			acc += tsz;
+
+			/* leave now if filled buffer already */
+			if (buflen == 0)
+				return acc;
 		}
-		if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
-			tsz = buflen;
-		/* Calculate left bytes in current memory segment. */
-		nr_bytes = (curr_m->size - (start - curr_m->paddr));
-		if (tsz > nr_bytes)
-			tsz = nr_bytes;
 	}
+
 	return acc;
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
