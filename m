Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcXf4-0002wp-0I
 for kexec@lists.infradead.org; Wed, 15 May 2013 09:06:15 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 602853EE0AE
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 18:05:47 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4EBB245DE5B
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 18:05:47 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 26BBE45DE55
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 18:05:47 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 048451DB8043
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 18:05:47 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id A9732E38003
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 18:05:46 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v6 1/8] vmcore: clean up read_vmcore()
Date: Wed, 15 May 2013 18:05:45 +0900
Message-ID: <20130515090545.28109.86085.stgit@localhost6.localdomain6>
In-Reply-To: <20130515090507.28109.28956.stgit@localhost6.localdomain6>
References: <20130515090507.28109.28956.stgit@localhost6.localdomain6>
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
Cc: riel@redhat.com, hughd@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, zhangyanfei@cn.fujitsu.com, kosaki.motohiro@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, walken@google.com, cpw@sgi.com, jingbai.ma@hp.com

Rewrite part of read_vmcore() that reads objects in vmcore_list in the
same way as part reading ELF headers, by which some duplicated and
redundant codes are removed.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
---

 fs/proc/vmcore.c |   68 ++++++++++++++++--------------------------------------
 1 files changed, 20 insertions(+), 48 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 17f7e08..ab0c92e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -118,27 +118,6 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
 	return read;
 }
 
-/* Maps vmcore file offset to respective physical address in memroy. */
-static u64 map_offset_to_paddr(loff_t offset, struct list_head *vc_list,
-					struct vmcore **m_ptr)
-{
-	struct vmcore *m;
-	u64 paddr;
-
-	list_for_each_entry(m, vc_list, list) {
-		u64 start, end;
-		start = m->offset;
-		end = m->offset + m->size - 1;
-		if (offset >= start && offset <= end) {
-			paddr = m->paddr + offset - start;
-			*m_ptr = m;
-			return paddr;
-		}
-	}
-	*m_ptr = NULL;
-	return 0;
-}
-
 /* Read from the ELF header and then the crash dump. On error, negative value is
  * returned otherwise number of bytes read are returned.
  */
@@ -147,8 +126,8 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
 {
 	ssize_t acc = 0, tmp;
 	size_t tsz;
-	u64 start, nr_bytes;
-	struct vmcore *curr_m = NULL;
+	u64 start;
+	struct vmcore *m = NULL;
 
 	if (buflen == 0 || *fpos >= vmcore_size)
 		return 0;
@@ -174,33 +153,26 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
 			return acc;
 	}
 
-	start = map_offset_to_paddr(*fpos, &vmcore_list, &curr_m);
-	if (!curr_m)
-        	return -EINVAL;
-
-	while (buflen) {
-		tsz = min_t(size_t, buflen, PAGE_SIZE - (start & ~PAGE_MASK));
-
-		/* Calculate left bytes in current memory segment. */
-		nr_bytes = (curr_m->size - (start - curr_m->paddr));
-		if (tsz > nr_bytes)
-			tsz = nr_bytes;
-
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
+			start = m->paddr + *fpos - m->offset;
+			tmp = read_from_oldmem(buffer, tsz, &start, 1);
+			if (tmp < 0)
+				return tmp;
+			buflen -= tsz;
+			*fpos += tsz;
+			buffer += tsz;
+			acc += tsz;
+
+			/* leave now if filled buffer already */
+			if (buflen == 0)
+				return acc;
 		}
 	}
+
 	return acc;
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
