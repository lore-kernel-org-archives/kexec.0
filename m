Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UClwh-0006qR-2R
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 07:05:56 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 845D03EE0B6
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:52 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 144032C6FD7
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:51 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id EDB6645DE51
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:50 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id DE78E1DB8043
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:50 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7F4871DB803F
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 16:05:50 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 10/20] vmcore: read buffers for vmcore objects copied from
 old memory
Date: Sat, 02 Mar 2013 17:36:44 +0900
Message-ID: <20130302083644.31252.31560.stgit@localhost6.localdomain6>
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

If flag MEM_TYPE_CURRENT_KERNEL is set, the object is copied in the
buffer on the 2nd kernel, then read_vmcore() reads the buffer. If the
flag is not set, read_vmcore() reads old memory as usual.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 09b7f34..c8899dc 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -158,10 +158,17 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
 			tsz = m->offset + m->size - *fpos;
 			if (buflen < tsz)
 				tsz = buflen;
-			start = m->paddr + *fpos - m->offset;
-			tmp = read_from_oldmem(buffer, tsz, &start, 1);
-			if (tmp < 0)
-				return tmp;
+			if (m->flag & MEM_TYPE_CURRENT_KERNEL) {
+				if (copy_to_user(buffer,
+						 m->buf + *fpos - m->offset,
+						 tsz))
+					return -EFAULT;
+			} else {
+				start = m->paddr + *fpos - m->offset;
+				tmp = read_from_oldmem(buffer, tsz, &start, 1);
+				if (tmp < 0)
+					return tmp;
+			}
 			buflen -= tsz;
 			*fpos += tsz;
 			buffer += tsz;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
