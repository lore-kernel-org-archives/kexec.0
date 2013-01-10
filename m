Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tvdtw-0002bf-Hx
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 01:04:17 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id EF2063EE0BC
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 10:04:14 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D1F6C45DEBC
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 10:04:14 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id ADCB545DEB2
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 10:04:14 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 9FC881DB8041
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 10:04:14 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 571311DB8038
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 10:04:14 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [RFC PATCH v1 3/3] vmcore: read vmcore through direct mapping region
Date: Thu, 10 Jan 2013 20:59:51 +0900
Message-ID: <20130110115951.645.20633.stgit@localhost6.localdomain6>
In-Reply-To: <20130110115615.645.56499.stgit@localhost6.localdomain6>
References: <20130110115615.645.56499.stgit@localhost6.localdomain6>
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

Now regions represented by vmcore are mapped through direct mapping
region. We reads requested memory through direct mapping region
instead of using ioremap.

Notice that we still keep read_from_oldmem that uses ioremap because
we need to use it when reading elf headers to make vmcore_list in
vmcore initialization.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index aa14570..1c6259e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -123,6 +123,49 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
 	return read;
 }
 
+/* Reads a page from the oldmem device from given offset. */
+static ssize_t read_from_oldmem_noioremap(char *buf, size_t count,
+					  u64 *ppos, int userbuf)
+{
+        unsigned long pfn, offset;
+        size_t nr_bytes;
+        ssize_t read = 0;
+
+        if (!count)
+                return 0;
+
+        offset = (unsigned long)(*ppos % PAGE_SIZE);
+        pfn = (unsigned long)(*ppos / PAGE_SIZE);
+
+        do {
+                if (count > (PAGE_SIZE - offset))
+                        nr_bytes = PAGE_SIZE - offset;
+                else
+                        nr_bytes = count;
+
+                /* If pfn is not ram, return zeros for sparse dump files */
+                if (pfn_is_ram(pfn) == 0)
+                        memset(buf, 0, nr_bytes);
+                else {
+                        void *vaddr = pfn_to_kaddr(pfn);
+
+                        if (userbuf) {
+                                if (copy_to_user(buf, vaddr + offset, nr_bytes))
+                                        return -EFAULT;
+                        } else
+                                memcpy(buf, vaddr + offset, nr_bytes);
+                }
+                *ppos += nr_bytes;
+                count -= nr_bytes;
+                buf += nr_bytes;
+                read += nr_bytes;
+                ++pfn;
+                offset = 0;
+        } while (count);
+
+        return read;
+}
+
 /* Maps vmcore file offset to respective physical address in memroy. */
 static u64 map_offset_to_paddr(loff_t offset, struct list_head *vc_list,
 					struct vmcore **m_ptr)
@@ -553,7 +596,7 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
 		tsz = nr_bytes;
 
 	while (buflen) {
-		tmp = read_from_oldmem(buffer, tsz, &start, 1);
+		tmp = read_from_oldmem_noioremap(buffer, tsz, &start, 1);
 		if (tmp < 0)
 			return tmp;
 		buflen -= tsz;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
